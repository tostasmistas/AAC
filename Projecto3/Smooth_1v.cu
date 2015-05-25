#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <sys/time.h>
#include <cuda.h>




#define N 50000
#define SMOOTH 4 
#define BLOCK_SIZE 1024

/**
* timeDiff
*
* Computes the difference (in ns) between the start and end time
*/

double timeDiff(struct timespec tStart, struct timespec tEnd)
{
	struct timespec diff;

	diff.tv_sec = tEnd.tv_sec - tStart.tv_sec - (tEnd.tv_nsec<tStart.tv_nsec ? 1 : 0);
	diff.tv_nsec = tEnd.tv_nsec - tStart.tv_nsec + (tEnd.tv_nsec<tStart.tv_nsec ? 1000000000 : 0);

	return ((double)diff.tv_sec) + ((double)diff.tv_nsec) / 1e9;
}

float randn()
{
	float x1, x2, w, y1;
	do
	{
		x1 = (float)(2.0 * rand() / RAND_MAX - 1.0);
		x2 = (float)(2.0 * rand() / RAND_MAX - 1.0);
		w = x1 * x1 + x2 * x2;
	} while (w >= 1.0);

	w = (float)sqrt((-2.0 * log(w)) / w);
	y1 = x1 * w;
	return y1;
}

float function(float b, float c) {
	return (float)(sinf(0.02 *b) + sinf(0.001*b) + 0.1*c);
}


__global__ void funtion_smooth(float *x, float *y, float *yest, int n){
	int i = blockIdx.x* blockDim.x + threadIdx.x;
	float sumA=0.0, sumB=0.0;

	
	if (i < n){
		for (int j = 0; j < n ;j++){
			sumA = sumA + ((expf(-powf((x[i] - x[j]), 2) / (2 * powf(SMOOTH, 2)))) * y[j]);
			sumB = sumB + (expf(-powf((x[i] - x[j]), 2) / (2 * powf(SMOOTH, 2))));
		}
	yest[i] = sumA / sumB;
	}

	

}
int main() {

	float *x, *y, *yest_cpu,*yest_gpu, *randomArray;
	float *d_x, *d_y, *d_yest;
	float sumA, sumB;
	char outputFilenamey[] = "y.txt";
	char outputFilenameyestcpu[] = "yest_c.txt";
	char outputFilenameyestgpu[] = "yest_g.txt";
	FILE *ofpy, *ofpyestcpu, *ofpyestgpu;

	struct timespec timeVect[7];
	double timeCPU, timeGPU[7];

	x = (float *)malloc(N*sizeof(float));
	y = (float *)malloc(N*sizeof(float));
	yest_gpu = (float *)malloc(N*sizeof(float));
	yest_cpu = (float *)malloc(N*sizeof(float));
	randomArray = (float *)malloc(N*sizeof(float));


	for (int i = 0; i < N; ++i) {
		x[i] = (float)i / 10;
		randomArray[i] = randn();
		y[i] = function((float)x[i], (float)randomArray[i]);
	}

	/*Corre no cpu*/
	printf("Performing the computation on the CPU...\n");
	clock_gettime(CLOCK_REALTIME, &timeVect[0]);
	
	for (int i = 0; i < N; ++i) { //percorrer o yest
		sumA = 0;
		for (int j = 0; j < N; ++j) { //percorer o input dataset
			sumA = sumA + ((expf(-powf((x[i] - x[j]), 2) / (2 * powf(SMOOTH, 2)))) * y[j]);
		}
		sumB = 0;
		for (int j = 0; j < N; ++j)	{ //percorer o input dataset
			sumB = sumB + expf(-powf((x[i] - x[j]), 2) / (2 * powf(SMOOTH, 2)));
		}
		yest_cpu[i] = sumA / sumB;
	}
	clock_gettime(CLOCK_REALTIME, &timeVect[1]);
	timeCPU = timeDiff(timeVect[0], timeVect[1]);
	printf("    ... execution took %.6f seconds\n", timeCPU);

	printf("----------------------------------------------------------------------------\n");
	printf("Performing the computation on the GPU...\n");
	
	clock_gettime(CLOCK_REALTIME, &timeVect[0]);
	cudaFree(0);
	clock_gettime(CLOCK_REALTIME, &timeVect[1]);


	cudaMalloc(&d_x, N*sizeof(float));
	cudaMalloc(&d_y, N*sizeof(float));
	cudaMalloc(&d_yest, N *sizeof(float));
	clock_gettime(CLOCK_REALTIME, &timeVect[2]);
	
	cudaMemcpy(d_x, x, N*sizeof(float), cudaMemcpyHostToDevice);
	cudaMemcpy(d_y, y, N*sizeof(float), cudaMemcpyHostToDevice);
	clock_gettime(CLOCK_REALTIME, &timeVect[3]);

	dim3 dimBlock(BLOCK_SIZE, 1, 1);
	dim3 dimGrid(N / BLOCK_SIZE + 1, 1, 1);

	funtion_smooth <<< dimGrid, dimBlock >>>(d_x, d_y, d_yest, N);
	clock_gettime(CLOCK_REALTIME, &timeVect[4]);

	cudaMemcpy(yest_gpu, d_yest, N*sizeof(float), cudaMemcpyDeviceToHost);
	clock_gettime(CLOCK_REALTIME, &timeVect[5]);
	cudaFree(d_x);
	cudaFree(d_y);
	cudaFree(d_yest);
	clock_gettime(CLOCK_REALTIME, &timeVect[6]);
	
	timeGPU[0] = timeDiff(timeVect[0], timeVect[1]);
	timeGPU[1] = timeDiff(timeVect[1], timeVect[2]);
	timeGPU[2] = timeDiff(timeVect[2], timeVect[3]);
	timeGPU[3] = timeDiff(timeVect[3], timeVect[4]);
	timeGPU[4] = timeDiff(timeVect[4], timeVect[5]);
	timeGPU[5] = timeDiff(timeVect[5], timeVect[6]);
	timeGPU[6] = timeDiff(timeVect[0], timeVect[6]);
	printf("    ... execution took %.6f seconds (speedup=%.3f), corresponging to:\n", timeGPU[6], timeCPU / timeGPU[6]);
	printf("          - first call to the device           -> %.6f seconds\n", timeGPU[0]);
	printf("          - allocation of memory on the device -> %.6f seconds\n", timeGPU[1]);
	printf("          - copying data from host to device   -> %.6f seconds\n", timeGPU[2]);
	printf("          - kernel execution on the device     -> %.6f seconds\n", timeGPU[3]);
	printf("          - copying data from device to host   -> %.6f seconds\n", timeGPU[4]);
	printf("          - freeing data on the device         -> %.6f seconds\n", timeGPU[5]);
	printf("----------------------------------------------------------------------------\n");

	ofpyestcpu = fopen(outputFilenameyestcpu, "w");
	ofpy = fopen(outputFilenamey, "w");
	ofpyestgpu = fopen(outputFilenameyestgpu, "w");

	for (int j = 0; j < N; ++j){
		fprintf(ofpy, "%f\n", y[j]);
		fprintf(ofpyestcpu, "%f\n", yest_cpu[j]);
		fprintf(ofpyestgpu, "%f\n", yest_gpu[j]);
	}

	fclose(ofpyestcpu);
	fclose(ofpyestgpu);
	fclose(ofpy);
	free(x);
	free(y);
	free(yest_cpu);
	free(yest_gpu);
	free(randomArray);
	


	return 0;
}
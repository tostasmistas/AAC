#include <stdlib.h>
#include <stdio.h>
#include <math.h>

int smooth = 4;

float x[N] = {0};
float y[N] = {0};
float yest[N] = {0};

float function(float x, float randomValue) {
	return sin(0.02 * x) + sin(0.001*x) + 0.1*randomValue;	
}

int main() {
	for (int i = 0; i < N; ++i) {
		x[i] = i/10;
		randomArray[i] = rand();
		y[i] = function(x[i], randomArray[i]);
	}

	for (int i = 0; i < N; ++i) { //percorrer o yest
		int sumA = 0;
		for (int j = 0; j < N; ++i) { //percorer o input dataset
			sumA = sumA + exp(pow(-((x[i]-x[j]),2))/(2*pow(smooth,2))) * y[i];
		}
		int sumB=0;
		for (int j = 0; j < N; ++i) { //percorer o input dataset
			sumB = sumB + exp(pow(-((x[i]-x[j]),2))/(2*pow(smooth,2)));
		}
		yest[i] = sumA / sumB;
	};
	return 0;
}
/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0xc3576ebc */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/Users/margarida/Downloads/git/AAC/uRisc_xilinx_1/IF.vhd";
extern char *IEEE_P_3620187407;
extern char *IEEE_P_2592010699;

char *ieee_p_3620187407_sub_767668596_3965413181(char *, char *, char *, char *, char *, char *);


static void work_a_0450616799_3212880686_p_0(char *t0)
{
    char t5[16];
    char t19[16];
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    unsigned int t11;
    unsigned int t12;
    unsigned char t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    unsigned int t26;
    unsigned int t27;
    unsigned char t28;
    char *t29;
    char *t30;
    char *t31;
    char *t32;
    char *t33;
    char *t34;

LAB0:    xsi_set_current_line(46, ng0);
    t1 = (t0 + 1832U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)2);
    if (t4 != 0)
        goto LAB3;

LAB4:
LAB7:    t20 = (t0 + 2152U);
    t21 = *((char **)t20);
    t20 = (t0 + 11188U);
    t22 = (t0 + 1672U);
    t23 = *((char **)t22);
    t22 = (t0 + 11172U);
    t24 = ieee_p_3620187407_sub_767668596_3965413181(IEEE_P_3620187407, t19, t21, t20, t23, t22);
    t25 = (t19 + 12U);
    t26 = *((unsigned int *)t25);
    t27 = (1U * t26);
    t28 = (12U != t27);
    if (t28 == 1)
        goto LAB9;

LAB10:    t29 = (t0 + 7360);
    t30 = (t29 + 56U);
    t31 = *((char **)t30);
    t32 = (t31 + 56U);
    t33 = *((char **)t32);
    memcpy(t33, t24, 12U);
    xsi_driver_first_trans_fast(t29);

LAB2:    t34 = (t0 + 7168);
    *((int *)t34) = 1;

LAB1:    return;
LAB3:    t1 = (t0 + 2152U);
    t6 = *((char **)t1);
    t1 = (t0 + 11188U);
    t7 = (t0 + 3888U);
    t8 = *((char **)t7);
    t7 = (t0 + 11348U);
    t9 = ieee_p_3620187407_sub_767668596_3965413181(IEEE_P_3620187407, t5, t6, t1, t8, t7);
    t10 = (t5 + 12U);
    t11 = *((unsigned int *)t10);
    t12 = (1U * t11);
    t13 = (12U != t12);
    if (t13 == 1)
        goto LAB5;

LAB6:    t14 = (t0 + 7360);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    memcpy(t18, t9, 12U);
    xsi_driver_first_trans_fast(t14);
    goto LAB2;

LAB5:    xsi_size_not_matching(12U, t12, 0);
    goto LAB6;

LAB8:    goto LAB2;

LAB9:    xsi_size_not_matching(12U, t27, 0);
    goto LAB10;

}

static void work_a_0450616799_3212880686_p_1(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;

LAB0:    xsi_set_current_line(50, ng0);
    t1 = (t0 + 1992U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)2);
    if (t4 != 0)
        goto LAB3;

LAB4:
LAB5:    t10 = (t0 + 1352U);
    t11 = *((char **)t10);
    t10 = (t0 + 7424);
    t12 = (t10 + 56U);
    t13 = *((char **)t12);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    memcpy(t15, t11, 12U);
    xsi_driver_first_trans_fast(t10);

LAB2:    t16 = (t0 + 7184);
    *((int *)t16) = 1;

LAB1:    return;
LAB3:    t1 = (t0 + 3112U);
    t5 = *((char **)t1);
    t1 = (t0 + 7424);
    t6 = (t1 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t5, 12U);
    xsi_driver_first_trans_fast(t1);
    goto LAB2;

LAB6:    goto LAB2;

}

static void work_a_0450616799_3212880686_p_2(char *t0)
{
    unsigned char t1;
    char *t2;
    unsigned char t3;
    char *t4;
    char *t5;
    unsigned char t6;
    unsigned char t7;
    char *t8;
    unsigned char t9;
    unsigned char t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;

LAB0:    xsi_set_current_line(59, ng0);
    t2 = (t0 + 992U);
    t3 = xsi_signal_has_event(t2);
    if (t3 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB2;

LAB4:
LAB3:    t2 = (t0 + 7200);
    *((int *)t2) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(60, ng0);
    t4 = (t0 + 1192U);
    t8 = *((char **)t4);
    t9 = *((unsigned char *)t8);
    t10 = (t9 == (unsigned char)3);
    if (t10 != 0)
        goto LAB8;

LAB10:    xsi_set_current_line(63, ng0);
    t2 = (t0 + 3272U);
    t4 = *((char **)t2);
    t2 = (t0 + 7488);
    t5 = (t2 + 56U);
    t8 = *((char **)t5);
    t11 = (t8 + 56U);
    t12 = *((char **)t11);
    memcpy(t12, t4, 12U);
    xsi_driver_first_trans_fast(t2);

LAB9:    goto LAB3;

LAB5:    t4 = (t0 + 1032U);
    t5 = *((char **)t4);
    t6 = *((unsigned char *)t5);
    t7 = (t6 == (unsigned char)3);
    t1 = t7;
    goto LAB7;

LAB8:    xsi_set_current_line(61, ng0);
    t4 = (t0 + 4128U);
    t11 = *((char **)t4);
    t4 = (t0 + 7488);
    t12 = (t4 + 56U);
    t13 = *((char **)t12);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    memcpy(t15, t11, 12U);
    xsi_driver_first_trans_fast(t4);
    goto LAB9;

}

static void work_a_0450616799_3212880686_p_3(char *t0)
{
    char t16[16];
    unsigned char t1;
    char *t2;
    unsigned char t3;
    char *t4;
    char *t5;
    unsigned char t6;
    unsigned char t7;
    char *t8;
    unsigned char t9;
    unsigned char t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    unsigned int t17;
    char *t18;
    char *t19;

LAB0:    xsi_set_current_line(78, ng0);
    t2 = (t0 + 992U);
    t3 = xsi_signal_has_event(t2);
    if (t3 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB2;

LAB4:
LAB3:    t2 = (t0 + 7216);
    *((int *)t2) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(79, ng0);
    t4 = (t0 + 1192U);
    t8 = *((char **)t4);
    t9 = *((unsigned char *)t8);
    t10 = (t9 == (unsigned char)3);
    if (t10 != 0)
        goto LAB8;

LAB10:    xsi_set_current_line(82, ng0);
    t2 = (t0 + 2312U);
    t4 = *((char **)t2);
    t2 = (t0 + 3112U);
    t5 = *((char **)t2);
    t8 = ((IEEE_P_2592010699) + 4024);
    t11 = (t0 + 11204U);
    t12 = (t0 + 11284U);
    t2 = xsi_base_array_concat(t2, t16, t8, (char)97, t4, t11, (char)97, t5, t12, (char)101);
    t17 = (16U + 12U);
    t1 = (28U != t17);
    if (t1 == 1)
        goto LAB11;

LAB12:    t13 = (t0 + 7552);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    t18 = (t15 + 56U);
    t19 = *((char **)t18);
    memcpy(t19, t2, 28U);
    xsi_driver_first_trans_fast(t13);

LAB9:    goto LAB3;

LAB5:    t4 = (t0 + 1032U);
    t5 = *((char **)t4);
    t6 = *((unsigned char *)t5);
    t7 = (t6 == (unsigned char)3);
    t1 = t7;
    goto LAB7;

LAB8:    xsi_set_current_line(80, ng0);
    t4 = (t0 + 4008U);
    t11 = *((char **)t4);
    t4 = (t0 + 7552);
    t12 = (t4 + 56U);
    t13 = *((char **)t12);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    memcpy(t15, t11, 28U);
    xsi_driver_first_trans_fast(t4);
    goto LAB9;

LAB11:    xsi_size_not_matching(28U, t17, 0);
    goto LAB12;

}

static void work_a_0450616799_3212880686_p_4(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    xsi_set_current_line(90, ng0);

LAB3:    t1 = (t0 + 3432U);
    t2 = *((char **)t1);
    t1 = (t0 + 7616);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    memcpy(t6, t2, 12U);
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t7 = (t0 + 7232);
    *((int *)t7) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_0450616799_3212880686_p_5(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    xsi_set_current_line(91, ng0);

LAB3:    t1 = (t0 + 3432U);
    t2 = *((char **)t1);
    t1 = (t0 + 7680);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    memcpy(t6, t2, 12U);
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t7 = (t0 + 7248);
    *((int *)t7) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_0450616799_3212880686_p_6(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    xsi_set_current_line(92, ng0);

LAB3:    t1 = (t0 + 3432U);
    t2 = *((char **)t1);
    t1 = (t0 + 7744);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    memcpy(t6, t2, 12U);
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t7 = (t0 + 7264);
    *((int *)t7) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_0450616799_3212880686_p_7(char *t0)
{
    char t13[16];
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t14;
    char *t15;
    char *t16;
    unsigned int t17;
    unsigned char t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;

LAB0:    xsi_set_current_line(93, ng0);
    t1 = (t0 + 1512U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)2);
    if (t4 != 0)
        goto LAB3;

LAB4:
LAB5:    t10 = (t0 + 2312U);
    t11 = *((char **)t10);
    t10 = (t0 + 3112U);
    t12 = *((char **)t10);
    t14 = ((IEEE_P_2592010699) + 4024);
    t15 = (t0 + 11204U);
    t16 = (t0 + 11284U);
    t10 = xsi_base_array_concat(t10, t13, t14, (char)97, t11, t15, (char)97, t12, t16, (char)101);
    t17 = (16U + 12U);
    t18 = (28U != t17);
    if (t18 == 1)
        goto LAB7;

LAB8:    t19 = (t0 + 7808);
    t20 = (t19 + 56U);
    t21 = *((char **)t20);
    t22 = (t21 + 56U);
    t23 = *((char **)t22);
    memcpy(t23, t10, 28U);
    xsi_driver_first_trans_fast_port(t19);

LAB2:    t24 = (t0 + 7280);
    *((int *)t24) = 1;

LAB1:    return;
LAB3:    t1 = (t0 + 3592U);
    t5 = *((char **)t1);
    t1 = (t0 + 7808);
    t6 = (t1 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t5, 28U);
    xsi_driver_first_trans_fast_port(t1);
    goto LAB2;

LAB6:    goto LAB2;

LAB7:    xsi_size_not_matching(28U, t17, 0);
    goto LAB8;

}


extern void work_a_0450616799_3212880686_init()
{
	static char *pe[] = {(void *)work_a_0450616799_3212880686_p_0,(void *)work_a_0450616799_3212880686_p_1,(void *)work_a_0450616799_3212880686_p_2,(void *)work_a_0450616799_3212880686_p_3,(void *)work_a_0450616799_3212880686_p_4,(void *)work_a_0450616799_3212880686_p_5,(void *)work_a_0450616799_3212880686_p_6,(void *)work_a_0450616799_3212880686_p_7};
	xsi_register_didat("work_a_0450616799_3212880686", "isim/test_isim_beh.exe.sim/work/a_0450616799_3212880686.didat");
	xsi_register_executes(pe);
}

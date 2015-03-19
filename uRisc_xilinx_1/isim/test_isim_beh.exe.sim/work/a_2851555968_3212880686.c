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
static const char *ng0 = "C:/Users/margarida/Downloads/git/AAC/uRisc_xilinx_1/registos.vhd";



static void work_a_2851555968_3212880686_p_0(char *t0)
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
    unsigned int t16;
    char *t17;
    char *t18;

LAB0:    xsi_set_current_line(62, ng0);
    t2 = (t0 + 992U);
    t3 = xsi_signal_has_event(t2);
    if (t3 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB2;

LAB4:
LAB3:    t2 = (t0 + 9392);
    *((int *)t2) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(63, ng0);
    t4 = (t0 + 1192U);
    t8 = *((char **)t4);
    t9 = *((unsigned char *)t8);
    t10 = (t9 == (unsigned char)3);
    if (t10 != 0)
        goto LAB8;

LAB10:    t2 = (t0 + 1352U);
    t4 = *((char **)t2);
    t2 = (t0 + 15318);
    t1 = 1;
    if (8U == 8U)
        goto LAB13;

LAB14:    t1 = 0;

LAB15:    if (t1 != 0)
        goto LAB11;

LAB12:
LAB9:    goto LAB3;

LAB5:    t4 = (t0 + 1032U);
    t5 = *((char **)t4);
    t6 = *((unsigned char *)t5);
    t7 = (t6 == (unsigned char)3);
    t1 = t7;
    goto LAB7;

LAB8:    xsi_set_current_line(64, ng0);
    t4 = (t0 + 4368U);
    t11 = *((char **)t4);
    t4 = (t0 + 9712);
    t12 = (t4 + 56U);
    t13 = *((char **)t12);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    memcpy(t15, t11, 16U);
    xsi_driver_first_trans_fast(t4);
    goto LAB9;

LAB11:    xsi_set_current_line(66, ng0);
    t12 = (t0 + 1512U);
    t13 = *((char **)t12);
    t12 = (t0 + 9712);
    t14 = (t12 + 56U);
    t15 = *((char **)t14);
    t17 = (t15 + 56U);
    t18 = *((char **)t17);
    memcpy(t18, t13, 16U);
    xsi_driver_first_trans_fast(t12);
    goto LAB9;

LAB13:    t16 = 0;

LAB16:    if (t16 < 8U)
        goto LAB17;
    else
        goto LAB15;

LAB17:    t8 = (t4 + t16);
    t11 = (t2 + t16);
    if (*((unsigned char *)t8) != *((unsigned char *)t11))
        goto LAB14;

LAB18:    t16 = (t16 + 1);
    goto LAB16;

}

static void work_a_2851555968_3212880686_p_1(char *t0)
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
    unsigned int t16;
    char *t17;
    char *t18;

LAB0:    xsi_set_current_line(74, ng0);
    t2 = (t0 + 992U);
    t3 = xsi_signal_has_event(t2);
    if (t3 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB2;

LAB4:
LAB3:    t2 = (t0 + 9408);
    *((int *)t2) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(75, ng0);
    t4 = (t0 + 1192U);
    t8 = *((char **)t4);
    t9 = *((unsigned char *)t8);
    t10 = (t9 == (unsigned char)3);
    if (t10 != 0)
        goto LAB8;

LAB10:    t2 = (t0 + 1352U);
    t4 = *((char **)t2);
    t2 = (t0 + 15326);
    t1 = 1;
    if (8U == 8U)
        goto LAB13;

LAB14:    t1 = 0;

LAB15:    if (t1 != 0)
        goto LAB11;

LAB12:
LAB9:    goto LAB3;

LAB5:    t4 = (t0 + 1032U);
    t5 = *((char **)t4);
    t6 = *((unsigned char *)t5);
    t7 = (t6 == (unsigned char)3);
    t1 = t7;
    goto LAB7;

LAB8:    xsi_set_current_line(76, ng0);
    t4 = (t0 + 4368U);
    t11 = *((char **)t4);
    t4 = (t0 + 9776);
    t12 = (t4 + 56U);
    t13 = *((char **)t12);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    memcpy(t15, t11, 16U);
    xsi_driver_first_trans_fast(t4);
    goto LAB9;

LAB11:    xsi_set_current_line(78, ng0);
    t12 = (t0 + 1512U);
    t13 = *((char **)t12);
    t12 = (t0 + 9776);
    t14 = (t12 + 56U);
    t15 = *((char **)t14);
    t17 = (t15 + 56U);
    t18 = *((char **)t17);
    memcpy(t18, t13, 16U);
    xsi_driver_first_trans_fast(t12);
    goto LAB9;

LAB13:    t16 = 0;

LAB16:    if (t16 < 8U)
        goto LAB17;
    else
        goto LAB15;

LAB17:    t8 = (t4 + t16);
    t11 = (t2 + t16);
    if (*((unsigned char *)t8) != *((unsigned char *)t11))
        goto LAB14;

LAB18:    t16 = (t16 + 1);
    goto LAB16;

}

static void work_a_2851555968_3212880686_p_2(char *t0)
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
    unsigned int t16;
    char *t17;
    char *t18;

LAB0:    xsi_set_current_line(86, ng0);
    t2 = (t0 + 992U);
    t3 = xsi_signal_has_event(t2);
    if (t3 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB2;

LAB4:
LAB3:    t2 = (t0 + 9424);
    *((int *)t2) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(87, ng0);
    t4 = (t0 + 1192U);
    t8 = *((char **)t4);
    t9 = *((unsigned char *)t8);
    t10 = (t9 == (unsigned char)3);
    if (t10 != 0)
        goto LAB8;

LAB10:    t2 = (t0 + 1352U);
    t4 = *((char **)t2);
    t2 = (t0 + 15334);
    t1 = 1;
    if (8U == 8U)
        goto LAB13;

LAB14:    t1 = 0;

LAB15:    if (t1 != 0)
        goto LAB11;

LAB12:
LAB9:    goto LAB3;

LAB5:    t4 = (t0 + 1032U);
    t5 = *((char **)t4);
    t6 = *((unsigned char *)t5);
    t7 = (t6 == (unsigned char)3);
    t1 = t7;
    goto LAB7;

LAB8:    xsi_set_current_line(88, ng0);
    t4 = (t0 + 4368U);
    t11 = *((char **)t4);
    t4 = (t0 + 9840);
    t12 = (t4 + 56U);
    t13 = *((char **)t12);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    memcpy(t15, t11, 16U);
    xsi_driver_first_trans_fast(t4);
    goto LAB9;

LAB11:    xsi_set_current_line(90, ng0);
    t12 = (t0 + 1512U);
    t13 = *((char **)t12);
    t12 = (t0 + 9840);
    t14 = (t12 + 56U);
    t15 = *((char **)t14);
    t17 = (t15 + 56U);
    t18 = *((char **)t17);
    memcpy(t18, t13, 16U);
    xsi_driver_first_trans_fast(t12);
    goto LAB9;

LAB13:    t16 = 0;

LAB16:    if (t16 < 8U)
        goto LAB17;
    else
        goto LAB15;

LAB17:    t8 = (t4 + t16);
    t11 = (t2 + t16);
    if (*((unsigned char *)t8) != *((unsigned char *)t11))
        goto LAB14;

LAB18:    t16 = (t16 + 1);
    goto LAB16;

}

static void work_a_2851555968_3212880686_p_3(char *t0)
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
    unsigned int t16;
    char *t17;
    char *t18;

LAB0:    xsi_set_current_line(98, ng0);
    t2 = (t0 + 992U);
    t3 = xsi_signal_has_event(t2);
    if (t3 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB2;

LAB4:
LAB3:    t2 = (t0 + 9440);
    *((int *)t2) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(99, ng0);
    t4 = (t0 + 1192U);
    t8 = *((char **)t4);
    t9 = *((unsigned char *)t8);
    t10 = (t9 == (unsigned char)3);
    if (t10 != 0)
        goto LAB8;

LAB10:    t2 = (t0 + 1352U);
    t4 = *((char **)t2);
    t2 = (t0 + 15342);
    t1 = 1;
    if (8U == 8U)
        goto LAB13;

LAB14:    t1 = 0;

LAB15:    if (t1 != 0)
        goto LAB11;

LAB12:
LAB9:    goto LAB3;

LAB5:    t4 = (t0 + 1032U);
    t5 = *((char **)t4);
    t6 = *((unsigned char *)t5);
    t7 = (t6 == (unsigned char)3);
    t1 = t7;
    goto LAB7;

LAB8:    xsi_set_current_line(100, ng0);
    t4 = (t0 + 4368U);
    t11 = *((char **)t4);
    t4 = (t0 + 9904);
    t12 = (t4 + 56U);
    t13 = *((char **)t12);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    memcpy(t15, t11, 16U);
    xsi_driver_first_trans_fast(t4);
    goto LAB9;

LAB11:    xsi_set_current_line(102, ng0);
    t12 = (t0 + 1512U);
    t13 = *((char **)t12);
    t12 = (t0 + 9904);
    t14 = (t12 + 56U);
    t15 = *((char **)t14);
    t17 = (t15 + 56U);
    t18 = *((char **)t17);
    memcpy(t18, t13, 16U);
    xsi_driver_first_trans_fast(t12);
    goto LAB9;

LAB13:    t16 = 0;

LAB16:    if (t16 < 8U)
        goto LAB17;
    else
        goto LAB15;

LAB17:    t8 = (t4 + t16);
    t11 = (t2 + t16);
    if (*((unsigned char *)t8) != *((unsigned char *)t11))
        goto LAB14;

LAB18:    t16 = (t16 + 1);
    goto LAB16;

}

static void work_a_2851555968_3212880686_p_4(char *t0)
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
    unsigned int t16;
    char *t17;
    char *t18;

LAB0:    xsi_set_current_line(110, ng0);
    t2 = (t0 + 992U);
    t3 = xsi_signal_has_event(t2);
    if (t3 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB2;

LAB4:
LAB3:    t2 = (t0 + 9456);
    *((int *)t2) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(111, ng0);
    t4 = (t0 + 1192U);
    t8 = *((char **)t4);
    t9 = *((unsigned char *)t8);
    t10 = (t9 == (unsigned char)3);
    if (t10 != 0)
        goto LAB8;

LAB10:    t2 = (t0 + 1352U);
    t4 = *((char **)t2);
    t2 = (t0 + 15350);
    t1 = 1;
    if (8U == 8U)
        goto LAB13;

LAB14:    t1 = 0;

LAB15:    if (t1 != 0)
        goto LAB11;

LAB12:
LAB9:    goto LAB3;

LAB5:    t4 = (t0 + 1032U);
    t5 = *((char **)t4);
    t6 = *((unsigned char *)t5);
    t7 = (t6 == (unsigned char)3);
    t1 = t7;
    goto LAB7;

LAB8:    xsi_set_current_line(112, ng0);
    t4 = (t0 + 4368U);
    t11 = *((char **)t4);
    t4 = (t0 + 9968);
    t12 = (t4 + 56U);
    t13 = *((char **)t12);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    memcpy(t15, t11, 16U);
    xsi_driver_first_trans_fast(t4);
    goto LAB9;

LAB11:    xsi_set_current_line(114, ng0);
    t12 = (t0 + 1512U);
    t13 = *((char **)t12);
    t12 = (t0 + 9968);
    t14 = (t12 + 56U);
    t15 = *((char **)t14);
    t17 = (t15 + 56U);
    t18 = *((char **)t17);
    memcpy(t18, t13, 16U);
    xsi_driver_first_trans_fast(t12);
    goto LAB9;

LAB13:    t16 = 0;

LAB16:    if (t16 < 8U)
        goto LAB17;
    else
        goto LAB15;

LAB17:    t8 = (t4 + t16);
    t11 = (t2 + t16);
    if (*((unsigned char *)t8) != *((unsigned char *)t11))
        goto LAB14;

LAB18:    t16 = (t16 + 1);
    goto LAB16;

}

static void work_a_2851555968_3212880686_p_5(char *t0)
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
    unsigned int t16;
    char *t17;
    char *t18;

LAB0:    xsi_set_current_line(122, ng0);
    t2 = (t0 + 992U);
    t3 = xsi_signal_has_event(t2);
    if (t3 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB2;

LAB4:
LAB3:    t2 = (t0 + 9472);
    *((int *)t2) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(123, ng0);
    t4 = (t0 + 1192U);
    t8 = *((char **)t4);
    t9 = *((unsigned char *)t8);
    t10 = (t9 == (unsigned char)3);
    if (t10 != 0)
        goto LAB8;

LAB10:    t2 = (t0 + 1352U);
    t4 = *((char **)t2);
    t2 = (t0 + 15358);
    t1 = 1;
    if (8U == 8U)
        goto LAB13;

LAB14:    t1 = 0;

LAB15:    if (t1 != 0)
        goto LAB11;

LAB12:
LAB9:    goto LAB3;

LAB5:    t4 = (t0 + 1032U);
    t5 = *((char **)t4);
    t6 = *((unsigned char *)t5);
    t7 = (t6 == (unsigned char)3);
    t1 = t7;
    goto LAB7;

LAB8:    xsi_set_current_line(124, ng0);
    t4 = (t0 + 4368U);
    t11 = *((char **)t4);
    t4 = (t0 + 10032);
    t12 = (t4 + 56U);
    t13 = *((char **)t12);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    memcpy(t15, t11, 16U);
    xsi_driver_first_trans_fast(t4);
    goto LAB9;

LAB11:    xsi_set_current_line(126, ng0);
    t12 = (t0 + 1512U);
    t13 = *((char **)t12);
    t12 = (t0 + 10032);
    t14 = (t12 + 56U);
    t15 = *((char **)t14);
    t17 = (t15 + 56U);
    t18 = *((char **)t17);
    memcpy(t18, t13, 16U);
    xsi_driver_first_trans_fast(t12);
    goto LAB9;

LAB13:    t16 = 0;

LAB16:    if (t16 < 8U)
        goto LAB17;
    else
        goto LAB15;

LAB17:    t8 = (t4 + t16);
    t11 = (t2 + t16);
    if (*((unsigned char *)t8) != *((unsigned char *)t11))
        goto LAB14;

LAB18:    t16 = (t16 + 1);
    goto LAB16;

}

static void work_a_2851555968_3212880686_p_6(char *t0)
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
    unsigned int t16;
    char *t17;
    char *t18;

LAB0:    xsi_set_current_line(134, ng0);
    t2 = (t0 + 992U);
    t3 = xsi_signal_has_event(t2);
    if (t3 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB2;

LAB4:
LAB3:    t2 = (t0 + 9488);
    *((int *)t2) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(135, ng0);
    t4 = (t0 + 1192U);
    t8 = *((char **)t4);
    t9 = *((unsigned char *)t8);
    t10 = (t9 == (unsigned char)3);
    if (t10 != 0)
        goto LAB8;

LAB10:    t2 = (t0 + 1352U);
    t4 = *((char **)t2);
    t2 = (t0 + 15366);
    t1 = 1;
    if (8U == 8U)
        goto LAB13;

LAB14:    t1 = 0;

LAB15:    if (t1 != 0)
        goto LAB11;

LAB12:
LAB9:    goto LAB3;

LAB5:    t4 = (t0 + 1032U);
    t5 = *((char **)t4);
    t6 = *((unsigned char *)t5);
    t7 = (t6 == (unsigned char)3);
    t1 = t7;
    goto LAB7;

LAB8:    xsi_set_current_line(136, ng0);
    t4 = (t0 + 4368U);
    t11 = *((char **)t4);
    t4 = (t0 + 10096);
    t12 = (t4 + 56U);
    t13 = *((char **)t12);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    memcpy(t15, t11, 16U);
    xsi_driver_first_trans_fast(t4);
    goto LAB9;

LAB11:    xsi_set_current_line(138, ng0);
    t12 = (t0 + 1512U);
    t13 = *((char **)t12);
    t12 = (t0 + 10096);
    t14 = (t12 + 56U);
    t15 = *((char **)t14);
    t17 = (t15 + 56U);
    t18 = *((char **)t17);
    memcpy(t18, t13, 16U);
    xsi_driver_first_trans_fast(t12);
    goto LAB9;

LAB13:    t16 = 0;

LAB16:    if (t16 < 8U)
        goto LAB17;
    else
        goto LAB15;

LAB17:    t8 = (t4 + t16);
    t11 = (t2 + t16);
    if (*((unsigned char *)t8) != *((unsigned char *)t11))
        goto LAB14;

LAB18:    t16 = (t16 + 1);
    goto LAB16;

}

static void work_a_2851555968_3212880686_p_7(char *t0)
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
    unsigned int t16;
    char *t17;
    char *t18;

LAB0:    xsi_set_current_line(146, ng0);
    t2 = (t0 + 992U);
    t3 = xsi_signal_has_event(t2);
    if (t3 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB2;

LAB4:
LAB3:    t2 = (t0 + 9504);
    *((int *)t2) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(147, ng0);
    t4 = (t0 + 1192U);
    t8 = *((char **)t4);
    t9 = *((unsigned char *)t8);
    t10 = (t9 == (unsigned char)3);
    if (t10 != 0)
        goto LAB8;

LAB10:    t2 = (t0 + 1352U);
    t4 = *((char **)t2);
    t2 = (t0 + 15374);
    t1 = 1;
    if (8U == 8U)
        goto LAB13;

LAB14:    t1 = 0;

LAB15:    if (t1 != 0)
        goto LAB11;

LAB12:
LAB9:    goto LAB3;

LAB5:    t4 = (t0 + 1032U);
    t5 = *((char **)t4);
    t6 = *((unsigned char *)t5);
    t7 = (t6 == (unsigned char)3);
    t1 = t7;
    goto LAB7;

LAB8:    xsi_set_current_line(148, ng0);
    t4 = (t0 + 4368U);
    t11 = *((char **)t4);
    t4 = (t0 + 10160);
    t12 = (t4 + 56U);
    t13 = *((char **)t12);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    memcpy(t15, t11, 16U);
    xsi_driver_first_trans_fast(t4);
    goto LAB9;

LAB11:    xsi_set_current_line(150, ng0);
    t12 = (t0 + 1512U);
    t13 = *((char **)t12);
    t12 = (t0 + 10160);
    t14 = (t12 + 56U);
    t15 = *((char **)t14);
    t17 = (t15 + 56U);
    t18 = *((char **)t17);
    memcpy(t18, t13, 16U);
    xsi_driver_first_trans_fast(t12);
    goto LAB9;

LAB13:    t16 = 0;

LAB16:    if (t16 < 8U)
        goto LAB17;
    else
        goto LAB15;

LAB17:    t8 = (t4 + t16);
    t11 = (t2 + t16);
    if (*((unsigned char *)t8) != *((unsigned char *)t11))
        goto LAB14;

LAB18:    t16 = (t16 + 1);
    goto LAB16;

}

static void work_a_2851555968_3212880686_p_8(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    xsi_set_current_line(160, ng0);

LAB3:    t1 = (t0 + 2952U);
    t2 = *((char **)t1);
    t1 = (t0 + 10224);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    memcpy(t6, t2, 16U);
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t7 = (t0 + 9520);
    *((int *)t7) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_2851555968_3212880686_p_9(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    xsi_set_current_line(161, ng0);

LAB3:    t1 = (t0 + 3112U);
    t2 = *((char **)t1);
    t1 = (t0 + 10288);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    memcpy(t6, t2, 16U);
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t7 = (t0 + 9536);
    *((int *)t7) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_2851555968_3212880686_p_10(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    xsi_set_current_line(162, ng0);

LAB3:    t1 = (t0 + 3272U);
    t2 = *((char **)t1);
    t1 = (t0 + 10352);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    memcpy(t6, t2, 16U);
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t7 = (t0 + 9552);
    *((int *)t7) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_2851555968_3212880686_p_11(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    xsi_set_current_line(163, ng0);

LAB3:    t1 = (t0 + 3432U);
    t2 = *((char **)t1);
    t1 = (t0 + 10416);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    memcpy(t6, t2, 16U);
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t7 = (t0 + 9568);
    *((int *)t7) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_2851555968_3212880686_p_12(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    xsi_set_current_line(164, ng0);

LAB3:    t1 = (t0 + 3592U);
    t2 = *((char **)t1);
    t1 = (t0 + 10480);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    memcpy(t6, t2, 16U);
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t7 = (t0 + 9584);
    *((int *)t7) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_2851555968_3212880686_p_13(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    xsi_set_current_line(165, ng0);

LAB3:    t1 = (t0 + 3752U);
    t2 = *((char **)t1);
    t1 = (t0 + 10544);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    memcpy(t6, t2, 16U);
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t7 = (t0 + 9600);
    *((int *)t7) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_2851555968_3212880686_p_14(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    xsi_set_current_line(166, ng0);

LAB3:    t1 = (t0 + 3912U);
    t2 = *((char **)t1);
    t1 = (t0 + 10608);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    memcpy(t6, t2, 16U);
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t7 = (t0 + 9616);
    *((int *)t7) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_2851555968_3212880686_p_15(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    xsi_set_current_line(167, ng0);

LAB3:    t1 = (t0 + 4072U);
    t2 = *((char **)t1);
    t1 = (t0 + 10672);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    memcpy(t6, t2, 16U);
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t7 = (t0 + 9632);
    *((int *)t7) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}


extern void work_a_2851555968_3212880686_init()
{
	static char *pe[] = {(void *)work_a_2851555968_3212880686_p_0,(void *)work_a_2851555968_3212880686_p_1,(void *)work_a_2851555968_3212880686_p_2,(void *)work_a_2851555968_3212880686_p_3,(void *)work_a_2851555968_3212880686_p_4,(void *)work_a_2851555968_3212880686_p_5,(void *)work_a_2851555968_3212880686_p_6,(void *)work_a_2851555968_3212880686_p_7,(void *)work_a_2851555968_3212880686_p_8,(void *)work_a_2851555968_3212880686_p_9,(void *)work_a_2851555968_3212880686_p_10,(void *)work_a_2851555968_3212880686_p_11,(void *)work_a_2851555968_3212880686_p_12,(void *)work_a_2851555968_3212880686_p_13,(void *)work_a_2851555968_3212880686_p_14,(void *)work_a_2851555968_3212880686_p_15};
	xsi_register_didat("work_a_2851555968_3212880686", "isim/test_isim_beh.exe.sim/work/a_2851555968_3212880686.didat");
	xsi_register_executes(pe);
}

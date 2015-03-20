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
static const char *ng0 = "C:/Users/Nmac/Documents/GitHub/AAC/uRisc_xilinx_1/memoria_RAM.vhd";
extern char *IEEE_P_2592010699;
extern char *IEEE_P_3620187407;

unsigned char ieee_p_2592010699_sub_1744673427_503743352(char *, char *, unsigned int , unsigned int );
int ieee_p_3620187407_sub_514432868_3965413181(char *, char *, char *);


static void work_a_2451804025_3212880686_p_0(char *t0)
{
    char *t1;
    unsigned char t2;
    char *t3;
    char *t4;
    unsigned char t5;
    unsigned char t6;
    char *t7;
    char *t8;
    char *t9;
    int t10;
    int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    char *t15;
    char *t16;
    char *t17;

LAB0:    xsi_set_current_line(34, ng0);
    t1 = (t0 + 992U);
    t2 = ieee_p_2592010699_sub_1744673427_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t2 != 0)
        goto LAB2;

LAB4:
LAB3:    t1 = (t0 + 3512);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(35, ng0);
    t3 = (t0 + 1192U);
    t4 = *((char **)t3);
    t5 = *((unsigned char *)t4);
    t6 = (t5 == (unsigned char)3);
    if (t6 != 0)
        goto LAB5;

LAB7:
LAB6:    xsi_set_current_line(38, ng0);
    t1 = (t0 + 2208U);
    t3 = *((char **)t1);
    t1 = (t0 + 1352U);
    t4 = *((char **)t1);
    t1 = (t0 + 6048U);
    t10 = ieee_p_3620187407_sub_514432868_3965413181(IEEE_P_3620187407, t4, t1);
    t11 = (t10 - 0);
    t12 = (t11 * 1);
    xsi_vhdl_check_range_of_index(0, 4095, 1, t10);
    t13 = (16U * t12);
    t14 = (0 + t13);
    t7 = (t3 + t14);
    t8 = (t0 + 3592);
    t9 = (t8 + 56U);
    t15 = *((char **)t9);
    t16 = (t15 + 56U);
    t17 = *((char **)t16);
    memcpy(t17, t7, 16U);
    xsi_driver_first_trans_fast_port(t8);
    goto LAB3;

LAB5:    xsi_set_current_line(36, ng0);
    t3 = (t0 + 1512U);
    t7 = *((char **)t3);
    t3 = (t0 + 2208U);
    t8 = *((char **)t3);
    t3 = (t0 + 1352U);
    t9 = *((char **)t3);
    t3 = (t0 + 6048U);
    t10 = ieee_p_3620187407_sub_514432868_3965413181(IEEE_P_3620187407, t9, t3);
    t11 = (t10 - 0);
    t12 = (t11 * 1);
    xsi_vhdl_check_range_of_index(0, 4095, 1, t10);
    t13 = (16U * t12);
    t14 = (0 + t13);
    t15 = (t8 + t14);
    memcpy(t15, t7, 16U);
    t16 = (t0 + 2152U);
    xsi_variable_act(t16);
    goto LAB6;

}


extern void work_a_2451804025_3212880686_init()
{
	static char *pe[] = {(void *)work_a_2451804025_3212880686_p_0};
	xsi_register_didat("work_a_2451804025_3212880686", "isim/test_isim_beh.exe.sim/work/a_2451804025_3212880686.didat");
	xsi_register_executes(pe);
}

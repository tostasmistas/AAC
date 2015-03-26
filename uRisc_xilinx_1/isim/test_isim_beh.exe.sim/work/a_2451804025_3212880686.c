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
extern char *STD_TEXTIO;
static const char *ng1 = "infile";
extern char *IEEE_P_2592010699;
extern char *STD_STANDARD;
extern char *IEEE_P_3564397177;
extern char *IEEE_P_3620187407;
static const char *ng6 = "M:/~ downloads ~/uRisc_xilinx_1/uRisc_xilinx_1/uRisc_xilinx_1/memoria_RAM.vhd";

unsigned char ieee_p_2592010699_sub_1744673427_503743352(char *, char *, unsigned int , unsigned int );
void ieee_p_3564397177_sub_3988856810_91900896(char *, char *, char *, char *, char *);
int ieee_p_3620187407_sub_514432868_3965413181(char *, char *, char *);


char *work_a_2451804025_3212880686_sub_2263298082_3057020925(char *t1, char *t2, char *t3)
{
    char t4[568];
    char t5[24];
    char t11[16];
    char t18[16];
    char t28[32];
    char t36[65536];
    char t45[8];
    char t51[8];
    char *t0;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t12;
    char *t13;
    int t14;
    unsigned int t15;
    char *t16;
    char *t17;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t29;
    char *t30;
    int t31;
    char *t32;
    int t33;
    char *t34;
    char *t35;
    char *t37;
    char *t38;
    char *t39;
    char *t40;
    char *t41;
    char *t42;
    char *t43;
    char *t44;
    char *t46;
    char *t47;
    char *t48;
    char *t49;
    char *t50;
    char *t52;
    char *t53;
    char *t54;
    unsigned char t55;
    char *t56;
    char *t57;
    char *t58;
    int t59;
    int t60;
    unsigned int t61;
    unsigned int t62;
    unsigned char t63;
    unsigned int t64;

LAB0:    t6 = ((STD_TEXTIO) + 3440);
    t7 = (t1 + 72002);
    t9 = (t4 + 4U);
    t10 = xsi_create_file_variable_in_buffer(0, ng1, t6, t7, 12U, 1);
    *((char **)t9) = t10;
    t12 = (t11 + 0U);
    t13 = (t12 + 0U);
    *((int *)t13) = 15;
    t13 = (t12 + 4U);
    *((int *)t13) = 0;
    t13 = (t12 + 8U);
    *((int *)t13) = -1;
    t14 = (0 - 15);
    t15 = (t14 * -1);
    t15 = (t15 + 1);
    t13 = (t12 + 12U);
    *((unsigned int *)t13) = t15;
    t13 = (t4 + 12U);
    t16 = ((IEEE_P_2592010699) + 4024);
    t17 = (t13 + 88U);
    *((char **)t17) = t16;
    t19 = (t13 + 56U);
    *((char **)t19) = t18;
    xsi_type_set_default_value(t16, t18, t11);
    t20 = (t13 + 64U);
    *((char **)t20) = t11;
    t21 = (t13 + 80U);
    *((unsigned int *)t21) = 16U;
    t22 = (t4 + 132U);
    t23 = ((STD_TEXTIO) + 3280);
    t24 = (t22 + 56U);
    *((char **)t24) = t23;
    t25 = (t22 + 40U);
    *((char **)t25) = 0;
    t26 = (t22 + 64U);
    *((int *)t26) = 1;
    t27 = (t22 + 48U);
    *((char **)t27) = 0;
    t29 = (t28 + 0U);
    t30 = (t29 + 0U);
    *((int *)t30) = 0;
    t30 = (t29 + 4U);
    *((int *)t30) = 4095;
    t30 = (t29 + 8U);
    *((int *)t30) = 1;
    t31 = (4095 - 0);
    t15 = (t31 * 1);
    t15 = (t15 + 1);
    t30 = (t29 + 12U);
    *((unsigned int *)t30) = t15;
    t30 = (t28 + 16U);
    t32 = (t30 + 0U);
    *((int *)t32) = 15;
    t32 = (t30 + 4U);
    *((int *)t32) = 0;
    t32 = (t30 + 8U);
    *((int *)t32) = -1;
    t33 = (0 - 15);
    t15 = (t33 * -1);
    t15 = (t15 + 1);
    t32 = (t30 + 12U);
    *((unsigned int *)t32) = t15;
    t32 = (t4 + 204U);
    t34 = (t1 + 4232);
    t35 = (t32 + 88U);
    *((char **)t35) = t34;
    t37 = (t32 + 56U);
    *((char **)t37) = t36;
    xsi_type_set_default_value(t34, t36, 0);
    t38 = (t32 + 64U);
    t39 = (t34 + 80U);
    t40 = *((char **)t39);
    *((char **)t38) = t40;
    t41 = (t32 + 80U);
    *((unsigned int *)t41) = 65536U;
    t42 = (t4 + 324U);
    t43 = ((STD_STANDARD) + 384);
    t44 = (t42 + 88U);
    *((char **)t44) = t43;
    t46 = (t42 + 56U);
    *((char **)t46) = t45;
    xsi_type_set_default_value(t43, t45, 0);
    t47 = (t42 + 80U);
    *((unsigned int *)t47) = 4U;
    t48 = (t4 + 444U);
    t49 = ((STD_STANDARD) + 384);
    t50 = (t48 + 88U);
    *((char **)t50) = t49;
    t52 = (t48 + 56U);
    *((char **)t52) = t51;
    xsi_type_set_default_value(t49, t51, 0);
    t53 = (t48 + 80U);
    *((unsigned int *)t53) = 4U;
    t54 = (t5 + 4U);
    t55 = (t2 != 0);
    if (t55 == 1)
        goto LAB3;

LAB2:    t56 = (t5 + 12U);
    *((char **)t56) = t3;
    t57 = (t42 + 56U);
    t58 = *((char **)t57);
    t57 = (t58 + 0);
    *((int *)t57) = 0;
    t6 = (t48 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((int *)t6) = 0;
    t6 = (t4 + 4U);
    t7 = *((char **)t6);
    std_textio_readline(STD_TEXTIO, (char *)0, t7, t22);
    t6 = (t13 + 56U);
    t7 = *((char **)t6);
    ieee_p_3564397177_sub_3988856810_91900896(IEEE_P_3564397177, (char *)0, t22, t7, t11);
    t6 = (t13 + 56U);
    t7 = *((char **)t6);
    t14 = ieee_p_3620187407_sub_514432868_3965413181(IEEE_P_3620187407, t7, t11);
    t6 = (t42 + 56U);
    t8 = *((char **)t6);
    t6 = (t8 + 0);
    *((int *)t6) = t14;
    t6 = (t42 + 56U);
    t7 = *((char **)t6);
    t14 = *((int *)t7);
    t6 = (t48 + 56U);
    t8 = *((char **)t6);
    t31 = *((int *)t8);
    t33 = t31;
    t59 = t14;

LAB4:    if (t33 <= t59)
        goto LAB5;

LAB7:
LAB9:    t6 = (t4 + 4U);
    t7 = *((char **)t6);
    t55 = std_textio_endfile(t7);
    t63 = (!(t55));
    if (t63 != 0)
        goto LAB10;

LAB12:    t6 = (t42 + 56U);
    t7 = *((char **)t6);
    t14 = *((int *)t7);
    t31 = t14;
    t33 = 4095;

LAB13:    if (t31 <= t33)
        goto LAB14;

LAB16:    t6 = (t32 + 56U);
    t7 = *((char **)t6);
    t55 = (65536U != 65536U);
    if (t55 == 1)
        goto LAB18;

LAB19:    t0 = xsi_get_transient_memory(65536U);
    memcpy(t0, t7, 65536U);

LAB1:    xsi_access_variable_delete(t22);
    t6 = (t4 + 4U);
    t7 = *((char **)t6);
    xsi_delete_file_variable(t7);
    return t0;
LAB3:    *((char **)t54) = t2;
    goto LAB2;

LAB5:    t6 = (t1 + 72014);
    t10 = (t32 + 56U);
    t12 = *((char **)t10);
    t60 = (t33 - 0);
    t15 = (t60 * 1);
    xsi_vhdl_check_range_of_index(0, 4095, 1, t33);
    t61 = (16U * t15);
    t62 = (0 + t61);
    t10 = (t12 + t62);
    memcpy(t10, t6, 16U);

LAB6:    if (t33 == t59)
        goto LAB7;

LAB8:    t14 = (t33 + 1);
    t33 = t14;
    goto LAB4;

LAB10:    t8 = (t4 + 4U);
    t9 = *((char **)t8);
    std_textio_readline(STD_TEXTIO, (char *)0, t9, t22);
    t6 = (t13 + 56U);
    t7 = *((char **)t6);
    ieee_p_3564397177_sub_3988856810_91900896(IEEE_P_3564397177, (char *)0, t22, t7, t11);
    t6 = (t13 + 56U);
    t7 = *((char **)t6);
    t6 = (t32 + 56U);
    t8 = *((char **)t6);
    t6 = (t42 + 56U);
    t9 = *((char **)t6);
    t14 = *((int *)t9);
    t31 = (t14 - 0);
    t15 = (t31 * 1);
    xsi_vhdl_check_range_of_index(0, 4095, 1, t14);
    t61 = (16U * t15);
    t62 = (0 + t61);
    t6 = (t8 + t62);
    t10 = (t11 + 12U);
    t64 = *((unsigned int *)t10);
    t64 = (t64 * 1U);
    memcpy(t6, t7, t64);
    t6 = (t42 + 56U);
    t7 = *((char **)t6);
    t14 = *((int *)t7);
    t31 = (t14 + 1);
    t6 = (t42 + 56U);
    t8 = *((char **)t6);
    t6 = (t8 + 0);
    *((int *)t6) = t31;
    goto LAB9;

LAB11:;
LAB14:    t6 = (t1 + 72030);
    t9 = (t32 + 56U);
    t10 = *((char **)t9);
    t59 = (t31 - 0);
    t15 = (t59 * 1);
    xsi_vhdl_check_range_of_index(0, 4095, 1, t31);
    t61 = (16U * t15);
    t62 = (0 + t61);
    t9 = (t10 + t62);
    memcpy(t9, t6, 16U);

LAB15:    if (t31 == t33)
        goto LAB16;

LAB17:    t14 = (t31 + 1);
    t31 = t14;
    goto LAB13;

LAB18:    xsi_size_not_matching(65536U, 65536U, 0);
    goto LAB19;

LAB20:;
}

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

LAB0:    xsi_set_current_line(61, ng6);
    t1 = (t0 + 992U);
    t2 = ieee_p_2592010699_sub_1744673427_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t2 != 0)
        goto LAB2;

LAB4:
LAB3:    t1 = (t0 + 3640);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(62, ng6);
    t3 = (t0 + 1192U);
    t4 = *((char **)t3);
    t5 = *((unsigned char *)t4);
    t6 = (t5 == (unsigned char)3);
    if (t6 != 0)
        goto LAB5;

LAB7:
LAB6:    goto LAB3;

LAB5:    xsi_set_current_line(63, ng6);
    t3 = (t0 + 1512U);
    t7 = *((char **)t3);
    t3 = (t0 + 2088U);
    t8 = *((char **)t3);
    t3 = (t0 + 1352U);
    t9 = *((char **)t3);
    t3 = (t0 + 6344U);
    t10 = ieee_p_3620187407_sub_514432868_3965413181(IEEE_P_3620187407, t9, t3);
    t11 = (t10 - 0);
    t12 = (t11 * 1);
    xsi_vhdl_check_range_of_index(0, 4095, 1, t10);
    t13 = (16U * t12);
    t14 = (0 + t13);
    t15 = (t8 + t14);
    memcpy(t15, t7, 16U);
    t16 = (t0 + 2032U);
    xsi_variable_act(t16);
    goto LAB6;

}

static void work_a_2451804025_3212880686_p_1(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    int t4;
    int t5;
    unsigned int t6;
    unsigned int t7;
    unsigned int t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;

LAB0:    xsi_set_current_line(68, ng6);

LAB3:    t1 = (t0 + 2088U);
    t2 = *((char **)t1);
    t1 = (t0 + 1352U);
    t3 = *((char **)t1);
    t1 = (t0 + 6344U);
    t4 = ieee_p_3620187407_sub_514432868_3965413181(IEEE_P_3620187407, t3, t1);
    t5 = (t4 - 0);
    t6 = (t5 * 1);
    xsi_vhdl_check_range_of_index(0, 4095, 1, t4);
    t7 = (16U * t6);
    t8 = (0 + t7);
    t9 = (t2 + t8);
    t10 = (t0 + 3736);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    memcpy(t14, t9, 16U);
    xsi_driver_first_trans_fast_port(t10);

LAB2:    t15 = (t0 + 3656);
    *((int *)t15) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}


extern void work_a_2451804025_3212880686_init()
{
	static char *pe[] = {(void *)work_a_2451804025_3212880686_p_0,(void *)work_a_2451804025_3212880686_p_1};
	static char *se[] = {(void *)work_a_2451804025_3212880686_sub_2263298082_3057020925};
	xsi_register_didat("work_a_2451804025_3212880686", "isim/test_isim_beh.exe.sim/work/a_2451804025_3212880686.didat");
	xsi_register_executes(pe);
	xsi_register_subprogram_executes(se);
}

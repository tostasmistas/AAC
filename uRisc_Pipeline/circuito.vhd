library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;


entity circuito is
  port (
    clk_in, rst_in		: in std_logic;
	 addr						: out std_logic_vector(11 downto 0);
	 saida					: out std_logic_vector(15 downto 0)
    );
end circuito;

architecture Behavioral of circuito is

	
	
	component InF
		port(
		-- input
		clk, rst 				: in std_logic;
		en_if 					: in std_logic;
		reg_pc_IN 				: in std_logic_vector(11 downto 0);		 -- PC realimentado
			Jump_BTB					: in std_logic_vector(11 downto 0);
		OUT_BTB					: in std_logic_vector(16 downto 0);
		act_BTB					: in std_logic;
		Conflit_DADOS			: in std_logic;
		en_Jump_FII				: in std_logic;
		en_Jump_Incond			: in std_logic;
		Jump_Incon				: in std_logic_vector(11 downto 0);
		pc_branch				: in std_logic_vector(11 downto 0);		-- acrescentar
		
		out_ROM					: in std_logic_vector(15 downto 0);	
		-- output
		addr_BTB_A				: out std_logic_vector(8 downto 0);
		addr_BTB_B				: out std_logic_vector(8 downto 0);
		IN_BTB					: out std_logic_vector(16 downto 0);
		we_BTB					: out std_logic;
 		reg_PCMEM_OUT			: out std_logic_vector(11 downto 0);	 -- PC + 1
		reg_pc_OUT 				: out std_logic_vector(11 downto 0);		 -- PC realimentado
		addr						: out std_logic_vector(11 downto 0);	-- PC + 1
		reg_IfOut_ROM			: out std_logic_vector(15 downto 0);
		reg_IfOut_MUX_BrPred : out std_logic;
		reg_IfOut_PC			: out std_logic_vector(11 downto 0)-- registo entre andares		
	);
	end component;
  
	component IDeOF
		port(
		-- input
		clk, rst 				: in std_logic;
		reg_IfOut_PC 			: in std_logic_vector(11 downto 0);		-- registo entre andares
		reg_IfOut_ROM 			: in std_logic_vector(15 downto 0);	
		FLAGS_IN				   : in std_logic_vector(3 downto 0);
		Forw_FLAGS_IN			: in std_logic_vector(3 downto 0);
		ADD_RWC_EXMEM			: in std_logic_vector(2 downto 0);
		ADD_RWC_WB				: in std_logic_vector(2 downto 0);
		ovWE_EXMEM				: in std_logic;
		ovWE_WB					: in std_logic;
		en_idOF	 				: in std_logic;
		R0 						: in std_logic_vector(15 downto 0);
		R1 						: in std_logic_vector(15 downto 0);
	    R2 						: in std_logic_vector(15 downto 0);
		R3 						: in std_logic_vector(15 downto 0);
		R4 						: in std_logic_vector(15 downto 0);
		R5 						: in std_logic_vector(15 downto 0);
		R6 						: in std_logic_vector(15 downto 0);
		R7 						: in std_logic_vector(15 downto 0);
		--Forwarding	
		Forw_EXMEN					: in std_logic_vector(15 downto 0);
		Forw_WB						: in std_logic_vector(15 downto 0);
		
		-- output
		en_Jump_FII					: out std_logic;
		en_Jump_Incond				: out std_logic;
		Jump_Incon					: out std_logic_vector(11 downto 0);
		pc_branch					: out std_logic_vector(11 downto 0);		-- acrescentar
		Jump_BTB						: out std_logic_vector(11 downto 0);
		act_BTB						: out std_logic;
		Conflit_ON					: out std_logic;	
		Conflit_DADOS				: out std_logic;				
		reg_IDOF_OUT_WERAM		: out std_logic;
		reg_IDOF_OUT_ALUOPER		: out std_logic_vector(4 downto 0);
		reg_IDOF_OUT_bit15		: out std_logic;
		reg_IDOF_OUT_bit14		: out std_logic;
		reg_IDOF_OUT_OperA		: out std_logic_vector(15 downto 0);
		reg_IDOF_OUT_OperB		: out std_logic_vector(15 downto 0);
		reg_IDOF_OUT_ALUvsMEM	: out std_logic;
		reg_IDOF_OUT_ovWE			: out std_logic;
		reg_IDOF_OUT_AddRWC		: out std_logic_vector(2 downto 0);
		reg_IDOF_OUT_PCadd1		: out std_logic_vector(11 downto 0);
		reg_IDOF_OUT_SelMuxWB	: out std_logic_vector(1 downto 0);
		reg_IDOF_OUT_MuxConst	: out std_logic_vector(15 downto 0)
	);
	end component;

	component EXeMEM
    	port(
		-- input
		clk, rst 						: in std_logic;
		reg_IDOF_OUT_WERAM			: in std_logic;
		reg_IDOF_OUT_ALUOPER			: in std_logic_vector(4 downto 0);
		reg_IDOF_OUT_bit15			: in std_logic;
		reg_IDOF_OUT_bit14			: in std_logic;
		reg_IDOF_OUT_OperA			: in std_logic_vector(15 downto 0);
		reg_IDOF_OUT_OperB			: in std_logic_vector(15 downto 0);
		reg_IDOF_OUT_ALUvsMEM		: in std_logic;
		reg_IDOF_OUT_ovWE				: in std_logic;
		reg_IDOF_OUT_AddRWC			: in std_logic_vector(2 downto 0);
		reg_IDOF_OUT_PCadd1			: in std_logic_vector(11 downto 0);
		reg_IDOF_OUT_SelMuxWB		: in std_logic_vector(1 downto 0);
		reg_IDOF_OUT_MuxConst		: in std_logic_vector(15 downto 0);
		FLAGS_IN							: in std_logic_vector(3 downto 0);
		out_RAM							: in std_logic_vector(15 downto 0);
		en_EX								: in std_logic;
		
		-- output
		reg_EXMEM_OUT_PCadd1			: out std_logic_vector(11 downto 0);
		reg_EXMEM_OUT_AddRWC			: out std_logic_vector(2 downto 0);
		reg_EXMEM_OUT_OutALU			: out std_logic_vector(15 downto 0);
		reg_EXMEM_OUT_OutMEM			: out std_logic_vector(15 downto 0);
		reg_EXMEM_OUT_MuxConst		: out std_logic_vector(15 downto 0);
		reg_EXMEM_OUT_ovWE			: out std_logic;
		reg_EXMEM_OUT_SelMuxWB		: out std_logic_vector(1 downto 0);

		ADD_RWC_EXMEM				: out std_logic_vector(2 downto 0);
		ovWE_EXMEM					: out std_logic;

		out_ADD_MEM					: out std_logic_vector(11 downto 0);		-- para endereçar a RAM
		out_WE_MEM					: out std_logic;							-- para controlar o WE da RAM 
		FLAGS_OUT					: out std_logic_vector(3 downto 0);
		Forw_FLAGSTEST_OUT		: out std_logic_vector(3 downto 0);
		Forw_EXMEN					: out std_logic_vector(15 downto 0);
		FLAGSTEST_OUT				: out std_logic_vector(3 downto 0);
		in_RAM						: out std_logic_vector(15 downto 0)
								
	);
  end component;
  
  component WB
  	port(
		-- input
		clk, rst 						: in std_logic;
		reg_EXMEM_OUT_PCadd1			: in std_logic_vector(11 downto 0);
		reg_EXMEM_OUT_AddRWC			: in std_logic_vector(2 downto 0);
		reg_EXMEM_OUT_OutALU			: in std_logic_vector(15 downto 0);
		reg_EXMEM_OUT_OutMEM			: in std_logic_vector(15 downto 0);
		reg_EXMEM_OUT_MuxConst		: in std_logic_vector(15 downto 0);
		reg_EXMEM_OUT_ovWE			: in std_logic;
		reg_EXMEM_OUT_SelMuxWB		: in std_logic_vector(1 downto 0);
		
		
		-- output
		ADD_RWC_WB					: out std_logic_vector(2 downto 0);
		ovWE_WB						: out std_logic;
		Forw_WB						: out std_logic_vector(15 downto 0);
		out_mux_WB					: out std_logic_vector(15 downto 0);
		out_saida					: out std_logic_vector(15 downto 0);
		en_regs						: out std_logic_vector(7 downto 0)
	);
  end component;
  
  component registos
    port(
		-- input
		clk,rst						: in std_logic;
		en_regs					: in std_logic_vector(7 downto 0);
		out_mux_WB				: in std_logic_vector(15 downto 0);
		-- colocar registo entre andares e la colocar o vector do en_regs do WB
			
		-- output
		R0 						: out std_logic_vector(15 downto 0);
		R1 						: out std_logic_vector(15 downto 0);
		R2 						: out std_logic_vector(15 downto 0);
		R3 						: out std_logic_vector(15 downto 0);
		R4 						: out std_logic_vector(15 downto 0);
		R5 						: out std_logic_vector(15 downto 0);
		R6 						: out std_logic_vector(15 downto 0);
		R7 						: out std_logic_vector(15 downto 0)	
	);
  end component;
  
  component memoria_RAM
		Generic(
			ADDR_SIZE :	positive:= 12
		);
		port(
			CLK_A 	: in 	STD_LOGIC;
			WE_A  	: in 	STD_LOGIC;
			Addr_A 	: in 	STD_LOGIC_VECTOR(ADDR_SIZE-1 downto 0);
			DI_A 	: in 	STD_LOGIC_VECTOR(15 downto 0);
			DO_A 	: out 	STD_LOGIC_VECTOR(15 downto 0)
		);
		
	end component;
	
	component memoria_ROM
			Generic(
			ADDR_SIZE :	positive:= 12
		);
		Port(
			Addr_ROM 	: in 	STD_LOGIC_VECTOR(ADDR_SIZE-1 downto 0);
			DO_ROM 	: out 	STD_LOGIC_VECTOR(15 downto 0)
		);
		
	end component;
	component BTB_bram 
		Generic(
			ADDR_SIZE :	positive:= 9
		); 
		Port(   
			CLK_A 	: in 	STD_LOGIC;
			WE_A  	: in 	STD_LOGIC;
			Addr_A 	: in 	STD_LOGIC_VECTOR(ADDR_SIZE-1 downto 0);
			Addr_B 	: in 	STD_LOGIC_VECTOR(ADDR_SIZE-1 downto 0);
			DI_A 		: in 	STD_LOGIC_VECTOR(16 downto 0);
			DO_B 		: out STD_LOGIC_VECTOR(16 downto 0)
		);
	 end component;
    

	component Controlo 
		port (
			clk, rst     : in std_logic;
			en_if 	 	 : out std_logic;
			en_idOF 	 : out std_logic;
			en_EX		 : out std_logic);
	end component;

signal   reg_PCMEM_OUT			: std_logic_vector(11 downto 0);
signal	reg_pc_IN 				: std_logic_vector(11 downto 0);
signal	reg_IfOut_PC			: std_logic_vector(11 downto 0);	-- registo entre andares
signal	reg_IfOut_ROM			: std_logic_vector(15 downto 0);
signal 	R0,R1,R2,R3,R4,R5,R6,R7	: std_logic_vector(15 downto 0);
signal 	reg_IDOF_OUT			: std_logic_vector(73 downto 0);
signal	reg_EXMEM_OUT			: std_logic_vector(67 downto 0);	
signal	REG_WC            	: std_logic_vector(15 downto 0);
signal	FLAGS_OUT				: std_logic_vector(3 downto 0);
signal	FLAGSTEST_OUT			: std_logic_vector(3 downto 0);
signal 	en_regs					: std_logic_vector(7 downto 0);
signal 	out_ROM					: std_logic_vector(15 downto 0);
signal 	out_RAM					: std_logic_vector(15 downto 0);
signal 	in_RAM					: std_logic_vector(15 downto 0);
signal 	out_MUX_WB				: std_logic_vector(15 downto 0);
signal 	out_ADD_MEM				: std_logic_vector(11 downto 0);
signal 	out_WE_MEM				: std_logic;
signal Conflit_DADOS					: std_logic;
signal reg_IDOF_OUT_WERAM		: std_logic;
signal reg_IDOF_OUT_ALUOPER	: std_logic_vector(4 downto 0);
signal reg_IDOF_OUT_bit15		: std_logic;
signal reg_IDOF_OUT_bit14		: std_logic;
signal reg_IDOF_OUT_OperA		: std_logic_vector(15 downto 0);
signal reg_IDOF_OUT_OperB		: std_logic_vector(15 downto 0);
signal reg_IDOF_OUT_ALUvsMEM	: std_logic;
signal reg_IDOF_OUT_ovWE		: std_logic;
signal reg_IDOF_OUT_AddRWC		: std_logic_vector(2 downto 0);
signal reg_IDOF_OUT_PCadd1		: std_logic_vector(11 downto 0);
signal reg_IDOF_OUT_SelMuxWB	: std_logic_vector(1 downto 0);
signal reg_IDOF_OUT_MuxConst	: std_logic_vector(15 downto 0);

signal reg_EXMEM_OUT_PCadd1		: std_logic_vector(11 downto 0);
signal reg_EXMEM_OUT_AddRWC		: std_logic_vector(2 downto 0);
signal reg_EXMEM_OUT_OutALU		: std_logic_vector(15 downto 0);
signal reg_EXMEM_OUT_OutMEM		: std_logic_vector(15 downto 0);
signal reg_EXMEM_OUT_MuxConst	: std_logic_vector(15 downto 0);
signal reg_EXMEM_OUT_ovWE		: std_logic;
signal reg_EXMEM_OUT_SelMuxWB	: std_logic_vector(1 downto 0);

signal ADD_RWC_WB				: std_logic_vector(2 downto 0);
signal ADD_RWC_EXMEM			: std_logic_vector(2 downto 0);
signal ovWE_EXMEM				: std_logic;
signal ovWE_WB					: std_logic;
--Sinais para a BTB
signal OUT_BTB					: std_logic_vector(16 downto 0);
signal IN_BTB					: std_logic_vector(16 downto 0);
signal addr_BTB_A				: std_logic_vector(8 downto 0);
signal addr_BTB_B				: std_logic_vector(8 downto 0);
signal we_BTB					: std_logic;
signal act_BTB					: std_logic;
signal BitPred					: std_logic;
signal Jump_BTB				: std_logic_vector(11 downto 0);

signal Forw_FLAGS_IN			: std_logic_vector(3 downto 0);


--Sinais de controlo dos andares de registos
signal	en_Jump_FII				: std_logic;	
signal	en_Jump_Incond			: std_logic;	
signal	Jump_Incon				: std_logic_vector(11 downto 0);
signal	pc_branch				: std_logic_vector(11 downto 0);
signal 	en_if 					: std_logic;
signal 	en_idOF 				: std_logic;
signal 	en_EX					: std_logic;
signal 	Forw_EXMEN				: std_logic_vector(15 downto 0);
signal 	Forw_WB				: std_logic_vector(15 downto 0);

begin

  inst_InF: InF port map(
		clk 					=> clk_in,
		rst 					=> rst_in,
		--BTB
		en_Jump_FII			=> en_Jump_FII,	
		en_Jump_Incond		=> en_Jump_Incond,	
		Jump_Incon			=> Jump_Incon,
		pc_branch			=> pc_branch,
		act_BTB				=> act_BTB,
		Jump_BTB				=> Jump_BTB,
		OUT_BTB				=> OUT_BTB,
		addr_BTB_A			=> addr_BTB_A,
		addr_BTB_B			=>	addr_BTB_B,
		IN_BTB				=> IN_BTB,	
		we_BTB				=> we_BTB,
		Conflit_DADOS		=> Conflit_DADOS,
		en_if 				=> en_if,
		reg_pc_IN 			=> reg_pc_IN,
		reg_pc_OUT			=> reg_pc_IN,
		out_ROM		 		=> out_ROM,
		addr 					=> addr,
		reg_PCMEM_OUT 		=> reg_PCMEM_OUT,
		reg_IfOut_ROM		=> reg_IfOut_ROM,
		reg_IfOut_PC		=> reg_IfOut_PC

		);
		
  inst_IDeOF: IDeOF port map(
		clk 						=> clk_in,
		rst 						=> rst_in, 
		en_idOF					=> en_idOF,
		reg_IfOut_ROM			=> reg_IfOut_ROM,
		reg_IfOut_PC			=> reg_IfOut_PC,
		FLAGS_IN 				=> FLAGSTEST_OUT,
		Forw_FLAGS_IN			=> Forw_FLAGS_IN,
		--BTB
		act_BTB					=>act_BTB,
		Jump_BTB					=>Jump_BTB,
		Conflit_DADOS			=> Conflit_DADOS,
		Forw_WB 					=> Forw_WB,
		Forw_EXMEN				=> Forw_EXMEN,			
		--IN FOR CONFLIT
		ADD_RWC_EXMEM 			=> ADD_RWC_EXMEM,
		ADD_RWC_WB 				=> ADD_RWC_WB,
		ovWE_WB 					=> ovWE_WB,
		ovWE_EXMEM 				=> ovWE_EXMEM,
		R0  						=> R0,
		R1  						=> R1,	
		R2  						=> R2,
		R3  						=> R3,
		R4 				 		=> R4,
		R5  						=> R5,
		R6  						=> R6,
		R7  						=> R7,
		en_Jump_FII				=> en_Jump_FII,	
		en_Jump_Incond			=> en_Jump_Incond,	
		Jump_Incon				=> Jump_Incon,
		pc_branch				=> pc_branch,
		reg_IDOF_OUT_WERAM		=> reg_IDOF_OUT_WERAM,
		reg_IDOF_OUT_ALUOPER	   => reg_IDOF_OUT_ALUOPER,
		reg_IDOF_OUT_bit15		=> reg_IDOF_OUT_bit15,
		reg_IDOF_OUT_bit14		=> reg_IDOF_OUT_bit14,
		reg_IDOF_OUT_OperA		=> reg_IDOF_OUT_OperA,
		reg_IDOF_OUT_OperB		=> reg_IDOF_OUT_OperB,
		reg_IDOF_OUT_ovWE		   => reg_IDOF_OUT_ovWE,
		reg_IDOF_OUT_ALUvsMEM	=> reg_IDOF_OUT_ALUvsMEM,
		reg_IDOF_OUT_AddRWC		=> reg_IDOF_OUT_AddRWC,
		reg_IDOF_OUT_PCadd1		=> reg_IDOF_OUT_PCadd1,
		reg_IDOF_OUT_SelMuxWB	=> reg_IDOF_OUT_SelMuxWB,
		reg_IDOF_OUT_MuxConst	=> reg_IDOF_OUT_MuxConst
		);
		
	 inst_EXeMEM: EXeMEM port map(
		clk 					=> clk_in,
		rst 					=> rst_in, 
		en_EX					=> en_EX,
		--FLAGS
		FLAGS_IN  				=> FLAGS_OUT,
		FLAGS_OUT  				=> FLAGS_OUT,
		FLAGSTEST_OUT  			=> FLAGSTEST_OUT,
		Forw_FLAGSTEST_OUT 	=>		Forw_FLAGS_IN,
		--RAM IN/OUT
		out_RAM 				=> out_RAM,
		out_ADD_MEM 			=> out_ADD_MEM, 
		out_WE_MEM 				=> out_WE_MEM,
		in_RAM 					=> in_RAM,
		--IN vem do IDOF
		reg_IDOF_OUT_WERAM		=> reg_IDOF_OUT_WERAM,
		reg_IDOF_OUT_ALUOPER	=> reg_IDOF_OUT_ALUOPER,
		reg_IDOF_OUT_bit15		=> reg_IDOF_OUT_bit15,
		reg_IDOF_OUT_bit14		=> reg_IDOF_OUT_bit14,
		reg_IDOF_OUT_OperA		=> reg_IDOF_OUT_OperA,
		reg_IDOF_OUT_OperB		=> reg_IDOF_OUT_OperB,
		reg_IDOF_OUT_ovWE		=> reg_IDOF_OUT_ovWE,
		reg_IDOF_OUT_ALUvsMEM	=> reg_IDOF_OUT_ALUvsMEM,
		reg_IDOF_OUT_AddRWC		=> reg_IDOF_OUT_AddRWC,
		reg_IDOF_OUT_PCadd1		=> reg_IDOF_OUT_PCadd1,
		reg_IDOF_OUT_SelMuxWB	=> reg_IDOF_OUT_SelMuxWB,
		reg_IDOF_OUT_MuxConst	=> reg_IDOF_OUT_MuxConst,
		--Out para o WB
		reg_EXMEM_OUT_AddRWC 	=> reg_EXMEM_OUT_AddRWC,
		reg_EXMEM_OUT_PCadd1 	=> reg_EXMEM_OUT_PCadd1,
		reg_EXMEM_OUT_MuxConst 	=> reg_EXMEM_OUT_MuxConst,
		reg_EXMEM_OUT_OutMEM 	=> reg_EXMEM_OUT_OutMEM,
		reg_EXMEM_OUT_OutALU 	=> reg_EXMEM_OUT_OutALU,
		reg_EXMEM_OUT_ovWE 		=> reg_EXMEM_OUT_ovWE,
		reg_EXMEM_OUT_SelMuxWB 	=> reg_EXMEM_OUT_SelMuxWB,
		---Out for conflit
		Forw_EXMEN				=> Forw_EXMEN,
		ovWE_EXMEM 				=> ovWE_EXMEM,
		ADD_RWC_EXMEM 			=> ADD_RWC_EXMEM


		);
	
	inst_WB: WB port map( 
		clk 					=> clk_in,
		rst 					=> rst_in,
		--in
		reg_EXMEM_OUT_AddRWC 	=> reg_EXMEM_OUT_AddRWC,
		reg_EXMEM_OUT_PCadd1 	=> reg_EXMEM_OUT_PCadd1,
		reg_EXMEM_OUT_MuxConst 	=> reg_EXMEM_OUT_MuxConst,
		reg_EXMEM_OUT_OutMEM 	=> reg_EXMEM_OUT_OutMEM,
		reg_EXMEM_OUT_OutALU 	=> reg_EXMEM_OUT_OutALU,
		reg_EXMEM_OUT_ovWE 		=> reg_EXMEM_OUT_ovWE,
		reg_EXMEM_OUT_SelMuxWB 	=> reg_EXMEM_OUT_SelMuxWB,
		--out
		out_MUX_WB				=> out_MUX_WB,
		out_saida 				=> saida,
		Forw_WB				=> Forw_WB,
		en_regs  				=> en_regs,
		ADD_RWC_WB 				=> ADD_RWC_WB,
		ovWE_WB 				=> ovWE_WB
		);
		
	inst_registos: registos port map(
		rst				 => rst_in,
		clk				 => clk_in,		
		out_mux_WB		 => out_MUX_WB,
		en_regs			 => en_regs,
		R0 				 => R0,
		R1 				 => R1,	
		R2 				 => R2,
		R3 				 => R3,
		R4 				 => R4,
		R5 				 => R5,
		R6				 => R6,
		R7 				 => R7
	);
	
	inst_memoria_RAM: memoria_RAM port map(
		CLK_A 	=> clk_in,
		WE_A		=> out_WE_MEM,
		Addr_A 	=> out_ADD_MEM,
		DI_A		=> in_RAM,
		DO_A 		=> out_RAM
	
	);
	
	inst_memoria_ROM: memoria_ROM port map(

		Addr_ROM 	=> reg_PCMEM_OUT,
		DO_ROM		=> out_ROM
	
	);
	
	inst_BTB_BRAM: BTB_BRAM port map(
			CLK_A 	=> clk_in,
			WE_A  	=> we_BTB,
			Addr_A 	=> addr_BTB_A,
			Addr_B 	=> addr_BTB_B,
			DI_A 		=> IN_BTB,
			DO_B 		=> OUT_BTB
	);
	
	inst_Controlo: Controlo port map(

		clk 			=> clk_in,
		rst 			=> rst_in,
		en_if		 	=> en_if,
		en_idOF		=> en_idOF,
		en_EX		 	=> en_EX 
	
	);
		
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity circuito is
  port (
    clk, rst: in std_logic
    );
end circuito;

architecture Behavioral of circuito is

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
		port(
			CLK_A 	: in 	STD_LOGIC;
			Addr_A 	: in 	STD_LOGIC_VECTOR(ADDR_SIZE-1 downto 0);
			DO_A 	: out 	STD_LOGIC_VECTOR(15 downto 0)
		);
		
	end component;
	
	component InF
		port(
		-- input
			clk, rst 				: in std_logic;
			destino_jump			: in std_logic_vector(11 downto 0);		-- vem da ALU	
			destino_cond			: in std_logic_vector(11 downto 0);     -- vem da ALU
			FLAGTEST_MUXPC_IN		: in std_logic;							-- vem da ALU
			JUMP_MUXPC_IN			: in std_logic;							-- vem do IDeOF
			reg_pc_IN 				: in std_logic_vector(11 downto 0);		-- PC realimentado
			out_ROM					: in std_logic_vector(15 downto 0);	

			-- output
			reg_PCMEM_OUT			: out std_logic_vector(11 downto 0);	-- PC + 1
			reg_IF_OUT				: out std_logic_vector(27 downto 0)		-- registo entre andares		
		);
	end component;
  
	component IDeOF
		port(
		-- input
		clk, rst 				: in std_logic;
		reg_IF_OUT 				: in std_logic_vector(27 downto 0);		-- registo entre andares
		R0 						: in std_logic_vector(15 downto 0);
		R1 						: in std_logic_vector(15 downto 0);
	    R2 						: in std_logic_vector(15 downto 0);
		R3 						: in std_logic_vector(15 downto 0);
		R4 						: in std_logic_vector(15 downto 0);
		R5 						: in std_logic_vector(15 downto 0);
		R6 						: in std_logic_vector(15 downto 0);
		R7 						: in std_logic_vector(15 downto 0);
		
		-- output					
		JUMP_MUXPC_OUT			: out std_logic;						-- vai para o IF
		destino_jump			: out std_logic_vector(11 downto 0);
		destino_cond			: out std_logic_vector(11 downto 0);
		reg_IDOF_OUT			: out std_logic_vector(71 downto 0) 	-- registo entre andares
	);
	end component;

	component EXeMEM
    	port(
			-- input
			clk, rst 					: in std_logic;
			reg_IDOF_OUT				: in std_logic_vector(71 downto 0);			-- registo entre andares
			FLAGS_IN					: in std_logic_vector(3 downto 0);
			out_RAM						: in std_logic_vector(15 downto 0);
			
			-- output
			reg_EXMEM_OUT				: out std_logic_vector(66 downto 0);		-- registo entre andares
			out_ADD_MEM					: out std_logic_vector(11 downto 0);		-- para endereçar a RAM
			out_WE_MEM					: out std_logic;	
			FLAGS_OUT					: out std_logic_vector(3 downto 0);
			in_RAM						: out std_logic_vector(15 downto 0);
			FLAGTEST_MUXPC_OUT			: out std_logic 							
		);
  end component;
  
  component WB
   port(
		-- input
		clk, rst 					: in std_logic;
		reg_EXMEM_OUT				: in std_logic_vector(66 downto 0);		-- registo entre andares
		
		-- output
		en_regs						: out std_logic_vector(7 downto 0);
		out_MUX_WB					: out std_logic_vector(15 downto 0)
	);
  end component;
  
  component registos
    port(
		-- input
		clk, rst				: in std_logic;
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

signal	destino_jump			: std_logic_vector(11 downto 0);
signal	destino_cond			: std_logic_vector(11 downto 0);
signal	FLAGTEST_MUXPC_IN		: std_logic;
signal	JUMP_MUXPC_IN			: std_logic;
signal	reg_pc_IN 				: std_logic_vector(11 downto 0);
signal	reg_PCMEM_OUT			: std_logic_vector(11 downto 0);
signal	reg_IF_OUT				: std_logic_vector(27 downto 0);	-- registo entre andares
signal 	R0,R1,R2,R3,R4,R5,R6,R7	: std_logic_vector(15 downto 0);
signal 	reg_IDOF_OUT			: std_logic_vector(70 downto 0);
signal	reg_EXMEM_OUT			: std_logic_vector(66 downto 0);	
signal	REG_WC            		: std_logic_vector(15 downto 0);
signal	FLAGS_OUT				: std_logic_vector(3 downto 0);
signal	FLAGTEST_MUXPC_OUT		: std_logic; 
signal 	en_regs					: std_logic_vector(7 downto 0);
signal 	out_ROM					: std_logic_vector(15 downto 0);
signal 	out_RAM					: std_logic_vector(15 downto 0);
signal 	in_RAM					: std_logic_vector(15 downto 0);
signal 	out_MUX_WB				: std_logic_vector(15 downto 0);

begin

  inst_InF: InF port map(
		clk => clk,
		rst => rst,
		destino_jump => destino_jump,
		destino_cond =>	destino_cond,
		FLAGTEST_MUXPC_IN => FLAGTEST_MUXPC_IN,
		JUMP_MUXPC_IN => JUMP_MUXPC_IN,
		reg_pc_IN => reg_pc_IN,
		out_ROM => out_ROM,
		reg_PCMEM_OUT => reg_PCMEM_OUT,
		reg_IF_OUT  => reg_IF_OUT
		);
		
  inst_IDeOF: IDeOF port map(
		clk => clk,
		rst => rst, 
		reg_IF_OUT  => reg_IF_OUT,
		R0  => R0,
		R1  => R1,	
		R2  => R2,
		R3  => R3,
		R4  => R4,
		R5  => R5,
		R6  => R6,
		R7  => R7,
		JUMP_MUXPC_OUT  => JUMP_MUXPC_IN,
		destino_cond =>	destino_cond,
		destino_jump => destino_jump,
		reg_IDOF_OUT  => reg_IDOF_OUT
		);
		
	 inst_EXeMEM: EXeMEM port map(
		clk => clk,
		rst => rst, 
		reg_IDOF_OUT  => reg_IDOF_OUT,
		FLAGS_IN  => FLAGS_OUT,
		out_RAM => out_RAM,
		in_RAM 	=> in_RAM,
		reg_EXMEM_OUT => reg_EXMEM_OUT,
		out_ADD_MEM => out_ADD_MEM, 
		FLAGS_OUT  => FLAGS_OUT,
		FLAGTEST_MUXPC_OUT  => FLAGTEST_MUXPC_OUT
		);
	
	inst_WB: WB port map(
		clk => clk,
		rst => rst, 
		reg_EXMEM_OUT  => reg_EXMEM_OUT,
		out_MUX_WB => out_MUX_WB,
		en_regs  => en_regs
		);
		
	inst_registos: registos port map(
		clk => clk,
		rst => rst, 
		out_mux_WB => out_MUX_WB,
		en_regs	=> en_regs,
		R0  => R0,
		R1  => R1,	
		R2  => R2,
		R3  => R3,
		R4  => R4,
		R5  => R5,
		R6  => R6,
		R7  => R7
	);
	
	inst_memoria_RAM: memoria_RAM port map(
		CLK_A 	=> clk,
		WE_A	=> out_WE_MEM,
		Addr_A 	=> out_ADD_MEM,
		DI_A	=> in_RAM,
		DO_A 	=> out_RAM
	
	);
	
	inst_memoria_ROM: memoria_ROM port map(
		CLK_A 	=> clk,
		Addr_A 	=> reg_PCMEM_OUT,
		DO_A 	=> out_ROM
	
	);
		
end Behavioral;

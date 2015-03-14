library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity circuito is
  port (
    clk, rst: in std_logic;
    instr: in std_logic_vector(2 downto 0);	-- buttons 3,2,1
    data_in: in std_logic_vector(7 downto 0);	-- switches
    saida: out std_logic_vector(12 downto 0);	--porta de saida
	 disp_value : out std_logic_vector (19 downto 0)	-- display 7-segments
    );
end circuito;

architecture Behavioral of circuito is

	component InF
		port(
			-- input
			clk, rst 				: in std_logic;
			destino_jump			: in std_logic_vector(11 downto 0);
			destino_cond			: in std_logic_vector(11 downto 0);
			FLAGTEST_MUXPC_IN		: in std_logic;
			JUMP_MUXPC_IN			: in std_logic;
			reg_pc_IN 				: in std_logic_vector(11 downto 0);

			-- output
			reg_PCMEM_OUT			: out std_logic_vector(11 downto 0);
			reg_IF_OUT				: out std_logic_vector(27 downto 0)		-- registo entre andares	
		);
	end component;
  
	component IDeOF
		port(
			-- input
			clk, rst 				: in std_logic;
			reg_IF_OUT 				: in std_logic_vector(27 downto 0);		-- registo entre andares
			inst_IN					: in std_logic_vector(15 downto 0);	
			R0 						: in std_logic_vector(15 downto 0);
			R1 						: in std_logic_vector(15 downto 0);
		   R2 						: in std_logic_vector(15 downto 0);
			R3 						: in std_logic_vector(15 downto 0);
			R4 						: in std_logic_vector(15 downto 0);
			R5 						: in std_logic_vector(15 downto 0);
			R6 						: in std_logic_vector(15 downto 0);
			R7 						: in std_logic_vector(15 downto 0);
			
			-- output
			FLAGTEST_active_OUT		: out std_logic;
			JUMP_MUXPC_OUT			: out std_logic;
			reg_IDOF_OUT			: out std_logic_vector(70 downto 0) 				-- registo entre andares
		);
	end component;

	component EXeMEM
    	port(
			-- input
			clk, rst 					: in std_logic;
			reg_IDOF_OUT				: in std_logic_vector(70 downto 0);			-- registo entre andares
			FLAGS_IN					: in std_logic_vector(3 downto 0);
			TRANS_OP					: in std_logic_vector(1 downto 0);
			TRANS_FI_COND_IN			: in std_logic_vector(3 downto 0);
			FLAGTEST_active_IN			: in std_logic;

			-- output
			reg_EXMEM_OUT				: out std_logic_vector(66 downto 0);	
			REG_WC            			: out std_logic_vector(15 downto 0);
			FLAGS_OUT					: out std_logic_vector(3 downto 0);
			FLAGTEST_MUXPC_OUT			: out std_logic 							-- registo entre andares
		);
  end component;
  
  component WB
    port(
		-- input
		clk, rst 					: in std_logic;
		reg_EXMEM_OUT				: in std_logic_vector(66 downto 0);		-- registo entre andares

		-- output
		en_r0						: out std_logic;
		en_r1						: out std_logic;
		en_r2						: out std_logic;
		en_r3						: out std_logic;
		en_r4						: out std_logic;
		en_r5						: out std_logic;
		en_r6						: out std_logic;
		en_r7						: out std_logic
	);
  end component;
  
  component registos
    port(
		-- input
		clk						: in std_logic;
		inst_IN					: in std_logic_vector(15 downto 0);
		en_r0					: in std_logic;
		en_r1					: in std_logic;
		en_r2					: in std_logic;
		en_r3					: in std_logic;
		en_r4					: in std_logic;
		en_r5					: in std_logic;
		en_r6					: in std_logic;
		en_r7					: in std_logic;	
			
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

begin

  inst_InF: InF port map(
		clk => clk,
		rst => rst,
		instr => instr,
		sw_value => data_in,
		en_r1 => en_r1,
		en_r2 => en_r2,
		sel_mux => sel_mux,
		oper => oper
		);
		
  inst_IDeOF: IDeOF port map(
		sw_value => data_in,
		clk => clk,
		rst => rst, 
		en_r1 => en_r1,
		en_r2 => en_r2,
		sel_mux => sel_mux,
		oper => oper,
		saida => saida,
		disp_value => disp_value
		);
		
	 inst_EXeMEM: EXeMEM port map(
		sw_value => data_in,
		clk => clk,
		rst => rst, 
		en_r1 => en_r1,
		en_r2 => en_r2,
		sel_mux => sel_mux,
		oper => oper,
		saida => saida,
		disp_value => disp_value
		);
	
	inst_WB: WB port map(
		sw_value => data_in,
		clk => clk,
		rst => rst, 
		en_r1 => en_r1,
		en_r2 => en_r2,
		sel_mux => sel_mux,
		oper => oper,
		saida => saida,
		disp_value => disp_value
		);
		
	inst_registos: registos port map(
		sw_value => data_in,
		clk => clk,
		rst => rst, 
		en_r1 => en_r1,
		en_r2 => en_r2,
		sel_mux => sel_mux,
		oper => oper,
		saida => saida,
		disp_value => disp_value
		);
		
end Behavioral;

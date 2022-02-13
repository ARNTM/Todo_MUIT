	component nios_system is
		port (
			clk_50_in_clk : in std_logic := 'X'; -- clk
			reset_reset_n : in std_logic := 'X'  -- reset_n
		);
	end component nios_system;

	u0 : component nios_system
		port map (
			clk_50_in_clk => CONNECTED_TO_clk_50_in_clk, -- clk_50_in.clk
			reset_reset_n => CONNECTED_TO_reset_reset_n  --     reset.reset_n
		);


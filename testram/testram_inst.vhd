	component testram is
		port (
			clk              : in    std_logic                     := 'X';             -- clk
			cdt_write        : in    std_logic                     := 'X';             -- cdt_write
			cdt_read         : in    std_logic                     := 'X';             -- cdt_read
			cdt_chipselect   : in    std_logic                     := 'X';             -- cdt_chipselect
			cdt_outputenable : in    std_logic                     := 'X';             -- cdt_outputenable
			cdt_address      : in    std_logic_vector(19 downto 0) := (others => 'X'); -- cdt_address
			cdt_data_io      : inout std_logic_vector(15 downto 0) := (others => 'X'); -- cdt_data_io
			cdt_byteenable   : in    std_logic_vector(0 downto 0)  := (others => 'X')  -- cdt_byteenable
		);
	end component testram;

	u0 : component testram
		port map (
			clk              => CONNECTED_TO_clk,              --     clk.clk
			cdt_write        => CONNECTED_TO_cdt_write,        -- conduit.cdt_write
			cdt_read         => CONNECTED_TO_cdt_read,         --        .cdt_read
			cdt_chipselect   => CONNECTED_TO_cdt_chipselect,   --        .cdt_chipselect
			cdt_outputenable => CONNECTED_TO_cdt_outputenable, --        .cdt_outputenable
			cdt_address      => CONNECTED_TO_cdt_address,      --        .cdt_address
			cdt_data_io      => CONNECTED_TO_cdt_data_io,      --        .cdt_data_io
			cdt_byteenable   => CONNECTED_TO_cdt_byteenable    --        .cdt_byteenable
		);


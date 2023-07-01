module Wrapper(MOSI,MISO,clk,rst_n,SS_n);

	input MOSI,SS_n,clk,rst_n;
	output MISO;
	wire rx_valid;
	wire tx_valid;
	wire [7:0] tx_data;
	wire [9:0] rx_data;
	wire [7:0]dout;
	//reg [9:0] din;
	spi DUT1 (MOSI,SS_n,clk,rst_n,MISO,rx_data,rx_valid,dout,tx_valid);
	ram DUT2 (rx_data,clk,rst_n,rx_valid,dout,tx_valid);

endmodule
module Wrapper_tb();
	
	reg clk,rst_n,SS_n,MOSI;
	reg [7:0] din;
	wire MISO;
	integer i;
	Wrapper DUT3 (MOSI,MISO,clk,rst_n,SS_n);
	initial begin
		clk = 0;
		forever
		#1 clk =~clk;
	end
	initial begin
		$readmemb("mem.dat",DUT3.DUT2.mem);
		rst_n = 0;
		#50;
		rst_n = 1;
		SS_n = 0;
		#10;
		for (i =0 ; i<8 ; i=i+1)begin
			@(negedge clk);
			MOSI = $random;
			#5;
		end
		MOSI = 0;
		#2;
		MOSI = 0;
		#8;
		SS_n = 1;
		#10;
		SS_n = 0;
		for (i =0 ; i<8 ; i=i+1)begin
			@(negedge clk);
			MOSI = $random;
			#5;
		end
		MOSI = 0;
		#5;
		MOSI = 1;
		#8;
		SS_n = 1;
		#2;
		SS_n = 0;
		for (i =0 ; i<8 ; i=i+1)begin
			@(negedge clk);
			MOSI = $random;
			#5;
		end
		MOSI = 1;
		#5;
		MOSI = 0;
		#8;
		SS_n = 1;
		#5;
		SS_n = 0;
		#8;
		MOSI = 1;
		#5;
		MOSI = 1;
		SS_n = 1;
		#10;
		$stop;
	end
	initial begin
		$monitor("MOSI = %b --- MISO = %b --- reset_n = %d --- SS_n = %d",MOSI,MISO,rst_n,SS_n);
	end

endmodule
module ram(din,clk,rst_n,rx_valid,dout,tx_valid);

	parameter mem_depth=256;
	parameter addr_size=8;
	parameter mem_width=10;
	input[9:0] din;
	input clk,rst_n;
	output reg[7:0] dout;
	output reg tx_valid,rx_valid;
	reg [addr_size-1:0] addr;
	reg [addr_size-1:0] mem [mem_depth-1:0];
	always @(posedge clk or negedge rst_n) begin
		tx_valid <= 0;
		if (rst_n) begin
			if(rx_valid)begin
				//read
				if(din[9]) begin
					if(~din[8])  
						addr <= din[7:0];
					else if(din[8] )begin
					dout <= mem[addr];
					tx_valid<=1;
					end
				end
				//write
				else if (~din[9]) begin
						if(~din[8])  
							addr <= din[7:0];
						else if(din[8])
							mem[addr] <= din[7:0];
				end
			end
		end	
		else begin
			dout <= 0;
			tx_valid <= 0;
		end
	end

endmodule
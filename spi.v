module spi(MOSI,SS_n,clk,rst_n,MISO,rx_data,rx_valid,tx_data,tx_valid);

	parameter IDLE = 3'b000;
	parameter CHK_CMD = 3'b001;
	parameter READ_ADD =3'b010;
	parameter WRITE = 3'b011;
	parameter READ_DATA =3'b100;
	input  MOSI,clk,SS_n,rst_n;
	output reg MISO;
	output reg [9:0] rx_data;
	output reg rx_valid,tx_valid;
	output reg [7:0]tx_data;
	reg [2:0] cs,ns;
	reg adr_data;
	integer i;

	//state mem
	always @(posedge clk or negedge rst_n) begin
		if (~rst_n)
			cs <= IDLE;
		else 
			cs <= ns;
	end

	//next state logic 
	always @(*) begin
		adr_data = 0;
		if (MOSI) begin
			case (cs)
				IDLE:
					if (~SS_n)
		 					ns = CHK_CMD;
		 			else 
		 					ns = IDLE;
				CHK_CMD:
					if (~SS_n && ~adr_data)begin
							ns = READ_ADD;
					end
					else if (~SS_n && adr_data)
							ns = READ_DATA;
					else 
							ns = CHK_CMD;		
				READ_ADD:
					if (SS_n)
							ns = IDLE;
					else 
							ns = READ_ADD;
				READ_DATA:
					if (SS_n) 
						ns = IDLE;
					else 
						ns = READ_DATA;
				default:
				ns = IDLE;		
			endcase
		end	
		else begin
			case(cs) 
	        IDLE:
		         if(SS_n)
		            ns = IDLE;
		         else 
		            ns = CHK_CMD;
	        CHK_CMD:
		         if(~SS_n && ~MOSI)
		            ns = WRITE;
		         else 
		            ns = CHK_CMD;
	        WRITE:
		         if(SS_n)
		            ns = IDLE;
		         else 
		            ns = WRITE;
	        default: 
	        	ns = IDLE;
	     endcase
		end
	end

  //Output Logic
  always@(cs) begin
  		rx_valid = 0;
      if(cs==WRITE) begin
          for(i=0;i<10;i=i+1) begin
              rx_data[i]=MOSI;
          end
          rx_valid=1;
      end
      else if (cs == READ_ADD) begin
      		for(i=0;i<10;i=i+1) begin
              rx_data[i]=MOSI;
          end
          rx_valid=1;
          adr_data = adr_data + 1;
      end
      else if (cs == READ_DATA) begin
      		for(i=0;i<10;i=i+1) begin
              rx_data[i]=MOSI;  //dummy bits  
          end
          for(i=0;i<8;i=i+1) begin
              MISO=tx_data[i];
          end
      end
  end 

endmodule
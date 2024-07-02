module contador (
    input clk,
    input reset,
    output reg [9:0] cont_seg, //contador para os segundos
    output reg [3:0] cont_dec	//contador para os decimos de segundo
);

initial begin 
	cont_seg = 0;
	cont_dec = 0;
end

reg [31:0] cont_clk = 0; //contador para os ciclos do clock


parameter segundo = 10; //ciclos de clock por segundo
parameter decimo = 1; // segundo / 10 (parece que não é muito recomendado usar a divisão)

always @(posedge clk or posedge reset) begin

	cont_clk <= cont_clk + 1;
	
	if (reset) begin
		cont_clk <= 32'd0;
		cont_seg <= 10'd0;
		cont_dec <= 4'd0;
	end else begin
		if (cont_dec < 4'd9) begin
			cont_dec <= cont_dec + 1;
		end else begin
			cont_dec <= 4'd0;
			if (cont_seg <= 10'd999) begin
				cont_seg <= cont_seg + 1;
			end else begin
				cont_seg <= 10'd0;
			end
		end
	end

end

endmodule

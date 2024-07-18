module estados(
	input clk,
	input reset,
	input conta,
	input pausa,
	input para,
	
	output reg [2:0] estado
);

parameter inicio = 0, contar = 1, pausar = 2, parar = 3;
reg [2:0] estado_atual = inicio; // inicia o cronometro parado com 0

always @(posedge clk or negedge reset) begin // parte sequencial
	if (!reset) begin
		estado_atual <= inicio;
	end
	else begin
		case (estado_atual)
			inicio: begin
				if (conta == 0) begin
					estado_atual <= contar;
				end
			end
			contar: begin
				if (reset == 0) begin
					estado_atual <= inicio;
				end 
				else if (pausa == 0) begin
					estado_atual <= pausar;
				end 
				else if (para == 0) begin
					estado_atual <= parar;
				end
			end
			pausar: begin
				if (reset == 0) begin
					estado_atual <= inicio;
				end
				else if (conta == 0) begin
					estado_atual <= contar;
				end
				else if (para == 0) begin
					estado_atual <= parar;
				end
			end
			parar: begin
				if (reset == 0) begin
					estado_atual <= inicio;
				end
				else if (conta == 0) begin
					estado_atual <= contar;
				end
			end
		endcase
	end
end


always @(posedge clk or negedge reset) begin
	if (!reset) begin
		estado <= inicio;
	end
	else begin
		estado <= estado_atual;
	end
end

endmodule
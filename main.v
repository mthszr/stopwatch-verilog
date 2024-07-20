module main(
	input clk,
	input reset,
	input conta,
	input pausa,
	input para,
	output [0:6] centenas,
	output [0:6] decimos,
	output [0:6] dezenas,
	output [0:6] unidades
);

wire contando_fio;
wire	[2:0] estado_fio;
wire	[3:0] decimos_fio;
wire	[9:0] segundos_fio;


contador contador(
	.clk(clk),
	.reset(reset),
	.contando(contando_fio),
	.estado_atual(estado_fio),
	.cont_dec(decimos_fio),
	.cont_seg(segundos_fio)
);

	defparam	contador.segundo = 50000000;

estados estados(
	.clk(clk),
	.reset(reset),
	.conta(conta),
	.pausa(pausa),
	.para(para),
	.contando(contando_fio),
	.estado(estado_fio)
);

	defparam	estados.contar = 1;
	defparam	estados.inicio = 0;
	defparam	estados.parar = 3;
	defparam	estados.pausar = 2;

sete_segmentos(
	.dec(decimos_fio),
	.seg(segundos_fio),
	.centenas(centenas),
	.decimos(decimos),
	.dezenas(dezenas),
	.unidades(unidades)
);


endmodule

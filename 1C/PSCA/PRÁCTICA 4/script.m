clc,clear
Enrejado = poly2trellis ( 4, [ 13 15 ], 13 );
x = randi( [0 1], 1152 , 1);
y = turbo_codificador(x,Enrejado);
y1 = TC(x,Enrejado);
resy1 = sum(y==y1);
[BitsDec,LLR] = turbo_decodificador (y,1,Enrejado,6);
[BitsDec1,LLR1] = TDEC (y,1,Enrejado,6);
resBitsDec1 = sum(BitsDec == BitsDec1);
resLLR1 = sum(LLR == LLR1);


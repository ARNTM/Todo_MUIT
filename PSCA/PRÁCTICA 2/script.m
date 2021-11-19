i = [2 4 1 2 2 3 1 4 1 4 2 3 3 4 1 ];
j = [1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 ];
H = sparse ( i, j, ones ( length ( i ) , 1 ) );
hEnc = comm.LDPCEncoder ( H );
hDec = comm.LDPCDecoder ( H );
NumInfoBits = size ( hEnc.ParityCheckMatrix, 1 );
InfoBits = randi ( [0 1], NumInfoBits, 1);
codeword = step ( hEnc, InfoBits );
mDec = step ( hDec, cast(not(codeword),'double'));


%% CONVOC
m = 2
Enrejado = poly2trellis(m+1, [5 7], 7);
NumInfoBits = 10;
InfoBits = randi( [0 1], NumInfoBits , 1);
hEnc = comm.ConvolutionalEncoder( Enrejado, 'TerminationMethod', 'Terminated');
codeword = step(hEnc, InfoBits);
hDec=comm.ViterbiDecoder(Enrejado,'InputFormat','hard', 'TracebackDepth', m+1,'TerminationMethod','Terminated');
deco = step( hDec,codeword);
mDec=deco(1:end-(m));

%% TURBO CODIGOS
Enrejado = poly2trellis ( 4, [ 13 15 ], 13 );
hCEnc1 = comm.ConvolutionalEncoder('TrellisStructure', Enrejado, 'TerminationMethod', 'Terminated' );
hCEnc2 = comm.ConvolutionalEncoder('TrellisStructure', Enrejado, 'TerminationMethod', 'Terminated' );
InfoBits = randi ([0 1], NumInfoBits,1);
codeword=turbo_codif(hCEnc1,hCEnc2,InfoBits);
hDec1 = comm.APPDecoder('TrellisStructure', Enrejado, 'TerminationMethod', 'Terminated', 'Algorithm', 'True APP');
hDec2 = comm.APPDecoder('TrellisStructure',Enrejado, 'TerminationMethod','Terminated', 'Algorithm', 'True APP');
numIter=6;
mDec = turbo_dec(codeword, NumInfoBits,numIter,hDec1,hDec2);

%% PSK
hMod=comm.PSKModulator(M,0,'BitInput',true,'SymbolMapping','Gray');
hDemod=comm.PSKDemodulator(M,0,'SymbolMapping','Gray', 'BitOutput',true, 'DecisionMethod','log-likelihood ratio');
x_mod=step(hMod,x);
x_dem=step(hDemod,x);

%% CANAL AWG
hcanal=comm.AWGNChannel('NoiseMethod', 'Signal to noise ratio (SNR)', 'SNR',20);
hcanal=comm.AWGNChannel('NoiseMethod', 'Signal to noise ratio (Eb/No)', 'EbNo',20,'BitsPerSymbol',k);
yrx=step(hcanal,x_mod);

%%
SNR = -7 : 1 : 7;
EbNo = SNR-10*log10(R*log2(M));

hCalculoError=comm.ErrorRate;
VectorErrores=step(hCalculoError, 'secuencia tx', 'secuencia detectada');
bit_error_rate=VectorErrores(1);
numero_errores=VectorErrores(2);
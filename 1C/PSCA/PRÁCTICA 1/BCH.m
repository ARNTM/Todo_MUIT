%% BCH

Eb_div_N0_dB = 0 : 1 : 10;
Eb_div_N0 = 10.^( Eb_div_N0_dB / 10 ); % Relación en lineal
p_sin_cod = Q( sqrt( 2 * Eb_div_N0 ) );

n = 15;
k = 5;
p = 0.5;
numMensjes = 100000;

hEnc = comm.BCHEncoder( 'CodewordLength', n, 'MessageLength', k );
hDec = comm.BCHDecoder( 'CodewordLength', n, 'MessageLength', k );
mm = randi( [ 0 1 ], numMensajes * k, 1 ); % mensajes de k bits
cc = step( hEnc, mm ); % palabras código
% Generacion de patron de bits con probabilidad p de que aparezcan unos
ee = rand( size( cc ) ) < p;
rr = mod( cc + ee, 2 ); % palabra recibida
mmDec = step( hDec, rr );
errores = sum( mod( mm+mmDec ,2));
BER = errores/ k*numMensajes;
semilogy( Eb_div_N0_dB, BER );
grid on
xlabel( 'Eb/N0 (dB)' );
ylabel( 'BER' );

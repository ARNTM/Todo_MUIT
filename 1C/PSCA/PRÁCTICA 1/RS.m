%% RS

Eb_div_N0_dB = 0 : 1 : 10;
Eb_div_N0 = 10.^( Eb_div_N0_dB / 10 ); % Relación en lineal
p_sin_cod = Q( sqrt( 2 * Eb_div_N0 ) );
p = Q( sqrt( 2 * R * Eb_div_N0 ) );
m = 3;
n = 7;
k = 2;
t = n - k / 2;
hEnc = comm.RSEncoder( 'BitInput',true,'CodewordLength', n, 'MessageLength', k );
hDec = comm.RSDecoder( 'BitInput',true,'CodewordLength', n, 'MessageLength', k );
numMensjes = 100000;
mm = randi( [ 0 1 ], numMensjes * k * m, 1 ); % mensajes de k bits
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
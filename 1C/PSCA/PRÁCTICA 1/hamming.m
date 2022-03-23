%% Hamming

Eb_div_N0_dB = 0 : 1 : 10;
Eb_div_N0 = 10.^( Eb_div_N0_dB / 10 ); % Relación en lineal
p_sin_cod = Q( sqrt( 2 * Eb_div_N0 ) );

k = 11;
n = 15;
p = 0.5;
numMensajes = 100000;
mm = randi( [ 0 1 ], k * numMensajes, 1 );
cc = encode( mm, n, k, 'hamming/binary');
ee = rand( size( cc ) ) < p;
rr = mod( cc + ee, 2 ); % palabra recibida
mmDec = decode( rr, n, k, 'hamming/binary' );
errores = sum( mod( mm+mmDec ,2));
BER = errores/ k*numMensajes;
semilogy( Eb_div_N0_dB, BER );
grid on
xlabel( 'Eb/N0 (dB)' );
ylabel( 'BER' );
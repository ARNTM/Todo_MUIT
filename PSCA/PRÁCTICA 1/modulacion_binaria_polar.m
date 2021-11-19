%% Modulación binaria polar
Eb_div_N0_dB = 0 : 1 : 10;
Eb_div_N0 = 10.^( Eb_div_N0_dB / 10 ); % Relación en lineal
Pb = Q( sqrt( 2 * Eb_div_N0 ) );
semilogy( Eb_div_N0_dB, Pb );
grid on
xlabel( 'Eb/N0 (dB)' );
ylabel( 'P_b' );
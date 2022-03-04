function [ num_err ] = errores ( x, M, data )
x=x(:);
E = 2 * ( M - 1 ) / 3 ;
Ntx = size ( x , 1 ) ;

%demod = modem.qamdemod ( 'M', M, 'OutputType', 'bit' ) ;
%bits = demodulate ( demod, transpose ( x ).*sqrt( E * Ntx) ) ;

bits=qamdemod( transpose ( x ).*sqrt( E * Ntx),M,'OutputType', 'bit');
num_err = sum ( sum ( bits ~= data ) ) ; 

end
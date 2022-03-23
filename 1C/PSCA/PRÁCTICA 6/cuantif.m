function [x] = cuantif ( s, M , Ntx )
%función de cuantificación para una señal M-QAM
n = length ( s );
x = zeros ( n, 1);
E = 2 * ( M - 1 ) / 3;

constel=qammod([0:1:M-1],M);

constel=constel./sqrt( E * Ntx);
for i = 1 : n
    [ minaux, pos ] = min ( abs ( s( i ) - constel ) );
    x( i ) = constel ( pos ) ;
end
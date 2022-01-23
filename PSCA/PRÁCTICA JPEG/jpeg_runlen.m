function runlen =jpeg_runlen(Dqz)
%function runlen =jpeg_runlen(Dqz)
%dada la matriz de coeficientes en orden zigzag genera una matriz donde
%cada fila tiene en la primera columna el runlen de ceros y en la segunda
%el coeficiente no cero.
% Si la parte final es una secuencia de ceros, hay que poner End Of Block y
% y esto queda indicado en la salida de esta función mediante -1 en la
% primera columna. 
% Recordar que el primer coeficiente de Dqz
% es el coeficiente DC y en esta parte no se considera por que ya se ha
% codificado previamente
%Por ejemplo con 
% 9 7 8 0   8 0 0 0   0 0 0 0   5 1 2 3 0 0 0 0   0 0 0 0   0 0 0 0   0 0 0 0
% 0 0 0 0   4 0 0 0   0 0 0 6   0 4 0 0 0 0 0 0   0 0 0 0   0 0 0 0   0 0 0 0
%el resultado es:
%   0   7   
%   0   8
%   1   8
%   7   5
%   0   1
%   0   2
%   0   3
%  20   4
%   6   6
%   1   4
%  -1   nan

%para probar el algoritmo
% Dqz=[9 7 8 0   8 0 0 0   0 0 0 0   5 1 2 3 ...
%  0 0 0 0   0 0 0 0   0 0 0 0   0 0 0 0 ...
%  0 0 0 0   4 0 0 0   0 0 0 6   0 4 0 0 ...
%  0 0 0 0   0 0 0 0   0 0 0 0   0 0 0 1 ];

%Dqz=zeros(1,64);

%[1 0 0 0   0 0...
 %0 0 0 0   0 0 0 0   0 0 0 0   0 0 0 0 ...
 %0 0 0 0   4 0 0 0   0 0 0 6   0 4 0 0 ...
 %0 0 0 0   0 0 0 0   0 0 0 0   0 0 0 0 ];

runlen = [];
nonzero_ac = find(Dqz(2:end) ~=0) + 1;   %indices de coefs ac no cero. La diferencia de posiciones consecutivas nos da la longitud del runlength. El +1 es para compensar que lo que le damos a la funcion find es  Dqz(2:end) en vez de Dqz
n_nzac= length(nonzero_ac); % numero de coefs ac no cero
      
   %debug
%nonzero_ac,n_nzac;

if n_nzac == 0
   runlen = [-1  nan];  % los 63 coeficientes son cero
else
   for ii=1:n_nzac
       % numero de ceros previos a coef no cero
       if ii == 1
           number_of_zeros = nonzero_ac(1)-2;   %2 es el indice del primer coef ac
       else
           number_of_zeros = nonzero_ac(ii) - nonzero_ac(ii-1) -1;
       end
       runlen = [runlen; number_of_zeros, Dqz(nonzero_ac(ii))];
   end % for ii=1:n_nzac
   
   if nonzero_ac(n_nzac) ~= 64     % si el ultimo no cero no es el 64 hay que poner EOB
       runlen = [runlen; -1  nan];
   end
    
   
   
   
   
   
end %if n_nzac == 0

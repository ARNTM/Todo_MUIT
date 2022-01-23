%%%%%%%%% Representa la constelación de la señal en el campo
%%%%%%%%% "signal", muestreando la señal
%%%%%%%%% los parámetros de entrada son:
%%%%% t: Vector de tiempo
%%%%% signal: Señal a representar que debe ser real
%%%%% Tb: Tiempo de símbolo
%%%%% puntos: Número de puntos por símbolo
%%%%% N_simbolos: número de simbolos que componen la señal
%%%%% muestreo: permite desplazar el punto de muestreo dentro
%%%%% del intervalo de símbolo, siendo 0.5 para mirad de simbolo
%%%%% y hasta 0 y 1 para ir hacia los extremos
function IQ_rep(t,signal,Tb,N_simbols,muestreo);
signal=signal+1j*1e-9;
t_muestras=Tb*(1:1:N_simbols)-(Tb*muestreo);
sampled=interp1(t,signal,t_muestras);
figure
plot(sampled,'r.')
title('Diagrama I/Q')
a=axis;
amp=a(4)-a(3);
dif_t=a(2)-a(1);
amp=max(amp,dif_t);
a(1)=a(1)-amp*0.1;
a(2)=a(2)+amp*0.1;
a(3)=a(3)-amp*0.1;
a(4)=a(4)+amp*0.1;
axis(a);
grid on
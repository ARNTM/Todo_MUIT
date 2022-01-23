%%%%%%%%% Representa el espectro óptico de la señal introducida
%%%%%%%%% en el campo "signal", los parámetros de entrada son:
%%%%% t: Vector de tiempo
%%%%% signal: Señal a representar que debe ser real
%%%%% Tb: Tiempo de símbolo
function osa_rep(t,signal,Tb);
ts=t(2)-t(1);
p=length(t);
rango=4*(1/Tb)/1e9;
frec=((((-p/2)+1:1:p/2)/p)*(1/ts))/1e9;
figure
Espectro_dB=20*log10(abs(fftshift((fft(signal)))));
Espectro_dB=Espectro_dB-max(Espectro_dB);
plot(frec,Espectro_dB);
title('Espectro óptico')
a=axis;
a(1)=-rango;
a(2)=rango;
a(3)=-90;
a(4)=10;
axis(a);
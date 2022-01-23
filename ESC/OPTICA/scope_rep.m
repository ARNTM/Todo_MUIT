%%%%%%%%% Representa el diagrama de ojos de la señal que se
%%%%%%%%% introduzca
%%%%%%%%% en el campo "signal", los parámetros de entrada son:
%%%%% t: Vector de tiempo
%%%%% signal: Señal a representar que debe ser real
%%%%% n_ojos: Número de ojos a representas (1 o 2 normalmente)
%%%%% puntos: Número de puntos por símbolo
function scope_rep(t,signal,n_ojos,puntos);
puntos=puntos*n_ojos;
ts=t(2)-t(1);
t_eje=(-(puntos/2)+1:1:puntos/2)*ts;
simbolos=(length(t)/puntos)*n_ojos;
figure
for n=1:1:(simbolos/n_ojos)
t_n=((n-1)*puntos+1:1:(n*puntos));
plot(t_eje,signal(t_n))
title('Diagrama de ojos')
hold on
end
a=axis;
amp=(a(4)-a(3));
dif_t=a(2)-a(1);
a(1)=a(1)-dif_t*0.1;
a(2)=a(2)+dif_t*0.1;
a(3)=a(3)-amp*0.1;
a(4)=a(4)+amp*0.1;
axis(a);
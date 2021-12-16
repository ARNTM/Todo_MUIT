close all
clear all

% OOK ejemplo
%M=1; % bits por símbolo
%V=[1 0]; % vector de simbolos (con parte real y compleja)
%V=V/max(real(V));

%BPSK ejemplo
% M=1;
% V=[-1 1];
% V=V/max(real(V));

% QPSK
M=2;
V=[1+1i -1+1i 1-1i -1-1i];
V=V/max(real(V));

% 16-QAM
% M = 4;
% X = 0:2^M-1;
% V = qammod(X, 2^M);
% V = V/max(real(V));

% 64-QAM
% M = 6;
% X = 0:2^M-1;
% V = qammod(X, 2^M);
% V = V/max(real(V));

%%%%% Parámetros básicos de la simulación
N_simbols=512;
N_bits=N_simbols*M;
data=idinput(N_bits,'PRBS',[0 1],[0 1])';

puntos_por_simbolo=100;
B=10e9;
Tb=1/B;
ts=Tb/puntos_por_simbolo;

puntos=puntos_por_simbolo* N_simbols;
t=(1:1:puntos)*ts;

RZ=1; % Retorno cero (control)
vI1 = [];
vQ1 = [];
%%%%%%% Niveles de I / Q %%%%%%%%%%%%%%%%%%%

signal=zeros(size(t));
Vpi = 5;
for n=1:1:N_simbols
    simbol_index = bin2dec(num2str(data(M*(n-1)+1:1:M*(n-1)+M)));
    valor_IQ = V(simbol_index+1); % Simbolo OOK = 1 o 0

    vI1 = Vpi * acos(real(valor_IQ))/pi;
    vQ1 = Vpi * acos(imag(valor_IQ))/pi;
    
    vI2 = -vI1;
    vQ2 = -vQ1;
    vx(n,:)=[vI1 vI2 vQ1 vQ2];
end

figure()
subplot(411)
stem(vx(:,1)); title('VI1')
xlim([100 120])
ylim([-5 5])
subplot(412)
stem(vx(:,2)); title('VI2')
xlim([100 120])
ylim([-5 5])
subplot(413)
stem(vx(:,3)); title('VQ1')
xlim([100 120])
ylim([-5 5])
subplot(414)
stem(vx(:,4)); title('VQ2')
xlim([100 120])
ylim([-5 5])
xlabel('Número de símbolo')

%%%%%%%% construir las señales electicas
e_signal_I1=[];
e_signal_I2=[];
e_signal_Q1=[];
e_signal_Q2=[];
unos=ones(size(1:1:puntos_por_simbolo));

for n=1:1:N_simbols
    e_signal_I1=[e_signal_I1 unos*vx(n,1)];
    e_signal_I2=[e_signal_I2 unos*vx(n,2)];
    e_signal_Q1=[e_signal_Q1 unos*vx(n,3)];
    e_signal_Q2=[e_signal_Q2 unos*vx(n,4)];
end

vent=10;
e_signal_I1=conv(e_signal_I1,1+cos(pi*[-vent:1:vent]/vent),'same');
e_signal_I1=e_signal_I1/sum(1+cos(pi*[-vent:1:vent]/vent));
e_signal_I2=conv(e_signal_I2,1+cos(pi*[-vent:1:vent]/vent),'same');
e_signal_I2=e_signal_I2/sum(1+cos(pi*[-vent:1:vent]/vent));
e_signal_Q1=conv(e_signal_Q1,1+cos(pi*[-vent:1:vent]/vent),'same');
e_signal_Q1=e_signal_Q1/sum(1+cos(pi*[-vent:1:vent]/vent));
e_signal_Q2=conv(e_signal_Q2,1+cos(pi*[-vent:1:vent]/vent),'same');
e_signal_Q2=e_signal_Q2/sum(1+cos(pi*[-vent:1:vent]/vent));

figure()
subplot(411)
plot(t,e_signal_I1)
xlim([1*10^-8 1.5*10^-8])
ylim([-5 5])
subplot(412)
plot(t,e_signal_I2)
xlim([1*10^-8 1.5*10^-8])
ylim([-5 5])
subplot(413)
plot(t,e_signal_Q1)
xlim([1*10^-8 1.5*10^-8])
ylim([-5 5])
subplot(414)
plot(t,e_signal_Q2)
xlim([1*10^-8 1.5*10^-8])
ylim([-5 5])

xlabel('Tiempo (s)')

fi_I1 = pi*(e_signal_I1/Vpi);
fi_I2 = pi*(e_signal_I2/Vpi);
fi_Q1 = pi*(e_signal_Q1/Vpi);
fi_Q2 = pi*(e_signal_Q2/Vpi);

brazo_I = (1/2)*(exp(1i*fi_I1) + exp(1i*fi_I2));
brazo_Q = (1/2)*(exp(1i*fi_Q1) + exp(1i*fi_Q2));

carver=sin((pi/2)*(1+sin(pi*(t-Tb/2)/Tb)));

if (RZ == 1)
    salida = (1/2)*(brazo_I+1i*brazo_Q).*carver;
else
    salida = (1/2)*(brazo_I+1i*brazo_Q);
end

figure()
plot(t,real(salida),'b');
hold on
plot(t,imag(salida),'r');
plot(t,abs(salida),'g');
xlim([1.2*10^-8 1.3*10^-8])
ylim([-1 1])
xlabel('Tiempo (s)')

IQ_rep(t,(salida),Tb,N_simbols,0.5)
%scope_rep(t,abs(salida),2,puntos_por_simbolo)
%osa_rep(t,real(salida),Tb)

%% FIBRA OPTICA
c = 3e5;
ll = 1550;

D = 17;
S = 0.08;
L = 50;

beta2 = -D*(ll^2/(2*pi*c))*1e-24;
beta3 = 1e-36*S*(11^2/(2*pi*c))^2;

p=length(t);
dw=2*pi*((((-p/2)+1:1:p/2)/p)*(1/ts));

FWHM = 100e9;
W_1_e = FWHM/1.665;
m = 1;

filtro = sqrt(exp(-(dw/(2*pi*W_1_e)).^(2*m)));

beta2L = beta2*L;
beta3L = beta3*L;

espectro_salida_fibra = fftshift(fft(salida)).*exp(1j*(1/2)*beta2L*dw.^2).*exp(1j*(1/6)*beta3L*dw.^3).*filtro;
tras_fibra=ifft(fftshift(espectro_salida_fibra));

%% RECEPTOR

fi = 0*pi/10;
oscilador_local = exp(1j*fi)*ones(size(t));
df = 0*0.5e6;
oscilador_local = oscilador_local.*exp(1j*2*pi*df*t);
a = tras_fibra;
b = oscilador_local;
s1 = (a+b)/2;
s2 = (a-b)/2;
s3 = (a+1j*b)/2;
s4 = (a-1j*b)/2;
i1 = abs(s1).^2;
i2 = abs(s2).^2;
i3 = abs(s3).^2;
i4 = abs(s4).^2;
i_I = i1-i2;
i_Q = i3-i4;
i_Total = i_I + 1j*i_Q;

IQ_rep(t,i_Total,Tb,N_simbols,0.5)
%scope_rep(t,abs(i_Total),2,puntos_por_simbolo)
% osa_rep(t,i_Total,Tb)

figure()
plot(t,real(i_Total),'b');
hold on
plot(t,imag(i_Total),'r');
plot(t,abs(i_Total),'g');
xlim([1.2*10^-8 1.3*10^-8])
ylim([-1 1])
xlabel('Tiempo (s)')

SNR=25;
SNRlin=10.^(SNR/10);

i_media=mean([mean(i1) mean(i2) mean(i3) mean(i4)]);
desv_ruido=sqrt((i_media.^2)/SNRlin);

rt1=(rand(size(t))-0.5*ones(size(t)))*desv_ruido;
rt2=(rand(size(t))-0.5*ones(size(t)))*desv_ruido;
rt3=(rand(size(t))-0.5*ones(size(t)))*desv_ruido;
rt4=(rand(size(t))-0.5*ones(size(t)))*desv_ruido;

i1=i1+rt1;
i2=i2+rt2;
i3=i3+rt3;
i4=i4+rt4;
i_I = i1-i2;
i_Q = i3-i4;
i_Total = i_I + 1j*i_Q;

IQ_rep(t,i_Total,Tb,N_simbols,0.5)

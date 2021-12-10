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
% M=2;
% V=[1+1i -1+1i 1-1i -1-1i];
% V=V/max(real(V));

% 16-QAM
% M = 16;
% X = 0:2^M-1;
% V = qammod(X, 2^M);
% V = V/max(real(V));

% 64-QAM
M = 6;
X = (0:2^M-1)';
V = qammod(X, 2^M);

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

brazo_I = (1/2)*(exp(1i*fi_I1)) + exp(1i*fi_I2);
brazo_Q = (1/2)*(exp(1i*fi_Q1)) + exp(1i*fi_Q2);

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
xlim([1*10^-8 1.5*10^-8])
ylim([-1 1])
xlabel('Tiempo (s)')

IQ_rep(t,real(salida),Tb,N_simbols,0.5)
scope_rep(t,real(salida),2,N_simbols)
osa_rep(t,real(salida),Tb)

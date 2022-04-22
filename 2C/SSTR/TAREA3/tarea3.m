clear all;
close all;

load('Channel.mat', 'data_URA');
d = 3.04e-3;
X1 = 5;
X2 = 8;
X3 = 4;
X4 = 5;
X5 = 1;
X6 = 2;
X7 = 1;
X8 = 5;

M = floor((11/9)*X3 + 1);
N = floor((11/9)*X1 + 1);
own_data = reshape(data_URA(M,N,:),1,[]);

%% Apartado 1
SPAN = (40e9 - 25e9);
reso = SPAN/8192;

%% Apartado 2
f_int = 25e9:SPAN/8191:40e9;
figure("Name",'Transferencia cronovariable');
plot(f_int*1e-9,20*log10(own_data))
title('Transferencia cronovariable');
xlabel('Frecuencia (GHz)');
ylabel('T(f,to)');
set(gca,'FontSize',15)


%% 
ADPD = zeros(1,8192);
for i = 1:12
    for j = 1:12
        PDP = abs(ifft(reshape(data_URA(i,j,:),1,[]))).^2;
        PDP_norm = PDP/max(PDP);
        ADPD = ADPD + PDP_norm;
    end
end
ADPD = ADPD/144;

%% Apartado 3
h = ifft(own_data);
PDP = abs(h).^2;
PDP_normalizado= PDP/max(PDP);
t_ns= linspace(0,8192/SPAN,8192);

figure("Name", 'PDP');
plot(t_ns*1e7, PDP_normalizado);
xlabel('{\tau (ns)}');
ylabel('DPD');
set(gca,'FontSize',15)

figure("Name", 'PDP DB');
plot(t_ns*1e7, 20*log10(PDP_normalizado));
xlabel('Tiempo (ns)');
ylabel('DPD (dB)');
set(gca,'FontSize',15)
t_prop = t_ns(PDP_normalizado(:) == max(PDP_normalizado));
distancia = t_prop*3e8;

%% Apartado 4
Thresh = find(20*log10(PDP_normalizado) >= -20);
ret_medio = sum(t_ns(Thresh).*PDP_normalizado(Thresh))/sum(PDP_normalizado(Thresh));
delay_spread = sqrt(sum(((t_ns(Thresh) - ret_medio).^2).*abs(PDP_normalizado(Thresh)))/sum(PDP_normalizado(Thresh)));

figure(4)
hold on
plot(t_ns*1e7,20*log10(PDP_normalizado))
media_v = ones(1,8192);
TH=-20*media_v;
%hold on
%plot(t_ns,TH)
%hold on 
plot(t_ns*1e7, 20*log10(ADPD))
xlabel('Retardo (ns)');
ylabel('DPD (dB)');
set(gca,'FontSize',15)

th = 10:0.001:160;
delay_spread_array = zeros(1,length(th));

for i = 1:1:length(th)
    Thresh3 = find(20*log10(PDP_normalizado) >= -th(i));
    ret_medio1 = sum(t_ns(Thresh3).*PDP_normalizado(Thresh3))/sum(PDP_normalizado(Thresh3));
    delay_spread1 = sqrt(sum(((t_ns(Thresh3) - ret_medio1).^2).*abs(PDP_normalizado(Thresh3)))/sum(PDP_normalizado(Thresh3)));
    delay_spread_array(i) = delay_spread1;
end
figure(5)
plot(th, delay_spread_array);
xlabel('Threshold (dB)');
ylabel('Delay-Spread');
set(gca,'FontSize',15);

%% Correlación
correlacion = abs(fftshift(fft(PDP))).^2;
correlacion= correlacion/max(correlacion);
figure(6)
plot(f_int*10e-10,correlacion)
xlabel('Frecuencia (GHz)');
ylabel('Correlación');
set(gca,'FontSize',15);

%% Correlación 1
correlacion = abs(fftshift(fft(ADPD))).^2;
correlacion= correlacion/max(correlacion);
figure(7)
plot(f_int*10e-10,correlacion)
xlabel('Frecuencia (GHz)');
ylabel('Correlación');
set(gca,'FontSize',15);

Thresh = find(20*log10(ADPD) >= -98);
ret_medio_ADPD = sum(t_ns(Thresh).*ADPD(Thresh))/sum(ADPD(Thresh));
delay_spread_ADPD = sqrt(sum(((t_ns(Thresh) - ret_medio).^2).*abs(ADPD(Thresh)))/sum(ADPD(Thresh)));




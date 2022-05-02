clear all;
close all;

load('Channel.mat', 'data_URA');
d = 3.04e-3;
X1 = 5;
X3 = 4;

M = floor((11/9)*X3 + 1);
N = floor((11/9)*X1 + 1);
own_data = reshape(data_URA(M,N,:),1,[]);

%% Apartado 1
SPAN = (40e9 - 25e9);
reso = SPAN/8192;

%% Apartado 2 - Función de transferencia cronovariable
f_int = 25e9:SPAN/8191:40e9;
plot(f_int*1e-9,20*log10(own_data))

%% Apartado 3 - PDP
t_ns = linspace(0,8192/SPAN,8192);
h = ifft(own_data);
PDP = abs(h).^2;
PDP_normalized = PDP/max(PDP);

figure(1)
plot(t_ns, PDP_normalized)
figure(2)
plot(t_ns, 20*log10(PDP_normalized))

t_prop = t_ns(PDP_normalized(:) == max(PDP_normalized));
dist = t_prop*3e8;

%% Apartado 4 - Delay-Spread
filter = find(20*log10(PDP_normalized) >= -20);
ret_medio = sum(t_ns(filter).*PDP_normalized(filter))/sum(PDP_normalized(filter));
delay_spread = sqrt(sum(((t_ns(filter) - ret_medio).^2).*abs(PDP_normalized(filter)))/sum(PDP_normalized(filter)));

%% Apartado 5 - TH MAX
th = 10:0.001:160;
delay_spread_array = zeros(1,length(th));

for i = 1:1:length(th)
    filter = find(20*log10(PDP_normalized) >= -th(i));
    ret_medio = sum(t_ns(filter).*PDP_normalized(filter))/sum(PDP_normalized(filter));
    delay_spread = sqrt(sum(((t_ns(filter) - ret_medio).^2).*abs(PDP_normalized(filter)))/sum(PDP_normalized(filter)));
    delay_spread_array(i) = delay_spread;
end

plot(th, delay_spread_array);

%% Apartado 6 - Ancho de banda de coherencia
correlacion = abs(fftshift(fft(PDP))).^2;
correlacion = correlacion/max(correlacion);
figure(6)
plot(f_int*10e-10,correlacion)

%% Apartado 7 - Ancho de banda de coherencia con APDP
ADPD = zeros(1,8192);
for i = 1:12
    for j = 1:12
        PDP = abs(ifft(reshape(data_URA(i,j,:),1,[]))).^2;
        PDP_norm = PDP/max(PDP);
        ADPD = ADPD + PDP_norm;
    end
end
ADPD = ADPD/144;

correlacion = abs(fftshift(fft(ADPD))).^2;
correlacion = correlacion/max(correlacion);
figure(7)
plot(f_int*10e-10,correlacion)
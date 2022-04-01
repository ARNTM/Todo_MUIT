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
SPAN = (40e9 - 25e9);
reso = SPAN/8192;
f_int = 25e9:SPAN/8191:40e9;

figure("Name",'Transferencia cronovariable');
plot(f_int*1e-9,20*log10(own_data))
t = title('Transferencia cronovariable');
t.FontSize = 20;
xl = xlabel('Frecuencia (GHz)');
xl.FontSize = 20;
yl = ylabel('T(f,to)');
yl.FontSize = 20;

h = ifft(own_data);
PDP = abs(h).^2;
PDP_normalizado= PDP/max(PDP);
t_ns= linspace(0,8192/SPAN,8192);

figure("Name", 'PDP');
plot(t_ns, PDP_normalizado);
xlabel('Tiempo (ns)');
ylabel('Densidad de potencia');

figure("Name", 'PDP DB');
plot(t_ns, 20*log10(PDP_normalizado));
xlabel('Tiempo (ns)');
ylabel('Densidad de potencia (dB)');

t_prop = t_ns(PDP_normalizado(:) == max(PDP_normalizado));
dist = t_prop*3e8;

Thresh = find(20*log10(PDP_normalizado) >= -20, 1, 'last');
ret_medio = sum(t_ns(1:Thresh).*PDP_normalizado(1:Thresh))/sum(PDP_normalizado(1:Thresh));
delay_spread = sqrt(sum(((t_ns(1:Thresh) - ret_medio).^2).*abs(PDP_normalizado(1:Thresh)))/sum(PDP_normalizado(1:Thresh)));

Thresh2 = find(20*log10(PDP_normalizado) >= -20,1,'first');
figure(4)
plot(t_ns,20*log10(PDP_normalizado))
hold on
media_v = ones(1,8192);
Thresh2=-20*media_v;
hold on
plot(t_ns,Thresh2)
xlabel('Retardo (ns)');
ylabel('Densidad de potencia(dB)');


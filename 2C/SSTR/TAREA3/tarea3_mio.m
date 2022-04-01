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
S = reshape(data_URA(M,N,:),1,[]);

SPAN = (40e9 - 25e9);
reso = SPAN/8192;
f_int = 25e9:SPAN/8191:40e9;

figure
plot(f_int*1e-9,20*log10(S))

h = ifft(S);
PDP = abs(h).^2;
PDP_normalizado= PDP/max(PDP);

t_ns= linspace(0,8192/SPAN,8192);

figure
plot(t_ns, PDP_normalizado);

figure
plot(t_ns, 20*log10(PDP_normalizado));
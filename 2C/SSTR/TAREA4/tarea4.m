clear all;
close all;

x1 = 5;
x2 = 8;
x3 = 4;
x4 = 5;
x5 = 1;
x6 = 2;
x7 = 1;
x8 = 5;

ruido_termico = 4 + x1*10^-1;
shadowing = 6 + x2*10^-1;
perdidas_penetracion = 10 + x7*10^-1;
tx_min = 15;
freq = 2.6;
P_max = 43;
G_eNB = 3;
P_conectores = 1;
P_cable = 1 + x5*10^-1;
h = 6.5;

MF = sqrt(2)*shadowing*erfinv(2*(0.95-0.5));

p = 0:0.0001:1;
CI = 1./(2.*p+0.155);
CI2 = 1./(2.263.*p + 0.155);

plot(p,CI)
hold on
plot(p,CI2)
legend("2 eBN", "8 eBN")
xlabel("p")
ylabel("CIR")
set(gca,'FontSize',15)

sinr = 1./(0.333 + 2.263.*p + 0.155);
figure()
plot(p,sinr)
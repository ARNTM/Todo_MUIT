N = 5;
Ripple = 0.1;
BandWidth = 5.2;
Z0 = 50;
f = linspace(1.6e9,3.6e9,50);
EpsilonR = 6.15;
Height = 1.27e-3;
f_filter = 2.6e9;

filter = filterHairpin;
filter.FilterOrder = N;
filter.Height = Height;
filter.Substrate.EpsilonR = EpsilonR;
filter = design(filter,2.6e9,FBW=BandWidth,RippleFactor=Ripple);
figure;
show(filter);
view(-37,35);

spar = sparameters(filter,f);
figure;
rfplot(spar);
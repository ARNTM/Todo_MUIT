clc,clear

Enrejado = [1 1 -1 -1 ; 1 3 1 1; 2 1 1 1; 2 3 -1 -1; 3 2 1 -1; 3 4 -1 1; 4 4 1 -1; 4 2 -1 1];
La = [0 0 0 0]';
y = [0.8 0.1 1 -0.5 -1.8 1.1 1.6 -1.2 -0.5 0.1]';
Lc = 1;

bcjr(y,Lc,La,Enrejado)
clear all
% Updated by Rakesh Panwar
% 4. A Simple Program 
% The following source code, in QuickBasic, is a simple implementation of the above model to illustrate the steps 
% involved. This implementation does not allow for variations 
% in the space environment, and as a result is only suitable 
% for short time periods, or during longer times when solar and geomagnetic activity do not show significant variation. 
% This generally only occurs around the years of solar minimum. 
% ' SATELLITE ORBITAL DECAY 
% 'get required input parameters from keyboard 
%INPUT "Satellite name "; 
N='Politech.1'; 
%INPUT "Satellite mass (kg) "; 
M=1; 
%INPUT "Satellite area (m^2) "; 
A=0.1^2;
%INPUT "Starting height (km) "; 
H=500; %H=[200, 300, 400, 500]; 
%INPUT "Solar Radio Flux (SFU) "; 
F10=72.3; % 162.7 72.3
%INPUT "Geomagnetic A index "; 
Ap=4; %[5, 4]; 

Re = 6378000;
Me = 5.98E+24;                %'Earth radius and mass (all SI units) 
G = 6.67E-11;                  %                            'Universal constant of gravitation 
T = 0;
dT = .1;              %'time & time increment are in days 
D9 = dT * 3600 * 24;                       %           'put time increment into seconds 
H1 = 10;
H2 = H;                           %             'H2=print height, H1=print height increment 
R = Re + H * 1000;                          %          'R is orbital radius in metres 
P = 2*pi*(R * R * R / (Me * G))^0.5;       %'P is period in seconds 'now iterate satellite orbit with time 

while (H>=180) 
SH = (900 + 2.5 * (F10 - 70) + 1.5 * Ap) / (27 - .012 * (H - 200)); 
DN = 6E-10 * exp(-(H - 175) / SH);         %'atmospheric density 
dP = 3 * pi * A  * R * DN * D9/ M;          % 'decrement in orbital period 
if H <= H2                                    % 'test for print 
    Pm = P / 60;
    MM = 1440 / Pm;
    nMM = 1440 / ((P - dP)*60);    %'print units 
    Decay = dP  * MM/ (dT * P);                         %'rev/day/day 
    display('Time       Height      Period    Mean motion    Decay');
    display('(days)     (km)        (mins)    (rev/day)      (rev/day^2)');
    [T, H , P/60, MM, Decay]               %'do print 
    H2 = H2 - H1;          %                                   'decrement print height 
end      %'end of print routine 

P = P - dP; 
T = T + dT;                               %'compute new values 
R = (G * Me * P * P / (4 * pi * pi)) ^ .33333;%             'new orbital radius 
H = (R - Re) / 1000;                         %           'new altitude (semimajor axis) 
end           %'keep flying satellite 

T 
T/365 

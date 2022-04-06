% Calculates the Discrete-input Continuous-output Memoryless Channel (DCMC) capacity of AWGN and uncorrelated Rayleigh fading channels for BPSK, QPSK, 8PSK and 16QAM.
% Rob Maunder 18/05/2011

% Copyright � 2011 Robert G. Maunder. This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

clear all;
close all;
lw = 4;
fs=14; fs2=3/4*fs; fn='Helvetica';
% +---------------------------------------------+
% | Choose the SNR, modulation and channel here |
% +---------------------------------------------+

% Affects the accuracy and duration of the simulation
symbol_count = 10000; % use 10 for fast trials, 10000 for accuracy

% Channel SNR
snr = -20:1:30; % dB use [3 6 10] for speed 

% $$$ % Modulation scheme examples (SEE modfnc.m)

% Channel
% -------

% Uncorrelated Rayleigh fading channel / DO NOT USE NOW
%channel = sqrt(1/2)*(randn(1,symbol_count)+i*randn(1,symbol_count));

% AWGN channel
channel = ones(1,symbol_count);


% +------------------------+
% | Simulation starts here |
% +------------------------+

channel_capacity = zeros(size(snr));

lgd = ['BPSK       '
       'OOK        '
       '2-ASK/2-PSK'
       '4-ASK/2-PSK'
       'QPSK       '
       '8-PSK      '
       '2-ASK/4-PSK'
       '16-QAM     '
       ];

% This is just some colors for the different lines in the plot
[nm,NAN]=size(lgd);
CM = jet(nm);

% SELECT MODULATION
% All the modulations
% mod_start = 1; mod_end = nm;
% Just 1 of the list, for example BPSK
mod_start = 1; mod_end = 1;

for m=mod_start:mod_end,
    modulation = modfnc_STUDENT(m);

    for index = 1:length(snr)

        % Generate some random symbols
        symbols = ceil(length(modulation)*rand(1,symbol_count));

        % Generate the transmitted signal
        tx = modulation(symbols);

        % Generate some noise
        N0 = 1/(10^(snr(index)/10)); % 1/ porque se supone que la potencia media transmitida es la unidad
        noise = sqrt(N0/2)*(randn(1,symbol_count)+1i*randn(1,symbol_count)); % ruido en amplitud (transparencia 28)

        % Generate the received signal
        rx = tx.*channel+noise; % en canal es todo 1s

        % Calculate the symbol probabilities
        % this equation corresponds with the termed "channel equation" for
        % discrete input / complex output channels
        % note that the probabilities are calculated comparing the
        % received symbol with all the possible modulation symbols
        probabilities = max(exp(-(abs(ones(length(modulation),1)*rx - modulation.'*channel).^2)/N0),realmin);

        % Normalise the symbol probabilities
        probabilities = probabilities ./ (ones(length(modulation),1)*sum(probabilities));

        % Calculate the capacity
        % the capcity is calculated as a reduction of the source entropy +
        % average entropy generated by noise and contained in the received sequency
        % STUDENT 
        channel_capacity(index) = log2(length(modulation)) - sum(log2(probabilities(1,:)));
    end
% $$$     disp('Modulation')
% $$$     disp(lgd(m,:))
% $$$     disp('Modulation average power')
% $$$     disp(mean(abs(modulation).^2))
    CHN_CAP(:,m) = channel_capacity(:);
    SNR(:,m) = snr(:);
end

% $$$ figure
% $$$ plot(snr,channel_capacity);
% $$$ xlabel('SNR [dB]');
% $$$ ylabel('Capacity [bit/s/Hz]')
% $$$ 
% $$$ figure
% $$$ plot(snr-10*log10(channel_capacity),channel_capacity);
% $$$ xlabel('E_b/N_0 [dB]');
% $$$ ylabel('Capacity [bit/s/Hz]')

for k=1:nm,
    figure(1)
    set(gcf,'color','w');box(gca,'on');grid('on');hold('on');
    set(gca,'fontsize',fs,'fontname',fn) ;set(gcf,'Position',[20 40 700 500]);

    plot(SNR(:,k),CHN_CAP(:,k),'color',CM(k,:),'linewidth',lw);
end
shannon = log2(1+10.^(snr/10));
plot(snr, shannon,'k','linewidth',lw); hold off;
xlabel('SNR [dB]');
ylabel('Capacity [bit/symbol]')
h=legend(lgd,'location','northwest'); set(h,'fontsize',fs2);
set(gca,'xlim',[0 24],'xtick',[0:2:24]);
set(gca,'ylim',[0 4.5],'ytick',[0:1:4]);
savero('C_vs_SNR')

for k=1:nm,
    figure(2)
    set(gcf,'color','w');box(gca,'on');grid('on');hold('on');
    set(gca,'fontsize',fs,'fontname',fn) ;set(gcf,'Position',[20 40 700 500]);
    plot(SNR(:,k)-10*log10(CHN_CAP(:,k)),CHN_CAP(:,k),'color',CM(k,:),'linewidth',lw);
end
plot(snr-10*log10(shannon), shannon,'k','linewidth',lw); hold off;
xlabel('E_b/N_0 [dB]');
ylabel('Capacity [bit/symbol]')
h=legend(lgd,'location','northwest'); set(h,'fontsize',fs2);
set(gca,'xlim',[-2 16],'xtick',[-2:2:16]);
set(gca,'ylim',[0 4.5],'ytick',[0:1:4]);


savero('C_vs_SNRb')
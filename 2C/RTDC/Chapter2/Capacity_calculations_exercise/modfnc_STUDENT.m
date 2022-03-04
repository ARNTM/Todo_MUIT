function [m]=modfnc(n)

%If you add more modulation schemes here, make sure their average transmit power is normalised to unity
switch n
  case 1
    % 2PSK / BPSK
    m = [+1, -1];
  case 2
    % OOK
    m = [];
  case 3
    % 2-ASK / 2-PSK
    m = [] / sqrt();
  case 4
    % 4-ASK / 2-PSK
    m = [] / sqrt();
  case 5
    % 4-QAM or QPSK
    m = [] ;
  case 6
    % 8PSK
    m = [];

  case 7
    % 2-ASK / 4-PSK
    m = [] / sqrt();
  case 8
    % 16-QAM
    m = sqrt()*[];
  case 9
  case 10
  case 11
  case 12
end

    
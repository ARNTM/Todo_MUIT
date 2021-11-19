function [c] = turbo_codificador (x,Enrejado)
    hCC = comm.ConvolutionalEncoder(Enrejado,'TerminationMethod','Terminated');
    x_entre = randintrlv(x,12);
    x_codif = step(hCC,x);
    x_entre_codif = step(hCC,x_entre);
    c(1:3:3*length(x)) = x_codif(1:2:2*length(x));
    c(2:3:3*length(x)) = x_codif(2:2:2*length(x));
    c(3:3:3*length(x)) = x_entre_codif(2:2:2*length(x));
    c(3*length(x)+1:3*length(x)+2*log2(Enrejado.numStates)) = x_codif(length(x_codif)-2*log2(Enrejado.numStates)+1:end)';
    c(3*length(x)+2*log2(Enrejado.numStates)+1:3*length(x)+4*log2(Enrejado.numStates)) = x_entre_codif(length(x_entre_codif)-2*log2(Enrejado.numStates)+1:end)';
    c = c';
end
function [x_mmse] = mmse(y,H,M,potencia_ruido,Ntx)
    s= (H'*H+potencia_ruido*eye(Ntx))^(-1)*H'*y;
    x_mmse=cuantif(s,M,Ntx);
end
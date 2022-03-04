function [x_zf] = zf(y,H,M,Ntx)
    s=H\y;
    x_zf=cuantif(s,M,Ntx);
end

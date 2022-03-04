function [BitsDec,LLR] = turbo_decodificador (y,Lc,Enrejado,Niter)
    hDec=comm.APPDecoder('TrellisStructure',Enrejado,'TerminationMethod','Terminated','Algorithm','Max');
    
    ys(1:1:1152) = y(1:3:3*1152);
    y1c(1:1:6) = y(3457:1:3456+6);
    y2c(1:1:6) = y(3463:1:3468);

    yc1(1:2:1152*2) = y(1:3:3*1152);
    yc1(2:2:1152*2) = y(2:3:3*1152);
    yc1 = [yc1 y1c]';

    ys_desentrelazado = randintrlv(ys,12);
    yc2(1:2:1152*2) = ys_desentrelazado(1:1:1152);
    yc2(2:2:1152*2) = y(3:3:3*1152);
    yc2 = [yc2 y2c]';

    L21 = zeros(1155,1);
    LcIs = Lc * yc1;
    LcIe = Lc * yc2;

    for i=1:Niter
    
        LUs = step(hDec,L21,LcIs);
        Le_s = LUs-LcIs(1:2:end);
        L12 = [randintrlv(Le_s(1:1152),12); 0; 0; 0];
        
        LUe = step(hDec,L12,LcIe);
        Le_e = LUe-LcIe(1:2:end);
        LLR(:,i) = LUe+L12;
        L21 = [randdeintrlv(Le_e(1:1152),12); 0; 0; 0];
    
    end

    LLR= LLR(:,6);
    LLR=randdeintrlv(LLR(1:1152),12);
    BitsDec = LLR>0;
    
end
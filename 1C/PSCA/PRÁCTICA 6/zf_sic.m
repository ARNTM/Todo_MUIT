function [x_zfsic] = zf_sic(y,H,M,Ntx)
    [Q,R]=qr(H);
    z=Q'*y;
    
    s=zeros(Ntx,1);
    x_zfsic=zeros(Ntx,1);
    
    s(Ntx)=z(Ntx)/R(Ntx,Ntx);
    x_zfsic(Ntx)=cuantif(s(Ntx),M,Ntx);
    
    for i = Ntx-1:-1:1
        sum = 0;
        for l = i+1:1:Ntx
            sum = sum + R(i,l).*x_zfsic(l);
        end
        s(i) = (z(i)-sum)/R(i,i);
        x_zfsic(i) = cuantif(s(i),M,Ntx);
    end
end
%% Andrés Ruz Nieto
function [LLR] = bcjr(y,Lc,La,Enrejado)
%y = vector recibido de N n-bits (vector columna) 
%La columna (información a priori)


M =  size(Enrejado,1)/2; %Número de estados en cada etapa
N=length(y)/2;

Gamma=zeros(M*2,N);
Alfa=zeros(M,N);
Beta=zeros(M,N);
LLR = zeros(N,1);


La=La(:);

%% PASO 1: Calculo de Gamma.
for k=1:N
    for m=1:M*2
         GammaAux = y(k,1)*La/2+Lc/2*(Enrejado(m,3:4)*y(2*k-1:2*k));
         Gamma(m,k) = GammaAux(1);
    end
end


%% PASO 2: Cálculo de Alpha.
% Inicializamos los valores de Alpha en la primera etapa.
Alfa(1,1) = 0;
for m=2:M
    Alfa(m,1) = -inf;
end
 
% Calculamos los valores de Alpha. 
for k=2:N
    for m = 1:M
        posi=find(m==Enrejado(:,2));
        Alfa(m,k) =  max(Alfa(Enrejado(posi),k-1)+Gamma(posi,k-1));
    end
end
 
%% PASO 3: Cálculo de Beta.
% Inicializamos los valores de Beta en la última etapa.
Beta(1,N)=0;
for m=2:M
    Beta(m,N)=-inf;
end

% Calculamos los valores de Beta. 
for k=N:-1:2
    for m = 1: M     
        posi=find(m==Enrejado(:,1));
        Beta(m,k-1) = max(Beta(Enrejado(posi,2),k)+Gamma(posi,k));
    end
end

%% PASO 4: Cálculo de los LLRs.
for k=1:N
    for m = 1:M
        p1 = find(1==Enrejado(:,3));
        camino_uno(m)= max(Alfa(Enrejado(p1,1),k) + Gamma(p1,k) + Beta(Enrejado(p1,2),k));
        p0 = find(-1==Enrejado(:,3));
        camino_zero(m)= max(Alfa(Enrejado(p0,1),k) + Gamma(p0,k) + Beta(Enrejado(p0,2),k));
    end
    LLR(k)=max(camino_uno)-max(camino_zero);
end



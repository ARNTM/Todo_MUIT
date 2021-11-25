
%PRÁCTICA 6: Técnicas de detección de señal en comunicaciones
%Programa para evaluar las prestaciones de los decodificadores

 %% Configuración de los parámetros
        Ntx = 4 ; %antenas transmisoras
        Nr  = 4 ; %antenas receptoras
        M   = 32 ; %Modulación empleada M-QAM
        SNR_dB =  5 : 5 : 30 ;
        Num_transmisiones = 10000;   %Número de transmisiones enviadas     
        
for Idx = 1: length ( SNR_dB )         % evaluación del BER para cada SNR    
    num_err_zf = 0 ;
    num_err_mmse = 0 ;
    num_err_zf_sic = 0;
   
    for num = 1 : Num_transmisiones     %número de transmisiones totales
        
            
      %% Transmisor
      
        %%% 1) Bits de información a transmitir
        %XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
        data = randi ([0 1], log2(M) ,Ntx);
        
        %%% 2) Modulamos los bits de información
        %XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
        x = qammod(data,M,'InputType','Bit');
        
      %% Canal  y ruido
        H = sqrt( 1 / 2) * ( randn ( Nr, Ntx ) + 1i *randn ( Nr, Ntx )) ;
        %potencia del ruido
        E = 2 * ( M - 1 ) / 3;   % potencia de un símbolo M-QAM
        x = x / sqrt ( E * Ntx ); % normalizamos para que la potencia de la señal a enviar sea 1.
        potencia_senyal = 1 ;
        potencia_canal = 1;        % ruido gaussiano de media nula y varianza unidad
        potencia_ruido = potencia_senyal * potencia_canal  / 10^( SNR_dB ( Idx ) / 10 ) ;
        v = sqrt ( potencia_ruido / 2 ) *( randn ( Nr, 1 ) + 1i *randn ( Nr, 1 )) ;
       
     %% Receptor
       
          %señal recibida
          y = H * x.' + v ;
          %%%3) Detectores lineales implementados
         %XXXXXXXXXXXXXXXXXXXXXXXXXX
        [x_zf] = zf(y,H,M,Ntx);
        [x_mmse] = mmse(y,H,M,potencia_ruido,Ntx);
        [x_zf_sic] = zf_sic(y,H,M,Ntx);
        
       % Comprobación de los errores cometidos
       [num_err_zf] = num_err_zf + errores ( x_zf, M, data ) ; 
       [num_err_mmse] = num_err_mmse + errores ( x_mmse, M, data ) ;
       [num_err_zf_sic] = num_err_zf_sic + errores ( x_zf_sic, M, data) ;
    end
    
    %% Calculo del BER
     %XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    [i,j]=size(data);
    TxTot=i*j*Num_transmisiones;
    BER_zf ( Idx ) = num_err_zf/TxTot;
    BER_mmse ( Idx ) = num_err_mmse/TxTot;
    BER_zf_sic ( Idx ) = num_err_zf_sic/TxTot;
end

  figure
  semilogy( SNR_dB, BER_zf, 'mx-' )
  hold on
  semilogy ( SNR_dB, BER_mmse, 'bo-' )
  semilogy ( SNR_dB, BER_zf_sic, 'gd-' )
  legend( 'ZF','MMSE', 'ZF-SIC' )
  xlabel('SNR(dB)') 
  ylabel('BER')
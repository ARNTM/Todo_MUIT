function mijpeg_p1(imC, nombre_salida)
%lee un fichero de imagen y lo escribe en jpeg con el nombre out.jpg
%se ocupa unicamente del coeficiente dc de la imagen de prueba

verbose_level = 1;  % 0 no verbose
                    % 1 bucles principales Horz, Vert, componente 1,2,3 (YCbCr)
                    % 2 Bloque Resultado de la DCT  y DCT cuantificada
                    % 3 nbits, DC, en AC: runlength de ceros y codigo RRRRSSSS
                    % 4  bitstream
% VER LIBRO JPEG DE W. Pennebaker para la descripcion de las etiquetas

% %%%%%%%%%    TABLAS DE HUFFMAN ESTANDARD %%%%%%%%

% Hay cuatro: HUFF_DC_Y, HUFF_DC_CROMA, HUFF_AC_Y, HUFF_AC_CROMA;
% son cell de strings y se utilizan en el codigo que realiza la
% codificacion. 
%LA INFORMACION para especificarlas en la cabecera del fichero jpeg
%para describir estas tablas tambien esta en la funcion tab_huf_std y son 8
%variables que se llaman
% huff_spec_table_bits_DC_Y, huff_spec_table_codes_DC_Y,
% huff_spec_table_bits_DC_CROMA, huff_spec_table_codes_DC_CROMA,
% huff_spec_table_bits_AC_Y, huff_spec_table_codes_AC_Y
% huff_spec_table_bits_AC_CROMA, huff_spec_table_codes_AC_CROMA
% todo ello esta en el fichero tab_huf_std.m 

tab_huf_std;  %carga las tablas en la funcion

zigzag = [1 9  2  3  10 17 25 18 11 4  5  12 19 26 33  ...
        41 34 27 20 13 6  7  14 21 28 35 42 49 57 50  ...
        43 36 29 22 15 8  16 23 30 37 44 51 58 59 52  ...
        45 38 31 24 32 39 46 53 60 61 54 47 40 48 55  ...
        62 63 56 64];
%%%%%%%%%%%%%%%%%%    TABLA PARA LA LUMINANCIA    %%%%%%%%%%%%%%%
qty=[
    16    11    10    16    24    40    51    61;
    12    12    14    19    26    58    60    55;
    14    13    16    24    40    57    69    56;
    14    17    22    29    51    87    80    62;
    18    22    37    56    68   109   103    77;
    24    35    55    64    81   104   113    92;
    49    64    78    87   103   121   120   101;
    72    92    95    98   112   100   103    99];   
     

%%%%%%%%%%%%%%%%%%    TABLA PARA LA CROMINANCIA    %%%%%%%%%%%%%%%


qtc=[
    17  18  24  47  99  99  99  99;
    18  21  26  66  99  99  99  99;
    24  26  56  99  99  99  99  99;
    47  66  99  99  99  99  99  99;
    99  99  99  99  99  99  99  99;
    99  99  99  99  99  99  99  99;
    99  99  99  99  99  99  99  99;
    99  99  99  99  99  99  99  99];

imC=double(imC);

[alt, anch, n_colores]=size(imC);

%%%%%%%%%%%%%%%%%%%% CABECERA DEL FICHERO %%%%%%%%%%%%%%%%%%%%

fid_out=fopen(nombre_salida,'w');   % fichero para ir volcando la salida
fid_cab=fopen('cabecera_paso1.bin', 'r');
cabecera=fread(fid_cab);
fwrite(fid_out,cabecera);
fclose(fid_cab);

%%%%%%%%%%%%%%%   CONTENIDO DE LA IMAGEN %%%%%%%%%%%%%%%%%%%%%%%%

% conversion a YCbCr
% matriz de conversion segun documento JFIF VER 1.02  DE Eric Hamilton
% www.w3.org/Graphics/JPEG/jfif3.pdf
% matriz de conversion
%   ATENCION:  recordad que para hacer la DCT tanto Y, como Cb y Cr, deben estar
%         centradas en cero, por lo que en la matriz de conversion del documento jpeg fif, hay que restar 128 en Y, y no hay que hacer la suma de 128 que propone en las componentes Cb y Cr.

rgbTOycbcr=[
   0.299    0.587    0.114;
   -0.1687  -0.3313  0.5;
   0.5      -0.4187  -0.0813];
   

%para hacerlo de una tacada reordeno la imagen, pongo cada componente de la
%imagen en una fila
n_pixels = anch*alt;
pre=zeros(3,n_pixels);
pre(1,:)=imC(1:n_pixels);
pre(2,:)=imC(n_pixels+1:2*n_pixels);
pre(3,:)=imC(2*n_pixels+1:end);
pre=rgbTOycbcr * pre;

imYCbCr=imC;      %para que sea del mismo tamanyo

%YCbCr tiene luminancia de 0 a 256 pero para la DCT en JPEG se pone de -128 a +127.
imYCbCr(1:n_pixels)=pre(1,:) -128; %luminancia centrada en cero
imYCbCr(n_pixels+1:2*n_pixels)=pre(2,:); % centrada en 0
imYCbCr(2*n_pixels+1:end)=pre(3,:); % centrada en 0

%debug
imYCbCr;

%imYCbCr(:,:,2)=0;   %si descomento esto dejo solo LUMA
%imYCbCr(:,:,3)=0;



buf_bits=[];
DC_anterior=zeros(1,3); % buffers para los 3 coeficiente DC de Y, Cb y Cr

for nb_v=0:(alt/8)-1
   for nb_h=0:(anch/8)-1
      for cmp=1:3     % cmp: componente, 0:Y, 1 y 2: Cb, Cr respectivamente
         
         bits_DC=[];
         
         
         %debug
         if verbose_level >= 3
            display('COEFICIENTE DE CONTINUA')
         end
         B = imYCbCr(nb_v*8+1:nb_v*8+8,nb_h*8+1:nb_h*8+8, cmp); % extrae un bloque de 8x8 de la imagen
         D = dct2(B);

         if cmp == 1  % en el paso 1 solo la luminancia

             
                
         	% REALIZAR:  dividir por la tabla de cuantificación
            	%%%%%% XXXXXXXXXXXXXXXXXXX            
            
                D_div = round(D./qty);

         	% REALIZAR:  calculo de la diferencia del coeficiente de
            %            continua respecto del coef del anterior bloque
            %   llamar "DC_diferencial" al resultado
            	%%%%%%% XXXXXXXXXXXXXXXXXXX

                DC_diferencial = D_div - DC_anterior(cmp);
                DC_anterior(cmp) = DC_diferencial;
            
           	%numero de bits
         	if DC_diferencial == 0
            		nbits = 0;
         	else  
            		nbits = ceil(log2(abs(DC_diferencial)+1));
         	end
       
         	bits_DC_nbits = char(HUFF_DC_Y(nbits+1));  % si no se pone char el tipo es cell y no funciona bien el strcat

         	bits_DC_additional_bits = code_add_bits(DC_diferencial);
         	bits_DC = strcat(bits_DC_nbits, bits_DC_additional_bits);
            
         else % en el paso 1 la croma ponemos cero
               bits_DC=char(HUFF_DC_CROMA(1)); %codigo 0, indice 1 de la tabla              
         end
         
         %debug
         if verbose_level >= 3
             display('COEFICIENTES DE ALTERNA')
         end

         if(cmp == 1) %luma  fin de bloque
            bits_AC = char(HUFF_AC_Y(1)); %codigo cero indice uno
         else %croma
            bits_AC = char(HUFF_AC_CROMA(1));%codigo cero indice uno
         end                    
         
         buf_bits = strcat(buf_bits, bits_DC, bits_AC);

         %escribir en el fichero de 8 en 8 bits, si queda algun resto se escribira al final. 
 
         %debug
         if verbose_level >= 4 buf_bits, end
     
         len_buf=length(buf_bits);    
         n_bytes =floor(len_buf/8); 
         for pp=0:n_bytes-1
            bb=buf_bits(pp*8+1:pp*8+8);
            dd=bin2dec(bb);
            fwrite(fid_out,dd,'uint8');
            if dd==255                        % si aparece ff hay que escribir un byte igual a cero
               fwrite(fid_out,0,'uint8'); 
            end
         end
      
         % dejar en el buffer solo los que no se han escrito
         if n_bytes *8 < len_buf
            buf_bits = buf_bits(n_bytes*8+1:len_buf);
         else 
            buf_bits = [];
         end
         if verbose_level >= 4    
             display('resto que no se ha escrito porque no son multiplo de 8 bits')
             buf_bits
         end

      end     % for cmp=1:3
      if verbose_level >= 2 nb_h,cmp, end
   end  % for nb_h
          if verbose_level >= 1 nb_v, end
end       %for nb_v


% escribir los bits (menos de 8) que puedan quedar en el
len_buf=length(buf_bits);
if len_buf > 0
  for pp=len_buf+1:8    % relleno a 8
     buf_bits=strcat(buf_bits,'1');
     if verbose_level >= 4 
        display('ultimo byte de datos, con relleno de 1 al final si procede')
        buf_bits
     end
  end
  dd=bin2dec(buf_bits);
  fwrite(fid_out,dd,'uint8');
  if dd==255
     fwrite(fid_out,0,'uint8');
      if verbose_level >= 4 
        display('se escribe 0x00 porque el anterior es 0xff')
        buf_bits
      end 
  end
end

%%%%%%%%%%%%%%    ETIQUETA DE FIN DE IMAGEN
%fwrite(fid_out,255,'uint8');   % etiqueta de final de imagen 0xffd9
%fwrite(fid_out,217,'uint8');   
fwrite(fid_out,hex2dec('ff'),'uint8');   % etiqueta de final de imagen 0xffd9
fwrite(fid_out,hex2dec('d9'),'uint8');   
fclose(fid_out);






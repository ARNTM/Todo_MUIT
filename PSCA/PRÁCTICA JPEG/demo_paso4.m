close all
clear all

%demo_paso4
% imagen con los siguientes colores
%blanco, amarillo, cian, verde,magenta, rojo, azul y negro. 
imC = ones(8,64,3);

claro = 255*ones(8,1);    % vector columna de 255
oscuro = zeros(8,1);      % vector columna de ceros
clar8 = 255*ones(8,8);  % bloque de 8x8 blanco
oscu8 = zeros(8,8);    % bloque de 8x8 negro

%bloque de 8x8 con barras verticales de trazo con grosor 1 pixel
traz1 = [claro,oscuro,claro,oscuro,claro,oscuro,claro,oscuro];
%bloque de 8x8 con barras verticales de trazo con grosor 2 pixel
traz2 = [claro,claro,oscuro,oscuro,claro,claro,oscuro,oscuro];
%bloque de 8x8 con barras verticales de trazo con grosor 4 pixel
traz4 = [claro,claro,claro,claro,oscuro,oscuro,oscuro,oscuro];

%imagen con 4 bloques de frecuencia horizontal ascendente y 
% 4 bloques con frecuencia vertical ascendente. Diversos colores.
% canal R
imC(:,:,1)=[clar8, traz4, traz2, traz1, oscu8, oscu8,  oscu8,  traz1'];
% canal G
imC(:,:,2)=[oscu8, traz4, oscu8, traz1, clar8, oscu8,  traz2', traz1'];
% canal B
imC(:,:,3)=[clar8, oscu8, oscu8, traz1, oscu8, traz4', traz2', traz1'];
figure, imshow(imC/255);   %si la imagen esta en double hay que dividir por 255 para que 255 sea el blanco
title('imagen original');

mijpeg_paso4(imC,'out_paso4.jpg');

resultado = imread('out_paso4.jpg');
figure, imshow(resultado);       %la funcion imread devuelve datos tipo uint8 entre 0-255 y no es necesario utilizar mat2gray
title('imagen codificada y decodificada')


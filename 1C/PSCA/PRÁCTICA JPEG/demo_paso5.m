%demo_paso5
% imagen con los siguientes colores
%blanco, amarillo, cian, verde,magenta, rojo, azul y negro. 
imC = imread('lena_256_color.tif');

mijpeg_paso5(imC,'out_paso5_ca5.jpg',5);
resultado = imread('out_paso5_ca5.jpg');
figure, imshow(resultado);       %la funcion imread devuelve datos tipo uint8 entre 0-255 y no es necesario utilizar mat2gray
title('calidad 5')
% 
% mijpeg_paso5(imC,'out_paso5_ca4.jpg',4);
% resultado = imread('out_paso5_ca4.jpg');
% figure, imshow(resultado);       %la funcion imread devuelve datos tipo uint8 entre 0-255 y no es necesario utilizar mat2gray
% title('calidad 4')
% 
% mijpeg_paso5(imC,'out_paso5_ca3.jpg',3);
% resultado = imread('out_paso5_ca3.jpg');
% figure, imshow(resultado);       %la funcion imread devuelve datos tipo uint8 entre 0-255 y no es necesario utilizar mat2gray
% title('calidad 3')
% 
% mijpeg_paso5(imC,'out_paso5_ca2.jpg',2);
% resultado = imread('out_paso5_ca2.jpg');
% figure, imshow(resultado);       %la funcion imread devuelve datos tipo uint8 entre 0-255 y no es necesario utilizar mat2gray
% title('calidad 2')
% 
% mijpeg_paso5(imC,'out_paso5_ca1.jpg',1);
% resultado = imread('out_paso5_ca1.jpg');
% figure, imshow(resultado);       %la funcion imread devuelve datos tipo uint8 entre 0-255 y no es necesario utilizar mat2gray
% title('calidad 1')

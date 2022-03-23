%demo_paso3
% imagen con los siguientes colores
%blanco, amarillo, cian, verde,magenta, rojo, azul y negro. 
imC = ones(8,64,3);
claro = 255*ones(8,8);
oscuro = zeros(8,8);
% canal R
imC(:,:,1)=[claro,claro,oscuro,oscuro,claro,claro,oscuro,oscuro];
% canal G
imC(:,:,2)=[claro,claro,claro,claro,oscuro,oscuro,oscuro,oscuro];
% canal B
imC(:,:,3)=[claro,oscuro,claro,oscuro,claro,oscuro,claro,oscuro];
figure, imshow(imC/255);   %si la imagen esta en double hay que dividir por 255 para que 255 sea el blanco
title('imagen original');

mijpeg_paso3(imC,'out_paso3.jpg');

resultado = imread('out_paso3.jpg');
figure, imshow(resultado);       %la funcion imread devuelve datos tipo uint8 entre 0-255 y no es necesario utilizar mat2gray
title('imagen codificada y decodificada')

%descomentar para probar con la imagen wikio_256.tif

imL = imread('lena_256_color.tif');
figure, imshow(imL);   %si la imagen esta en double hay que dividir por 255 para que 255 sea el blanco
title('imagen original');

mijpeg_paso3(imL,'lena_256_color.jpg');

resultL = imread('lena_256_color.jpg');
figure, imshow(resultL);       %la funcion imread devuelve datos tipo uint8 entre 0-255 y no es necesario utilizar mat2gray
title('imagen codificada y decodificada')

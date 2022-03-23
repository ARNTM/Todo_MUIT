im1=[zeros(8,8), 255*ones(8,8), 128*ones(8,8)]; 
imC = ones(8,24,3);
imC(:,:,1)=im1;
imC(:,:,2)=im1;
imC(:,:,3)=im1;
figure, imshow(imC/255);   %si la imagen esta en double hay que dividir por 255 para que 255 sea el blanco
title('Imagen Original');

mijpeg_paso1(imC,'out_paso1.jpg');

resultado = imread('out_paso1.jpg');
figure, imshow(resultado);       %la funcion imread devuelve datos tipo uint8 entre 0-255 y no es necesario utilizar mat2gray
title('Imagen Codificada y Decodificada')


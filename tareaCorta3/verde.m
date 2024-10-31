clc; clear; close all
function E=conv2_borde(C,D,N)



% Definir el kernel de difusión
kernel = [0.073235 0.176765 0.073235;
          0.176765 0       0.176765;
          0.073235 0.176765 0.073235]; % Kernel de convolución usado para la difusión isotrópica


% Crear una copia de la imagen a restaurar
E = C;


for iter = 1:N
    for canal = 1:size(C, 3)
        % Convolucionar toda la imagen
        convolucion = conv2(E(:,:,canal), kernel, 'same');

        % Actualizar solo los píxeles afectados por la marca (I2 == 255)
        E(:,:,canal) = convolucion .* (D == 255) + C(:,:,canal) .* (D == 0);
    end
end

endfunction

function C=borde(A)


  B=((A(:, :, 1)<100) & (A(:, :, 2)>=125) & (A(:, :, 3)<100));
  M=ones(3);
  #C1=double(imerode(B,M));


  C1 = double(imdilate(B, M));
    % Crear el borde externo restando la imagen dilatada de la original
  borde_dilatado = C1 & ~B;


  C = im2uint8(borde_dilatado);



end


function C=fondo_verde(A,B)

  %Esta funcion asume que A es una imagen con fondo verde
  %B es una imagen de fondo en general.
  %C es el resultado de sustituir el fondo verde de A
  %con los pixeles de la imagen B
  %(Asumimos que A y B son de color y del mismo tamaño)

  [m,n,c]=size(A);
  C1=uint8(zeros(m,n,c)); %Imagen A con fondo negro en lugar de verde
  C2=uint8(zeros(m,n,c)); %Imagen B con negro en los pixeles de la imagen que no es verde de A

  mask1=((A(:, :, 1)<100) & (A(:, :, 2)>=125) & (A(:, :, 3)<100)); %Determinar verdes, usando una tolerancia
  mask2=-mask1+1;

  %Obtener persona de la imagen A, con fondo negro
  C1(:,:,1)=mask2.*A(:, :, 1);
  C1(:,:,2)=mask2.*A(:, :, 2);
  C1(:,:,3)=mask2.*A(:, :, 3);

  %Obtener fondo de la imagen B, pero negro en la posicion de la persona en A
  C2(:,:,1)=mask1.*B(:, :, 1);
  C2(:,:,2)=mask1.*B(:, :, 2);
  C2(:,:,3)=mask1.*B(:, :, 3);

  C=C1+C2;


endfunction




pkg load image
A=imread('imagenes/fondo_verde.jpg');
subplot(2,2,1)
imshow(A)
title('(a) Imagen Con Fondo Verde', 'FontSize', 16)
B=imread('imagenes/playa.jpg');
subplot(2,2,2)
imshow(B)
title('(b) Playa', 'FontSize', 16)

C=fondo_verde(A,B);


#subplot(2,2,[3 4])
figure;
class(C)
imshow(C)
title('(c) Efecto Croma', 'FontSize', 16)


D=borde(A);

figure
imshow(D)

%Tarea Moral!!!
E=conv2_borde(C,D,1000); %Aplicar convolución solo al borde de D, y actualizar en la imagen original. (Como en la Tarea 2)
figure;
imshow(E)

title('figura restaruada')

A=imread('imagenes/imagen1.jpg');
A=im2double(A);
subplot(1,2, 1);
imshow(A);
title('imagen original')

[a,b]=size(A);
B=zeros(a,b);

B(A>=0.5)=1;
B(A<0.5)=0;`1
subplot(1,2,2)
imshow(B)
title('segmentacion')


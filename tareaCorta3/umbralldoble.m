
clc;clear; close all;
pkg load image
function [T1, T2] = metodo_otsu_dos_umbrales(A)
    % Paso 0: Calcular el histograma
    [q, ~] = imhist(A);
    [m, n] = size(A);
    h = q / (m * n); % Histograma normalizado

    % Paso 1: Vector de sumas acumuladas (P)
    p = zeros(256, 1);
    for k = 0:255
        p(k + 1) = sum(h(1:k + 1));
    end

    % Paso 2: Vector de sumas acumuladas con peso (mv)
    mv = zeros(256, 1);
    aux = (0:255)' .* h;
    for k = 0:255
        mv(k + 1) = sum(aux(1:k + 1));
    end

    % Paso 3: Valor máximo de mv (mg)
    mg = mv(256);

    % Paso 4: Calcular la matriz de varianza (S)
    S = zeros(256, 256);
    for k1 = 1:256
        for k2 = k1+1:256
            P1 = p(k1);
            P2 = p(k2) - P1;
            P3 = 1 - p(k2);

            if P1 > 0 && P2 > 0 && P3 > 0
                m1 = mv(k1) / P1;
                m2 = (mv(k2) - mv(k1)) / P2;
                m3 = (mg - mv(k2)) / P3;

                S(k1, k2) = P1 * (m1 - mg)^2 + P2 * (m2 - mg)^2 + P3 * (m3 - mg)^2;
            end
        end
    end

    % Paso 5: Obtener los umbrales T1 y T2 que maximizan S(k1, k2)
    [~, idx] = max(S(:));
    [T1, T2] = ind2sub(size(S), idx);
    T1 = T1 - 1; % Ajuste a índice de umbral en el rango [0,255]
    T2 = T2 - 1;
end

A=imread('imagenes/imagen3.jpg');
[m,n]=size(A)
[T1, T2] = metodo_otsu_dos_umbrales(A)
C=zeros(m,n);
C(A>T2)=1;
C(and(T1<A,A<=T2))=0.5; %T1<A<=T2
C(A<=T1)=0;
subplot(1,3,3)
imshow(C)
title('Imagen Umbral Compuesto')



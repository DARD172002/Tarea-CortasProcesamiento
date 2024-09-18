clc;
clear;

% Definir la matriz de entrada (imagen) y el kernel (filtro)
A = [1 0 1; 4 3 1; -1 0 2];
B = [-1 1 2 3; -4 0 1 5];

function z = con_mat(A, B)
  [m1, n1] = size(A);
  [m2, n2] = size(B);

  % Inicializar la matriz de salida
  z = zeros(m1 + m2 - 1, n1 + n2 - 1);

  % Realizar la convolución 2D
  for i = 1:m1 + m2 - 1
    a1 = max(1, i - m2 + 1);
    b1 = min(i, m1);

    for j = 1:n1 + n2 - 1
      a2 = max(1, j - n2 + 1);
      b2 = min(j, n1);

      for k1 = a1:b1
        for k2 = a2:b2
          z(i, j) = z(i, j) + A(k1, k2) * B(i - k1 + 1, j - k2 + 1);
        end
      end
    end
  end
end

% Llamar a la función
z = con_mat(A, B)



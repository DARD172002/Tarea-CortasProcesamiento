function x = mat2vect_diag(A)

    % Inicializar el vector de salida
    x = [];

    % Recorrer las diagonales de la matriz en zig-zag
    for s = 1:(size(A, 1) + size(A, 2) - 1)
        if mod(s, 2) == 1  % Diagonales de abajo hacia arriba
            for j = 1:min(s, size(A, 2))
                i = s - j + 1;  %  índice de fila
                if i >= 1 && i <= size(A, 1) && j >= 1 && j <= size(A, 2)
                    if A(i, j) ~= 0  % Solo agregar si el elemento es diferente de cero
                        x(end + 1) = A(i, j);
                    end
                end
            end
        else  % Diagonales de arriba hacia abajo
            for i = 1:min(s, size(A, 1))
                j = s - i + 1;  %  índice de columna
                if i >= 1 && i <= size(A, 1) && j >= 1 && j <= size(A, 2)
                    if A(i, j) ~= 0  % Solo agregar si el elemento es diferente de cero
                        x(end + 1) = A(i, j);
                    end
                end
            end
        end
    end
end


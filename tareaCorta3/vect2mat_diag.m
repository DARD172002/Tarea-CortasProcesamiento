function C = vect2mat_diag(x)


    % Variable para mantener el índice del vector x
    idx = 1;

    % Recorrer las diagonales de la matriz
    for s = 1:(size(C, 1) + size(C, 2) - 1)
        if mod(s, 2) == 1  % Diagonales de abajo hacia arriba
            for j = 1:min(s, size(C, 2))
                i = s - j + 1;  % índice de fila
                if i >= 1 && i <= size(C, 1) && j >= 1 && j <= size(C, 2) && idx <= length(x)
                    C(i, j) = x(idx);
                    idx = idx + 1;
                end
            end
        else  % Diagonales de arriba hacia abajo
            for i = 1:min(s, size(C, 1))
                j = s - i + 1;  % índice de columna
                if i >= 1 && i <= size(C, 1) && j >= 1 && j <= size(C, 2) && idx <= length(x)
                    C(i, j) = x(idx);
                    idx = idx + 1;
                end
            end
        end
    end
end

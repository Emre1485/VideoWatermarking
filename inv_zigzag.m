function matrix = inv_zigzag(zigzag_order, rows, cols)
    matrix = zeros(rows, cols);
    index = 1;
    for sum = 2:(rows + cols)
        if mod(sum, 2) == 0
            r = max(1, sum - rows);
            c = min(sum - 1, cols);
            while r <= rows && c >= 1
                matrix(r, c) = zigzag_order(index);
                index = index + 1;
                r = r + 1;
                c = c - 1;
            end
        else
            r = min(sum - 1, rows);
            c = max(1, sum - cols);
            while r >= 1 && c <= cols
                matrix(r, c) = zigzag_order(index);
                index = index + 1;
                r = r - 1;
                c = c + 1;
            end
        end
    end
end

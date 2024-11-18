function zigzag_order = zigzag(matrix)
    [rows, cols] = size(matrix);
    zigzag_order = zeros(1, rows * cols);
    index = 1;
    for sum = 2:(rows + cols)
        if mod(sum, 2) == 0
            r = max(1, sum - rows);
            c = min(sum - 1, cols);
            while r <= rows && c >= 1
                zigzag_order(index) = matrix(r, c);
                index = index + 1;
                r = r + 1;
                c = c - 1;
            end
        else
            r = min(sum - 1, rows);
            c = max(1, sum - cols);
            while r >= 1 && c <= cols
                zigzag_order(index) = matrix(r, c);
                index = index + 1;
                r = r - 1;
                c = c + 1;
            end
        end
    end
end


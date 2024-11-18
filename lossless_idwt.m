function frame = lossless_idwt(LL, LH, HL, HH)
    low_pass_filter = [1, 1] / sqrt(2);
    high_pass_filter = [1, -1] / sqrt(2);

    % LL, LH, HL, HH birleştir
    rows = size(LL, 1) * 2;
    cols = size(LL, 2) * 2;
    temp = zeros(rows, cols);
    temp(1:rows/2, 1:cols/2) = LL;
    temp(1:rows/2, cols/2+1:cols) = LH;
    temp(rows/2+1:rows, 1:cols/2) = HL;
    temp(rows/2+1:rows, cols/2+1:cols) = HH;

    % Sütun bazında ters DWT
    for j = 1:cols
        col_low = temp(1:rows/2, j);
        col_high = temp(rows/2+1:rows, j);
        col = zeros(rows, 1);
        col(1:2:end) = conv(col_low, low_pass_filter, 'same');
        col(2:2:end) = conv(col_high, high_pass_filter, 'same');
        temp(:, j) = col;
    end

    % Satır bazında ters DWT
    frame = zeros(rows, cols);
    for i = 1:rows
        row_low = temp(i, 1:cols/2);
        row_high = temp(i, cols/2+1:cols);
        row = zeros(1, cols);
        row(1:2:end) = conv(row_low, low_pass_filter, 'same');
        row(2:2:end) = conv(row_high, high_pass_filter, 'same');
        frame(i, :) = row;
    end
end

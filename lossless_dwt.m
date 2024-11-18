function [LL, LH, HL, HH] = lossless_dwt(frame)
    low_pass_filter = [1, 1] / sqrt(2);  % Alçak geçiş filtresi
    high_pass_filter = [1, -1] / sqrt(2); % Yüksek geçiş filtresi

    % Satır bazında DWT
    [rows, cols] = size(frame);
    temp = zeros(rows, cols);
    for i = 1:rows
        row = frame(i, :);
        low_freq_row = conv(row, low_pass_filter, 'same');
        high_freq_row = conv(row, high_pass_filter, 'same');
        temp(i, 1:cols/2) = low_freq_row(1:2:end);
        temp(i, cols/2+1:cols) = high_freq_row(1:2:end);
    end

    % Sütun bazında DWT
    LL = zeros(rows/2, cols/2);
    LH = zeros(rows/2, cols/2);
    HL = zeros(rows/2, cols/2);
    HH = zeros(rows/2, cols/2);
    for j = 1:cols
        col = temp(:, j);
        low_freq_col = conv(col, low_pass_filter, 'same');
        high_freq_col = conv(col, high_pass_filter, 'same');
        temp(1:rows/2, j) = low_freq_col(1:2:end);
        temp(rows/2+1:rows, j) = high_freq_col(1:2:end);
    end

    LL = temp(1:rows/2, 1:cols/2);
    LH = temp(1:rows/2, cols/2+1:cols);
    HL = temp(rows/2+1:rows, 1:cols/2);
    HH = temp(rows/2+1:rows, cols/2+1:cols);
end


function watermarkedFrame = embed_watermark(frame, watermarkBinary, key)
    alpha = 0.05; % Filigranın şiddeti
    [LL, LH, HL, HH] = lossless_dwt(double(frame));
    zigzag_LL = zigzag(LL);
    
    % Key ile rastgele yer seçimi
    rng(key);
    selected_indices = randperm(length(zigzag_LL), length(watermarkBinary));
    
    % Filigranı gömme
    for k = 1:length(watermarkBinary)
        zigzag_LL(selected_indices(k)) = zigzag_LL(selected_indices(k)) + alpha * watermarkBinary(k);
    end
    
    % LL bandını yeniden oluştur
    LL = inv_zigzag(zigzag_LL, size(LL, 1), size(LL, 2));
    
    % Ters DWT ile kareyi geri oluştur
    watermarkedFrame = lossless_idwt(LL, LH, HL, HH);
end

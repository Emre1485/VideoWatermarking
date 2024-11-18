% Ana script: video_watermarking.m

% Videoyu yükle
video = VideoReader('proje1video.mp4');

% Kare sayısını al
numFrames = video.NumFrames;

% Ses verisini ayır (isteğe bağlı)
audioData = audioread('proje1video.mp4');

% Filigran verisini kullanıcıdan al
watermarkText = input('Damgalanacak metni girin: ', 's');
watermarkBinary = reshape(dec2bin(watermarkText, 8).' - '0', 1, []);

% Anahtar oluştur
key = 12345; % Rastgele bir key belirle
rng(key); % Key'i rastgele sayı üreticiye bağla

% Kareleri işle ve damgala
for i = 1:numFrames
    % Videodan kareyi oku
    frame = read(video, i);
    grayFrame = rgb2gray(frame); % Gri tonlamaya çevir
    
    % Kare üzerinde damgalama işlemi
    watermarkedFrame = embed_watermark(grayFrame, watermarkBinary, key);
    if ~exist('frames', 'dir')
        mkdir('frames'); % frames klasörünü oluştur
    end

    % Damgalı kareyi kaydet
    imwrite(uint8(watermarkedFrame), sprintf('frames/frame_%d.jpg', i));
end

disp('Video kareleri damgalandı!');

function [STFT, f, t] = mystft(x, win, hop, nfft, fs)
    x = x(:);
    xlen = length(x);
    wlen = length(win);

    % ������Ŀ L
    L = 1+fix((xlen-wlen)/hop);
    STFT = zeros(nfft, L);
    
    % STFT
    for l = 0:L-1
        % �Ӵ�
        xw = x(1+l*hop : wlen+l*hop).*win;
        
        % FFT����
        X = fft(xw, nfft);
        X = fftshift(X);

        STFT(:, 1+l) = X(1:nfft);
    end
    
    % ȡÿ�������е��ʱ���
    t = (wlen/2:hop:wlen/2+(L-1)*hop)/fs;
    %f = (0:nfft-1)*fs/nfft;
    % Ƶ�� (fftshift֮���)
    f = (-nfft/2:nfft/2-1) * (fs/nfft);
    
end

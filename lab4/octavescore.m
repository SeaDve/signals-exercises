function score = octavescore(x, h, fs)
    % Filter signal
    y = conv(x, h, 'same');
    
    % Frame-based RMS energy
    frame_len = round(0.05 * fs);  % 50 ms frames
    hop = round(0.025 * fs);       % 25 ms hop
    N = floor((length(y) - frame_len) / hop) + 1;
    
    score = zeros(1, N);
    for i = 1:N
        idx = (1:frame_len) + (i-1)*hop;
        frame = y(idx);
        score(i) = sqrt(mean(frame.^2));
    end
end
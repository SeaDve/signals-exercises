% Parameters
fs = 8000;
L_vec = [320, 206, 103, 52, 26];  % Filter lengths for octaves 2–6
fc_vec = [115.11, 252.12, 504.25, 1008.49, 2016.97];  % Center frequencies (Hz)
wc_vec = 2*pi*fc_vec/fs;  % Center digital frequencies (rad/sample)

hh = cell(1, 5);  % Store filters here

% Design and plot filters
figure;
hold on;
for i = 1:5
    L = L_vec(i);
    wc = wc_vec(i);
    n = 0:L-1;
    
    % Hamming-windowed cosine bandpass impulse response
    h = (0.54 - 0.46*cos(2*pi*n/(L-1))) .* cos(wc*(n - (L-1)/2));
    
    % Normalize gain to 1 at center frequency
    H = freqz(h, 1, 1024);
    beta = 1 / max(abs(H));
    h = beta * h;
    hh{i} = h;  % Store in filter bank
    
    % Plot magnitude response
    H = freqz(h, 1, 1024);
    plot(linspace(0, pi, 1024), abs(H));
    xline(wc, '--k');
end
xlabel('Digital Frequency (rad/sample)');
ylabel('Magnitude');
title('Bandpass Filter Bank Magnitude Responses');
legend('Octave 2','Octave 3','Octave 4','Octave 5','Octave 6');
grid on;

% Create test input signal with tones in different intervals
t = 0:1/fs:0.85;
xx = zeros(size(t));
xx(t < 0.25) = cos(2*pi*220*t(t < 0.25));
xx(t >= 0.3 & t < 0.55) = cos(2*pi*880*t(t >= 0.3 & t < 0.55));
xx(t >= 0.6 & t < 0.85) = cos(2*pi*440*t(t >= 0.6 & t < 0.85)) + ...
                         cos(2*pi*1760*t(t >= 0.6 & t < 0.85));

% Apply filters
yy = cell(1, 5);
for i = 1:5
    yy{i} = conv(xx, hh{i}, 'same');  % Delay-compensated convolution
end

% Plot filtered outputs
figure;
for i = 1:5
    subplot(5,1,i);
    plot(t, yy{i});
    title(['BPF Output for Octave ' num2str(i+1)]);
    ylabel('Amplitude');
end
xlabel('Time (s)');

% Scoring and detection
threshold = 0.5;
testscore = octavescore(xx, hh{1}, fs);  % Run once to get the length
scores = zeros(5, length(testscore));   % Initialize properly

for i = 1:5
    scores(i, :) = octavescore(xx, hh{i}, fs);
end
for i = 1:5
    scores(i, :) = octavescore(xx, hh{i}, fs);
end
detections = scores > threshold;  % binary matrix

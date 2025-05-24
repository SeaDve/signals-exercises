% (a) Pre-emphasis filter H(z) = 1 - z^{-1}

b = [1 -1]; % numerator coefficients
a = 1;      % denominator coefficients

[H, w] = freqz(b, a, 1024);

figure;
plot(w/pi, abs(H));
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude');
title('Magnitude Response of Pre-emphasis Filter');
grid on;

% - This is an FIR (Finite Impulse Response) filter because it only has a numerator (no feedback).
% - It acts as a **High-Pass Filter (HPF)**, boosting higher frequencies while attenuating lower ones.

% (b) Apply filter to a speech signal

% Read input audio (e.g., 'catsdogs.wav')
[x, Fs] = audioread('harvard.wav');

if size(x, 2) == 2
    x = mean(x, 2);
end

% Apply the pre-emphasis filter
y = filter(b, a, x);

% Plot spectrograms
figure;
subplot(2,1,1);
spectrogram(x, 256, 200, 512, Fs, 'yaxis');
title('Spectrogram of Original Signal');
colorbar;

subplot(2,1,2);
spectrogram(y, 256, 200, 512, Fs, 'yaxis');
title('Spectrogram of Pre-emphasized Signal');
colorbar;

% Description:
% Two features you should observe:
% 1. The pre-emphasized signal has brighter (stronger) high-frequency components.
% 2. The low-frequency content appears slightly suppressed compared to the original.

% (c) Listen to the audio
disp('Playing original audio...');
sound(x, Fs);
pause(length(x)/Fs + 1);

disp('Playing pre-emphasized audio...');
sound(y, Fs);

% Description:
% - After pre-emphasis, the speech sounds sharper and more "crispy."
% - High-frequency consonants like "s," "t," and "k" sounds are more pronounced.
% - Without pre-emphasis, the speech sounds a bit more muffled and "dull."
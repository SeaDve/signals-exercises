M = 100;
wc1 = 1.5; % in radians/sample
wc2 = 2.0;

bk = designBPF(M, wc1, wc2);

% Frequency response
[H, w] = freqz(bk, 1, 1024);

figure;
plot(w, abs(H));
title('(a) BPF Magnitude vs. digital frequency, omega-hat');
xlabel('\omegâ (radians/sample)');
ylabel('|H(e^{j\omegâ})|');
grid on;

fs = 8000; % Sampling rate in Hz
f = w * fs / (2*pi); % Convert digital frequency to Hz

figure;
plot(f, abs(H));
title('(b) BPF Magnitude vs. analog frequency in Hz');
xlabel('Frequency (Hz)');
ylabel('|H(f)|');
grid on;
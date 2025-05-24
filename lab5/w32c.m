% Parameters
fs = 8000;              % Sampling frequency
T = 1.3;                % Duration
t = 0:1/fs:T-1/fs;      % Time vector
f1 = 215;               % Low frequency (envelope)
f2 = 1064;              % High frequency (carrier)
beta = 1.2;

% Generate AM signal
b1_t = beta + cos(2*pi*f1*t);      % Envelope
b2_t = cos(2*pi*f2*t);             % Carrier
bt = b1_t .* b2_t;                 % AM signal

% Plot signal
figure;
plot(t, bt);
xlabel('Time (s)');
ylabel('b(t)');
title('Amplitude Modulated Signal b(t)');
xlim([0 0.05]);  % Zoom in

abs_bt = abs(bt);  % Full-wave rectified signal

% Plot magnitude signal
figure;
plot(t, abs_bt);
xlabel('Time (s)');
ylabel('|b(t)|');
title('Full-Wave Rectified Signal');
xlim([0 0.05]);  % Zoom in

window = 1024;
nfft = 1024;
overlap = 512;

figure;
subplot(3,1,1);
spectrogram(bt, window, overlap, nfft, fs, 'yaxis');
title('Spectrogram of b(t)'); % has energy near ±f2 Hz.

subplot(3,1,2);
spectrogram(b1_t, window, overlap, nfft, fs, 'yaxis');
title('Spectrogram of Envelope b_1(t)'); % shows energy near 0 Hz (lowpass).

subplot(3,1,3);
spectrogram(abs_bt, window, overlap, nfft, fs, 'yaxis');
title('Spectrogram of |b(t)|'); % has both low-frequency (envelope) and higher components (double the carrier).

% Filter the magnitude signal
env_est = filter(b, a, abs_bt);

% Plot result
figure;
plot(t, env_est, 'r'); hold on;
plot(t, b1_t, 'k--');  % Original envelope for comparison
xlabel('Time (s)');
ylabel('Amplitude');
legend('Filtered Envelope', 'Original Envelope');
title('Envelope Extraction Comparison');
xlim([0 0.05]);  % Zoom in

% Optional: Observe transient at beginning
figure;
plot(t, env_est);
title('Filtered Envelope with Transients');
xlabel('Time (s)');
ylabel('Amplitude');
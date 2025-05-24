% Load input signal
[input_signal, fs] = audioread('furElise22k.wav');

% Example pre-emphasis filter
preemp_filter = [1 -0.95];  % y[n] = x[n] - 0.95*x[n-1]
preemphasized = filter(preemp_filter, 1, input_signal);

% Filter bank parameters
L = 255;    % FIR filter length
n = -(L-1)/2:(L-1)/2;
num_channels = 8;

% Define filter cutoff frequencies (example, spread between 300–3400 Hz)
f_cutoffs = linspace(300, 3400, num_channels + 1);

filtered_signals = cell(num_channels,1);
h = cell(num_channels,1);

for i = 1:num_channels
    f_low = f_cutoffs(i);
    f_high = f_cutoffs(i+1);

    % Bandpass filter design using windowed sinc
    h_bp = (2*f_high/fs)*sinc(2*f_high*n/fs) - (2*f_low/fs)*sinc(2*f_low*n/fs);
    h_bp = h_bp .* hamming(L)';
    h{i} = h_bp;

    % Filter the preemphasized signal
    filtered_signals{i} = filter(h{i}, 1, preemphasized);
end

% Envelope detection
envelopes = cell(num_channels,1);
for i = 1:num_channels
    rectified = abs(filtered_signals{i});

    % Simple LPF (moving average or low cutoff LPF)
    lpf_len = 101;
    lpf = hamming(lpf_len)' / sum(hamming(lpf_len));  % Normalize

    smoothed = filter(lpf, 1, rectified);

    % DC reject filter (notch at 0 Hz)
    a = 0.995;
    b = 0.5 * (1 + a);
    dc_rejected = filter([b -b], [1 -a], smoothed);

    envelopes{i} = dc_rejected;
end

% Modulation
modulated = cell(num_channels,1);
t = (0:length(input_signal)-1)/fs;

% Define center frequencies and optional phase offsets
center_frequencies = (f_cutoffs(1:end-1) + f_cutoffs(2:end)) / 2;
phase_offset = zeros(1, num_channels); % or random if desired

for i = 1:num_channels
    fc = center_frequencies(i);
    carrier = cos(2*pi*fc*t + phase_offset(i));
    modulated{i} = envelopes{i} .* carrier(:); % ensure column
end

% Sum all channels
output_signal = zeros(size(input_signal));
for i = 1:num_channels
    output_signal = output_signal + modulated{i};
end

% Plot spectrograms
subplot(2,1,1);
spectrogram(preemphasized, 256, 200, 512, fs, 'yaxis');
title('Input Signal');

subplot(2,1,2);
spectrogram(output_signal, 256, 200, 512, fs, 'yaxis');
title('Output Signal');

t = (0:length(input_signal)-1)/fs;

figure;
subplot(2,1,1);
plot(t, input_signal);
title('Original Signal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(2,1,2);
plot(t, output_signal);
title('Vocoded Signal');
xlabel('Time (s)');
ylabel('Amplitude');

disp('Playing original signal...');
soundsc(input_signal, fs);
pause(length(input_signal)/fs + 1);  % Wait until playback ends

disp('Playing vocoded signal...');
soundsc(output_signal, fs);
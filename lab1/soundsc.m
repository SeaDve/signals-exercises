fs = 11025;   % Sampling rate in samples per second
dur = 0.9;    % Duration in seconds
tt = 0:(1/fs):dur;  % Time vector
freq = 2000;  % Frequency of the sinusoid

% Generate the sinusoidal signal
xx = sin(2 * pi * freq * tt);

length(tt)

% Play the sound
soundsc(xx, fs);
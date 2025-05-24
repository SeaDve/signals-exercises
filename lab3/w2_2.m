% Parameters
M = 9;
alpha = 0.8;

% Impulse responses
h1 = alpha.^(0:M);       % FIR Filter #1
h2 = [1, -alpha];         % FIR Filter #2

% Frequency responses
[H1, w] = freqz(h1, 1, 1024);  % Filter #1
[H2, ~] = freqz(h2, 1, 1024);  % Filter #2

% Cascaded response
H_total = H1 .* H2;
mag_total = abs(H_total);
phase_total = angle(H_total);

% === Plot Magnitude Responses ===
figure;
subplot(3,1,1);
plot(w/pi, abs(H1), 'b');
title('Magnitude Response of Filter #1 (Lowpass)');
xlabel('\omega/\pi'); ylabel('|H_1(e^{j\omega})|');
grid on;

subplot(3,1,2);
plot(w/pi, abs(H2), 'r');
title('Magnitude Response of Filter #2 (Highpass)');
xlabel('\omega/\pi'); ylabel('|H_2(e^{j\omega})|');
grid on;

subplot(3,1,3);
plot(w/pi, mag_total, 'k');
title('Magnitude Response of Cascaded System');
xlabel('\omega/\pi'); ylabel('|H_{total}(e^{j\omega})|');
grid on;

% === Plot Phase Responses ===
figure;
subplot(3,1,1);
plot(w/pi, angle(H1), 'b');
title('Phase Response of Filter #1');
xlabel('\omega/\pi'); ylabel('\angle H_1(e^{j\omega})');
grid on;

subplot(3,1,2);
plot(w/pi, angle(H2), 'r');
title('Phase Response of Filter #2');
xlabel('\omega/\pi'); ylabel('\angle H_2(e^{j\omega})');
grid on;

subplot(3,1,3);
plot(w/pi, phase_total, 'k');
title('Phase Response of Cascaded System');
xlabel('\omega/\pi'); ylabel('\angle H_{total}(e^{j\omega})');
grid on;
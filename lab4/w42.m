%% Section 4.2 - A Better BPF
% Hamming-windowed bandpass filter centered at ω̂ = 0.25π

% --- Part (a) ---
L = 41;
wc = 0.25 * pi;
n = 0:L-1;

% Hamming window
w = 0.54 - 0.46 * cos(2*pi*n/(L-1));

% Centered cosine
h = w .* cos(wc*(n - (L-1)/2));

% Frequency response
[H, w_axis] = freqz(h, 1, 1024);
magnitude = abs(H);
phase = angle(H);

% Plot response
figure;
subplot(2,1,1);
plot(w_axis/pi, magnitude, 'b', 'LineWidth', 1.5);
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('|H(e^{j\omega})|');
title('Magnitude Response of Hamming BPF (L = 41)');
grid on;

subplot(2,1,2);
plot(w_axis/pi, phase, 'r', 'LineWidth', 1.5);
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('\angle H(e^{j\omega})');
title('Phase Response');
grid on;

% Evaluate response at ω̂ = {0, 0.1π, 0.25π, 0.4π, 0.5π, 0.75π}
w_eval = [0, 0.1, 0.25, 0.4, 0.5, 0.75] * pi;
H_eval = freqz(h, 1, w_eval);
mag_eval = abs(H_eval);
phase_eval = angle(H_eval);

% Display table
disp(' ');
disp('--- Frequency Response at Specific ω̂ ---');
disp(' ω̂ (×π)   |   Magnitude   |   Phase (radians)');
disp('---------------------------------------------');
for i = 1:length(w_eval)
    fprintf('  %.2f     |    %.4f     |    %.4f\n', w_eval(i)/pi, mag_eval(i), phase_eval(i));
end

% Answer Summary:
% At ω̂ = 0.25π → Magnitude ≈ 1 (as expected, passband)
% At ω̂ = 0 or 0.75π → Magnitude ≈ very small (stopband)


% Define function to compute passband width
compute_passband_width = @(h) ...
    diff(freqz_passband_range(h));

function pb_range = freqz_passband_range(h)
    [H_full, w_axis] = freqz(h, 1, 1024);
    mag_full = abs(H_full);
    indices = find(mag_full >= 0.5);
    pb_range = [w_axis(indices(1)), w_axis(indices(end))];
end

% Case 1: L = 21
L1 = 21;
n1 = 0:L1-1;
w1 = 0.54 - 0.46*cos(2*pi*n1/(L1-1));
h1 = w1 .* cos(wc*(n1 - (L1-1)/2));
pbw1 = compute_passband_width(h1);

% Case 2: L = 81
L2 = 81;
n2 = 0:L2-1;
w2 = 0.54 - 0.46*cos(2*pi*n2/(L2-1));
h2 = w2 .* cos(wc*(n2 - (L2-1)/2));
pbw2 = compute_passband_width(h2);

fprintf('\n--- Passband Widths ---\n');
fprintf('L = 21 → Passband width ≈ %.4fπ radians\n', pbw1/pi);
fprintf('L = 41 → Passband width ≈ %.4fπ radians\n', compute_passband_width(h)/pi);
fprintf('L = 81 → Passband width ≈ %.4fπ radians\n', pbw2/pi);

% Answer Insight:
% Doubling L from 21 to 41 roughly halves the passband width
% Further doubling to 81 continues to narrow it — consistent with inverse relation to L


% Part (c)
% Input: x[n] = 2 + 2cos(0.1πn + π/3) + cos(0.25πn − π/3)
% Frequencies: 0, 0.1π, 0.25π

% From part (a), response magnitudes (approx. from earlier output):
% H(0) ≈ near 0 (stopband)
% H(0.1π) ≈ ~0.2–0.3 (stopband edge)
% H(0.25π) ≈ ~1.0 (center of passband)

% Output:
% - DC component (2) is mostly blocked
% - 2cos(0.1πn + π/3): attenuated significantly
% - cos(0.25πn − π/3): passed with almost full amplitude

% Therefore:
% y[n] ≈ cos(0.25πn − π/3) + small attenuated version of cos(0.1πn + π/3)


% Part (d)
% The filter has a passband centered at 0.25π
% Frequencies at ±0.25π are passed (magnitude ≈ 1)
% Frequencies outside (~0.1π, 0.75π, etc.) are significantly attenuated

% So: Components at ±0.25π → pass through
% Other components → rejected or heavily attenuated

% This demonstrates the filter effectively isolates specific frequency components.
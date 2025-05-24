% Define omega from -pi to pi with 400 points
omega = linspace(-pi, pi, 400);

% Compute magnitude and phase using the derived expression
H = (2*cos(0.5*omega) + 2*cos(1.5*omega)) ./ 4 .* exp(-1j*1.5*omega);

% Plot magnitude and phase
figure;
subplot(2,1,1);
plot(omega, abs(H));
title('Magnitude of H(e^{j\omega}) - Direct Formula');
xlabel('\omega'); ylabel('|H(e^{j\omega})|');

subplot(2,1,2);
plot(omega, angle(H));
title('Phase of H(e^{j\omega}) - Direct Formula');
xlabel('\omega'); ylabel('∠H(e^{j\omega})');



% Define filter coefficients
bb = 1/4 * ones(1, 4);   % 4-point average

% Compute H(e^{j\omega}) numerically using freqz
[Hf, ww] = freqz(bb, 1, omega);

% Plot magnitude and phase
figure;
subplot(2,1,1);
plot(ww, abs(Hf));
title('Magnitude of H(e^{j\omega}) - freqz()');
xlabel('\omega'); ylabel('|H(e^{j\omega})|');

subplot(2,1,2);
plot(ww, angle(Hf));
title('Phase of H(e^{j\omega}) - freqz()');
xlabel('\omega'); ylabel('∠H(e^{j\omega})');
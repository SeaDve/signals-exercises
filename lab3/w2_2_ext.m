hh = [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.8^10];

[HH, w] = freqz(hh, 1, 1024);

figure;
subplot(2,1,1);
plot(w/pi, abs(HH), 'b');
title('Magnitude Response of H');
xlabel('\omega/\pi'); ylabel('|H_1(e^{j\omega})|');
grid on;

subplot(2,1,2);
plot(w/pi, angle(HH), 'r');
title('Phase Response of H');
xlabel('\omega/\pi'); ylabel('|H_2(e^{j\omega})|');
grid on;
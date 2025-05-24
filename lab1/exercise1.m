f = 4000;
T = 1/f;
fs = f * 25;
tt = -T : 1/fs : T;

A1 = 20;
A2 = 1.2 * A1;
D = 8;
M = 7;
tm1 = (37.2/M) * T;
tm2 = (-41.3/D) * T;

x1 = A1 * cos(2 * pi * f * (tt - tm1));
x2 = A2 * cos(2 * pi * f * (tt - tm2));
x3 = x1 + x2;

phi1 = -2 * pi * f * tm1;
phi2 = -2 * pi * f * tm2;

figure;
subplot(4,1,1);
plot(tt, x1);
title('x1(t) - Dave Patrick');
xlabel('Time (s)'); ylabel('Amplitude');
grid on;
text(0, A1, sprintf('A1 = %.2f, \phi1 = %.2f rad\ntm1 = %.6f s', A1, phi1, tm1), 'FontSize', 10, 'Color', 'r');

subplot(4,1,2);
plot(tt, x2);
title('x2(t)');
xlabel('Time (s)'); ylabel('Amplitude');
grid on;
text(0, A2, sprintf('A2 = %.2f, \phi2 = %.2f rad\ntm2 = %.6f s', A2, phi2, tm2), 'FontSize', 10, 'Color', 'b');

X1 = A1 * exp(1j * phi1);
X2 = A2 * exp(1j * phi2);
X3 = X1 + X2;

A3 = abs(X3);
phi3 = angle(X3);
tm3 = -phi3 / (2 * pi * f);

subplot(4,1,3);
plot(tt, x3);
title('x3(t)');
xlabel('Time (s)'); ylabel('Amplitude');
grid on;
text(0, A3, sprintf('A3 = %.2f, \phi3 = %.2f rad\ntm3 = %.6f s', A3, phi3, tm3), 'FontSize', 10, 'Color', 'g');

x1b = real(A1 * exp(1j * 2 * pi * f * (tt - tm1)));

subplot(4,1,4);
plot(tt, x1b);
title('x1(t) - Complex Amplitude');
xlabel('Time (s)'); ylabel('Amplitude');
grid on;

fprintf('Amplitude of x3: %.2f\n', A3);
fprintf('Phase of x1: %.2f radians\n', phi1);
fprintf('Phase of x2: %.2f radians\n', phi2);
fprintf('Phase of x3: %.2f radians\n', phi3);

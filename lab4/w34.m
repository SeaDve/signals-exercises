L = 25;                    
n = 0:L-1;                 
omega_c = 0.2 * pi;        
h = (2/L) * cos(omega_c * n);

n = 0:599;
xx = zeros(size(n));

xx(n < 200) = cos(0.5 * pi * n(n < 200));
xx(n >= 200 & n < 400) = 2;
xx(n >= 400) = 0.5 * cos(0.2 * pi * n(n >= 400));

yy = conv(xx, h, 'same');

figure;
subplot(3,1,1);
stem(n, xx, 'filled');
title('Input Signal x[n]');
xlabel('n');
ylabel('x[n]');
grid on;

subplot(3,1,3);
stem(n, yy, 'filled');
title('Filtered Signal y[n]');
xlabel('n');
ylabel('y[n]');
grid on;

[H, w] = freqz(h, 1, 1024);
subplot(3,1,2);
plot(w/pi, abs(H));
title('Magnitude Response of Bandpass Filter');
xlabel('\omega/\pi');
ylabel('|H(\omega)|');
grid on;
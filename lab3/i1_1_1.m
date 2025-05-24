bb = [0.5, 0,5];
ww = -pi:(pi/100):pi;
HH = freqz(bb, 1, ww);
subplot(2, 1, 1);
plot(ww, abs(HH));
subplot(2, 1, 2);
plot(ww, angle(HH));
xlabel('Normalized Radian Frequency');

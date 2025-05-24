L = 25;                    
n = 0:L-1;                 
omega_c = 0.2 * pi;        
h = (2/L) * cos(omega_c * n);

stem(n, h);
xlabel('n');
ylabel('h[n]');
title('Impulse Response of Length-25 BPF (\omega_c = 0.2\pi)');
grid on;

[H, omega] = freqz(h, 1, 1024, 'whole'); 

figure;
subplot(2,1,1);
plot(omega - pi, abs(fftshift(H)));
xlabel('\omega (rad/sample)');
ylabel('|H(\omega)|');
title('Magnitude Response');
grid on;

subplot(2,1,2);
plot(omega - pi, angle(fftshift(H)));
xlabel('\omega (rad/sample)');
ylabel('Phase');
title('Phase Response');
grid on;

magH = abs(H);
magH = fftshift(magH);
omega_shifted = omega - pi;

peak = max(magH)
half_power = peak / 2;

peak * 0.5

indices = find(magH >= half_power);
bw_estimate = omega_shifted(indices(end)) - omega_shifted(indices(1));
bw_estimate_normalized = bw_estimate / pi; 

fprintf('Estimated bandwidth at 50%% magnitude: %.3fπ radians/sample\n', bw_estimate/pi);

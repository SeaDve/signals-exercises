% Time index
n = 0:149;

% Generate input signal
x = 5*cos(0.3*pi*n) + ...
    22*cos(0.44*pi*n - pi/3) + ...
    22*cos(0.7*pi*n - pi/4);

% Design two nulling filters
omega1 = 0.44 * pi;
omega2 = 0.7 * pi;

h1 = [1, -2*cos(omega1), 1];
h2 = [1, -2*cos(omega2), 1];

% Cascade filters
h_cascade = conv(h1, h2);

% Filter the input signal
y = conv(x, h_cascade, 'same');  % same length as input

% ==== Compute filter gain at ω = 0.3π ====
[H, W] = freqz(h_cascade, 1, 1024);  % Frequency response
omega_target = 0.3 * pi;
[~, idx] = min(abs(W - omega_target));  % Closest index
gain_at_03pi = abs(H(idx))              % Print the gain

% Normalize the output to match expected amplitude
y_normalized = y / gain_at_03pi;

% Ideal output (only surviving component)
n_plot = 5:40;
y_ideal = 5 * cos(0.3*pi*n_plot);

figure;
stem(0:39, y(1:40), 'filled');
xlabel('n');
ylabel('y[n]');
title('Filtered Output Signal (First 40 Samples)');
grid on;

% Plot comparison
figure;
stem(n_plot, y_normalized(n_plot+1), 'filled'); hold on;
plot(n_plot, y_ideal, 'r--', 'LineWidth', 1.5);
legend('Normalized Filter Output', 'Ideal Formula');
xlabel('n');
ylabel('y[n]');
title('Normalized Filter Output vs Ideal Response');
grid on;

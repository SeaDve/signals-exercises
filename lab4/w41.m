% Parameters
L_values = [20, 40, 80];        % Filter lengths to try
wc = 0.4 * pi;                  % Center frequency in radians

for i = 1:length(L_values)
    L = L_values(i);
    n = 0:L-1;

    % Impulse response of the bandpass filter
    h = (2/L) * cos(wc * n);

    % Frequency response
    [H, w] = freqz(h, 1, 1024);

    % Magnitude and phase
    magnitude = abs(H);
    phase = angle(H);

    % Plotting
    figure;
    subplot(2,1,1);
    plot(w/pi, magnitude, 'b', 'LineWidth', 1.5);
    title(['Magnitude Response (L = ' num2str(L) ')']);
    xlabel('Normalized Frequency (\times\pi rad/sample)');
    ylabel('|H(e^{j\omega})|');
    grid on;

    subplot(2,1,2);
    plot(w/pi, phase, 'r', 'LineWidth', 1.5);
    title('Phase Response');
    xlabel('Normalized Frequency (\times\pi rad/sample)');
    ylabel('\angle H(e^{j\omega})');
    grid on;

    % Passband width calculation (using threshold 0.5)
    passband_indices = find(magnitude >= 0.5);
    passband_width = w(passband_indices(end)) - w(passband_indices(1));
    disp(['Passband width for L = ' num2str(L) ': ' num2str(passband_width/pi) ' * pi radians']);
end

% The passband width of the bandpass filter is inversely proportional to the filter length L.
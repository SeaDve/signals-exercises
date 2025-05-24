xx = 1.4:0.33:5, jkl = find(round(xx)==3), xx(jkl)

ww = -pi:(pi/500):pi; HH = freqz( 1/4*ones(1,4), 1, ww );

threshold = 1e-6;                      % Small tolerance
zero_indices = find(abs(HH) < threshold);  % Indices where magnitude of HH is close to 0
zero_freqs = ww(zero_indices); 
disp('Frequencies where |H(e^{j\omega})| ≈ 0:');
disp(zero_freqs');
function bk = designBPF(M, wc1, wc2)
    % DESIGNBPF Design an FIR bandpass filter using Hamming window
    % Inputs:
    %   M    = filter order
    %   wc1  = lower cutoff (in radians/sample)
    %   wc2  = upper cutoff (optional; in radians/sample)

    n = 0:M;
    alpha = M/2;

    if nargin == 2
        % Only wc1 is given -> design LPF with cutoff wc1
        hd = sin(wc1*(n - alpha)) ./ (pi*(n - alpha));
    else
        % Bandpass: subtract two LPFs
        hd1 = sin(wc2*(n - alpha)) ./ (pi*(n - alpha));
        hd2 = sin(wc1*(n - alpha)) ./ (pi*(n - alpha));
        hd = hd1 - hd2;
    end

    % Fix the singularity at n = alpha
    hd(n == alpha) = (nargin == 2)*wc1/pi + (nargin == 3)*(wc2 - wc1)/pi;

    % Apply Hamming window
    w = hamming(M+1)';
    bk = hd .* w;
end

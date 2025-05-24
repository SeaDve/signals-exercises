function [xx, tt] = beat(A, B, fc, delf, fsamp, dur)
%BEAT Compute samples of the sum of two cosine waves
% usage:
% [xx, tt] = beat(A, B, fc, delf, fsamp, dur)
%
% A = amplitude of lower frequency cosine
% B = amplitude of higher frequency cosine
% fc = center frequency
% delf = frequency difference
% fsamp = sampling rate
% dur = total time duration in seconds
% xx = output vector of samples
% tt = time vector corresponding to xx

% Generate the time vector
tt = 0:1/fsamp:dur;

% Compute the two cosine signals
x1 = A * cos(2 * pi * (fc - delf) * tt);
x2 = B * cos(2 * pi * (fc + delf) * tt);

% Sum the two signals to get the beat signal
xx = x1 + x2;
end
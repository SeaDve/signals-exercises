function [xx,tt] = mychirp( f1, f2, dur, fsamp )
%MYCHIRP generate a linear-FM chirp signal
%
% usage: xx = mychirp( f1, f2, dur, fsamp )
%
% f1 = starting frequency
% f2 = ending frequency
% dur = total time duration
% fsamp = sampling frequency (OPTIONAL: default is 11025)
%
% xx = (vector of) samples of the chirp signal
% tt = vector of time instants for t=0 to t=dur


if( nargin < 4 ) %-- Allow optional input argument
    fsamp = 11025;
end

dt = 1/fsamp;
tt = 0 : dt : dur;

k = (f2 - f1) / dur;

psi = 2*pi*(f1*tt + (k/2)*tt.*tt);

xx = real( 7.7*exp(1j*psi) );

soundsc( xx, fsamp );

end


fsamp = 11025;
dt = 1/fsamp;
dur = 1.8;
tt = 0 : dt : dur;
psi = 2*pi*(100 + 200*tt + 500*tt.*tt);
xxf = 7.7*exp(1j*psi);
xx = real( xxf );
soundsc( xx, fsamp );

length(tt)
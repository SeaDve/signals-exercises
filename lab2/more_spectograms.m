fsamp = 11025

[xx, tt] = beat(7.7, 7.7, 2000, 32, fsamp, 0.26);

soundsc(xx, fsamp);

spectrogram(xx,2048,[],2048,fsamp); colormap(1-gray(256));

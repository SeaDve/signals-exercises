[xx,tt] = mychirp(3000, -2000, 3, 11025);
spectrogram(xx,2048,[],2048,fsamp); colormap(1-gray(256));
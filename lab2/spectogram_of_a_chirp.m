fsamp = 11025
[xx,tt] = mychirp(5000, 300, 3, 11025);
spectrogram(xx,2048,[],2048,fsamp); colormap(1-gray(256));
% Simple Ripe Tomato Detector and Counter

% Step 1: Read and convert image
rgbtomato = imread('sampleF.jpg');
labtomato = rgb2lab(rgbtomato);
a_channel = labtomato(:,:,2);
a_channel_single = im2single(a_channel);

% Step 2: K-means clustering on a* channel
ncolors = 3;
pixel_labels = imsegkmeans(a_channel_single, ncolors, 'NumAttempts', 10);

% Step 3: Identify the tomato cluster (highest mean a* value)
mean_a_values = zeros(1, ncolors);
for k = 1:ncolors
    mean_a_values(k) = mean(a_channel(pixel_labels == k));
end
[~, tomato_cluster] = max(mean_a_values);

figure('Name','Cluster Histogram','NumberTitle','off');
for k = 1:ncolors
    subplot(1, ncolors, k);
    histogram(a_channel(pixel_labels == k), 30, 'FaceColor', 'r');
    title(['a* Histogram - Cluster ' num2str(k)]);
    xlabel('a* Value'); ylabel('Count');
end

% Step 4: Display masked RGB images of each cluster
figure('Name','Cluster Segmentation','NumberTitle','off');
subplot(2, ncolors+1, 1);
imshow(rgbtomato);
title('Original Image');

for k = 1:ncolors
    mask = pixel_labels == k;
    masked_rgb = rgbtomato .* uint8(repmat(mask, [1 1 3]));  % Apply mask to RGB

    subplot(2, ncolors+1, k+1);
    imshow(masked_rgb);
    if k == tomato_cluster
        title(['Cluster ' num2str(k) ' (Tomato)']);
    else
        title(['Cluster ' num2str(k)]);
    end
end

% Step 5: Process tomato cluster for counting
tomato_mask = pixel_labels == tomato_cluster;
tomato_mask = bwareaopen(tomato_mask, 500);  
tomato_mask = imfill(tomato_mask, 'holes'); 

% Step 6: Count and label tomatoes
cc = bwconncomp(tomato_mask);
numTomatoes = cc.NumObjects;
stats = regionprops(cc, 'BoundingBox');

% Step 7: Display final result with bounding boxes
subplot(2, ncolors+1, ncolors+2);
imshow(rgbtomato);
hold on;
title(['Detected Tomatoes: ' num2str(numTomatoes)]);

for i = 1:numTomatoes
    rectangle('Position', stats(i).BoundingBox, 'EdgeColor', 'r', 'LineWidth', 2);
end

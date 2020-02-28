% img1 = imread('../data/cv_cover.jpg');
% img2 = imread('../data/cv_desk.png');
% [locs1, locs2] = mymatchPics( img1, img2 );
% showMatchedFeatures(img1, img2, locs1, locs2, 'montage');

function [locs1, locs2] = matchPics( I1, I2 )
%MATCHPICS Extract features, obtain their descriptors, and match them!

%% Convert images to grayscale, if necessary
if (ndims(I1) == 3)
    I1 = rgb2gray(I1);
end
if (ndims(I2) == 3)
    I2 = rgb2gray(I2);
end
%% Detect features in both images
I1_points = detectFASTFeatures(I1);
I2_points = detectFASTFeatures(I2);

%% Obtain descriptors for the computed feature locations
[desc_1, locs_1] = computeBrief(I1, I1_points.Location);
[desc_2, locs_2] = computeBrief(I2, I2_points.Location);

%% Match features using the descriptors
indexPairs = matchFeatures(desc_1, desc_2, 'MatchThreshold', 10.0, 'MaxRatio', 0.7);

matchedPoints1 = locs_1(indexPairs(:,1),:);
matchedPoints2 = locs_2(indexPairs(:,2),:);
locs1 = matchedPoints1;
locs2 = matchedPoints2;

end


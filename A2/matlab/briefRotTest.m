% Your solution to Q2.1.5 goes here!

%% Read the image and convert to grayscale, if necessary
img = imread('../data/cv_cover.jpg');
if (ndims(img) == 3)
    img = rgb2gray(img);
end
% matches = zeros(1, 36);
matches = [];

%% Compute the features and descriptors
img_feature = detectFASTFeatures(img);
[desc, locs] = computeBrief(img, img_feature.Location);
% img_feature = detectSURFFeatures(img);
% [desc, locs] = extractFeatures(img, img_feature, 'Method', 'SURF');

for i = 0:36
    %% Rotate image
    img_rotated = imrotate(img, 10*(i));
%     disp(i);
%     disp(size(img_rotated));
    %% Compute features and descriptors
%     img_feature = detectSURFFeatures(img_rotated);
%     [new_desc, new_locs] = extractFeatures(img_rotated, img_feature, 'Method', 'SURF');
    img_feature = detectFASTFeatures(img_rotated);
    [new_desc, new_locs] = computeBrief(img_rotated, img_feature.Location);
    %% Match features
%     indexPairs = matchFeatures(desc, new_desc, 'MaxRatio', 0.7);
    indexPairs = matchFeatures(desc, new_desc, 'MatchThreshold', 10.0, 'MaxRatio', 0.7);
    matchedPoints1 = locs(indexPairs(:,1),:);
    matchedPoints2 = new_locs(indexPairs(:,2),:);
    matches_count = max(size(matchedPoints1, 1), size(matchedPoints2, 1));
    %% Update histogram
    matches = [matches matches_count];
%     disp(matches);
    if i == 13
        figure, showMatchedFeatures(img, img_rotated, matchedPoints1, matchedPoints2, 'montage');
    elseif i == 18
        figure, showMatchedFeatures(img, img_rotated, matchedPoints1, matchedPoints2, 'montage');
    elseif i == 26
        figure, showMatchedFeatures(img, img_rotated, matchedPoints1, matchedPoints2, 'montage');
    end
end

%% Display histogram
figure;
plot(0:10:360, matches);
xlabel('Rotation Degree');
ylabel('Frequency of Feature Match');
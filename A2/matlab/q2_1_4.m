%Q2.1.4
close all;
clear all;

cv_cover = imread('../data/cv_cover.jpg');
cv_desk = imread('../data/cv_desk.png');

[locs1, locs2] = matchPics(cv_cover, cv_desk);
figure;
showMatchedFeatures(cv_cover, cv_desk, locs1, locs2, 'montage');
title('Showing all matches');

cv_img = imread('../data/cv_cover.jpg');
desk_img = imread('../data/cv_desk.png');
[locs1, locs2] = matchPics(cv_img, desk_img);
[H2to1] = computeH(locs1, locs2);
locs1_prime = H2to1*([locs2 ones(size(locs2,1),1)]');
locs1_prime = locs1_prime';
locs1_prime = locs1_prime ./ locs1_prime(:,3);
locs1_prime = locs1_prime(1:10,:);
locs2 = locs2(1:10,:);
figure;
showMatchedFeatures(cv_img, desk_img, locs1_prime(:,1:2), locs2, 'montage');
% imshow(cv_img);
% hold on;
% plot(locs1_prime(:,(1:2)), 'r*');
% hold on;
% plot(locs1, 'g*');
title('computeH');

cv_img = imread('../data/cv_cover.jpg');
desk_img = imread('../data/cv_desk.png');
[locs1, locs2] = matchPics(cv_img, desk_img);
H2to1 = computeH_norm(locs1, locs2);
locs1_prime = H2to1*([locs2 ones(size(locs2,1),1)])';
locs1_prime = locs1_prime';
locs1_prime = locs1_prime ./ locs1_prime(:,3);
locs1_prime = locs1_prime(1:10,:);
locs2 = locs2(1:10,:);
figure;
showMatchedFeatures(cv_img, desk_img, locs1_prime(:,1:2), locs2, 'montage');
% imshow(cv_img);
% hold on;
% plot(locs1_prime(:,(1:2)), 'r*');
% hold on;
% plot(locs1, 'g*');
title('computeH norm');

clear all;

cv_img = imread('../data/cv_cover.jpg');
desk_img = imread('../data/cv_desk.png');
[locs1, locs2] = matchPics(cv_img, desk_img);
[H2to1, inliers] = computeH_ransac(locs1, locs2);
locs1_prime = H2to1*([locs2 ones(size(locs2,1),1)])';
locs1_prime = locs1_prime';
locs1_prime = locs1_prime ./ locs1_prime(:,3);
% locs1_prime = locs1_prime(1:10,:);
% locs2 = locs2(1:10,:);
locs1_prime = locs1_prime(inliers==1,:);
locs2 = locs2(inliers==1,:);
figure;
showMatchedFeatures(cv_img, desk_img, locs1_prime(:,1:2), locs2, 'montage');
% imshow(cv_img);
% hold on;
% plot(locs1_prime(:,(1:2)), 'r*');
% hold on;
% plot(locs1, 'g*');
title('computeH RANSAC');
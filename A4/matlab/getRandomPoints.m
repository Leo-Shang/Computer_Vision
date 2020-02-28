% I1 = imread('../data/campus/sun_abslhphpiejdjmpz.jpg');
% I2 = imread('../data/landscape/sun_afiznkgdkgugndcx.jpg');
% I3 = imread('../data/airport/sun_aerinlrdodkqnypz.jpg');
% alpha = 500;
% [points1] = getRandomPoints1(I1, alpha);
% [points2] = getRandomPoints1(I2, alpha);
% [points3] = getRandomPoints1(I3, alpha);
% imshow(I1);
% hold on;
% plot(points1, 'r.');
% hold on;
% figure;
% imshow(I2);
% hold on;
% plot(points2, 'r.');
% hold on;
% figure;
% imshow(I3);
% hold on;
% plot(points3, 'r.');
% hold on;

function [points] = getRandomPoints(I, alpha)
    [row, col, ~] = size(I);
    points = [alpha 2];
    for i = 1:alpha
        x = randperm(row, 1);
        y = randperm(col, 1);
        points(i,:) = [x y];
    end
end
% cv_img = imread('../data/cv_cover.jpg');
% desk_img = imread('../data/cv_desk.png');
% [locs1, locs2] = matchPics(cv_img, desk_img);
% H2to1 = compute_norm(locs1, locs2);
% locs1_prime = H2to1*([locs2 ones(size(locs2,1),1)])';
% locs1_prime = locs1_prime';
% locs1_prime = locs1_prime ./ locs1_prime(:,3);
% imshow(cv_img);
% hold on;
% plot(locs1_prime(:,(1:2)), 'r*');
% hold on;
% plot(locs1, 'g*');

function [H2to1] = computeH_norm(x1, x2)

    %% Compute centroids of the points
    centroid1 = [mean(x1(:,1)) mean(x1(:,2))];
    centroid2 = [mean(x2(:,1)) mean(x2(:,2))];

    %% Shift the origin of the points to the centroid
    x1_x = centroid1(1);
    x1_y = centroid1(2);
    x2_x = centroid2(1);
    x2_y = centroid2(2);

    x1_x_shift = x1(:,1) - x1_x;
    x1_y_shift = x1(:,2) - x1_y;
    x1_shift = [x1_x_shift x1_y_shift];

    x2_x_shift = x2(:,1) - x2_x;
    x2_y_shift = x2(:,2) - x2_y;
    x2_shift = [x2_x_shift x2_y_shift];

    %% Normalize the points so that the average distance from the origin is equal to sqrt(2).
    
    dist1 = sqrt(sum(x1_shift .^ 2, 2));
    dist2 = sqrt(sum(x2_shift .^ 2, 2));
    dist1 = sum(dist1);
    dist2 = sum(dist2);
    N = size(x1, 1);
    
    x1_scaling_factor = sqrt(2) * N / dist1;
    x2_scaling_factor = sqrt(2) * N / dist2;
%     x1_scaling_factor = sqrt(2)/sqrt((mean(x1_shift(1)))^2 + (mean(x1_shift(2)))^2);
%     x2_scaling_factor = sqrt(2)/sqrt((mean(x2_shift(1)))^2 + (mean(x2_shift(2)))^2);
    x1_scale = x1_shift .* x1_scaling_factor;
    x2_scale = x2_shift .* x2_scaling_factor;

    %% similarity transform 1
    scale1 = x1_scaling_factor;
    shift1_x = centroid1(1);
    shift1_y = centroid1(2);
    T1 = [scale1 0 -1*scale1*shift1_x;
        0 scale1 -1*scale1*shift1_y;
        0 0 1];

    %% similarity transform 2
    scale2 = x2_scaling_factor;
    shift2_x = centroid2(1);
    shift2_y = centroid2(2);
    T2 = [scale2 0 -1*scale2*shift2_x;
        0 scale2 -1*scale2*shift2_y;
        0 0 1];

    %% Compute Homography
%     [N, ~] = size(x1);
%     x1 = [x1 ones(N, 1)];
%     x2 = [x2 ones(N, 1)];
%     x1_prime = T1 * x1';
%     x2_prime = T2 * x2';
%     x1_prime = x1_prime ./ x1_prime(3,:);
%     x2_prime = x2_prime ./ x2_prime(3,:);
%     x1_prime = x1_prime((1:size(x1_prime,1)-1),:)';
%     x2_prime = x2_prime((1:size(x2_prime,1)-1),:)';
    [H2to1] = computeH(x1_scale, x2_scale);
    
    %% Denormalization
    H2to1 = T1 \ H2to1 * T2;
end
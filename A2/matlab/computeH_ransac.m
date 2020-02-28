% cv_img = imread('../data/cv_cover.jpg');
% desk_img = imread('../data/cv_desk.png');
% [locs1, locs2] = matchPics(cv_img, desk_img);
% [H2to1, inliers] = compute_ransac(locs1, locs2);
% locs1_prime = H2to1*([locs2 ones(size(locs2,1),1)])';
% locs1_prime = locs1_prime';
% locs1_prime = locs1_prime ./ locs1_prime(:,3);
% imshow(cv_img);
% hold on;
% plot(locs1_prime(:,(1:2)), 'r*');
% hold on;
% plot(locs1, 'g*');

function [ bestH2to1, inliers] = computeH_ransac( locs1, locs2)
%COMPUTEH_RANSAC A method to compute the best fitting homography given a
%list of matching points.
    pair_count = 4;
    N = 100;
    threshold = 2;
    [num_points, ~] = size(locs1);
    largest_inlier = 0;
    bestH2to1 = zeros(3,3);
    best_inliers = zeros(num_points, 1);
    if num_points < pair_count
        disp("Not enough points");
        inliers = zeros(num_points, 1);
        return;
    else
        for i = 1:N
            rand_index = randperm(num_points);
            locs1_selected = locs1(rand_index(1:pair_count),:);
            locs2_selected = locs2(rand_index(1:pair_count),:);
            [H] = computeH(locs1_selected, locs2_selected);
            
            locs1_H = [locs2 ones(num_points, 1)]';
            locs1_H = H * locs1_H;
            locs1_H = locs1_H ./ locs1_H(3,:);
            locs1_H = (locs1_H((1:size(locs1_H,1)-1),:))';
            
            inlier_count = 0;
            inliers = zeros(num_points, 1);
            
            for j = 1:num_points
                diff = sqrt(((locs1_H(j,1)-locs1(j,1))^2) + ((locs1_H(j,2)-locs1(j,2))^2));
                if diff < threshold
                    inliers(j,1) = 1;
                    inlier_count = inlier_count + 1;
                end
            end
            
            if inlier_count >= largest_inlier
                largest_inlier = inlier_count;
                best_inliers = inliers;
            end
        end
        inliers = best_inliers;
%         disp(inliers);
        p1 = locs1(inliers==1,:);
        p2 = locs2(inliers==1,:);
        bestH2to1 = computeH_norm(p2,p1);
    end

%Q2.2.3
end


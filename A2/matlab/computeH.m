% cv_img = imread('../data/cv_cover.jpg');
% desk_img = imread('../data/cv_desk.png');
% [locs1, locs2] = matchPics(cv_img, desk_img);
% [H2to1] = compute(locs1, locs2);
% locs1_prime = H2to1*([locs2 ones(size(locs2,1),1)]');
% locs1_prime = locs1_prime';
% locs1_prime = locs1_prime ./ locs1_prime(:,3);
% imshow(cv_img);
% hold on;
% plot(locs1_prime(:,(1:2)), 'r*');
% hold on;
% plot(locs1, 'g*');


function [ H2to1 ] = computeH( x1, x2 )
%COMPUTEH Computes the homography between two sets of points
    [N, ~] = size(x1);
    x1 = [x1 ones(N, 1)];
    x2 = [x2 ones(N, 1)];
     
    A = zeros(2*N, 9);
    
    for i = 1:N
        x1_row = x1(i, :);
        x2_row = x2(i, :);
        A(2*i-1,:) = [(-1).*x2_row 0 0 0 x1_row(1)*x2_row];
        A(2*i,:) = [0 0 0 (-1).*x2_row x1_row(2)*x2_row];
    end
    
    [~,~,V] = svd(A);
    H2to1 = V(:, end);
    H2to1 = reshape(H2to1,3,3)';
    
    
%     [V, D] = eig(A'*A);
%     v = V(:,1);
%     H2to1 = reshape(v,3,3)';

%     min_eig_value = min(D);
%     index = find(min_eig_value);
%     min_eig_vector = V(:, index);
%     
%     H2to1 = vec2mat(min_eig_vector,3);
    
end

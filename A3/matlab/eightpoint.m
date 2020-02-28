% data = load('../data/someCorresp.mat');
% img1 = imread('../data/im1.png');
% img2 = imread('../data/im2.png');
% F = eightpoint1(data.pts1, data.pts2, data.M);
% displayEpipolarF(img1, img2, F);


function F = eightpoint(pts1, pts2, M)
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.1 - Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from correspondence '../data/some_corresp.mat'
    temp = [1/M 0 0; 0 1/M 0; 0 0 1];
    pts1_scaled = temp * [pts1 ones(size(pts1,1),1)]';
    pts2_scaled = temp * [pts2 ones(size(pts2,1),1)]';
    
    rows_count = size(pts1, 1);
    A = zeros(rows_count, 9);
    
    for i = 1:rows_count
        x = pts1_scaled(:, i);
        x_prime = pts2_scaled(:,i)';
        A(i,:) = [x(1)*x_prime x(2)*x_prime x_prime];
    end
    
    [~,~,V] = svd(A);
    F = reshape(V(:, end), 3, 3)';
    
    [U,S,V] = svd(F);
    S_prime = S;
    S_prime(3,3) = 0;
    F_prime = U * S_prime * V';
    
    F_prime = refineF(F_prime, pts1_scaled', pts2_scaled');
    F = temp' * F_prime * temp;
end
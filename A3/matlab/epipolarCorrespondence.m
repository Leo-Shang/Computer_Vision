% im1 = imread('../data/im1.png');
% im2 = imread('../data/im2.png');
% data = load('../data/someCorresp.mat');
% F = eightpoint(data.pts1, data.pts2, data.M);
% [coordsIM1, coordsIM2] = epipolarMatchGUI(im1, im2, F);

function [pts2] = epipolarCorrespondence(im1, im2, F, pts1)
% epipolarCorrespondence:
%   Args:
%       im1:    Image 1
%       im2:    Image 2
%       F:      Fundamental Matrix from im1 to im2
%       pts1:   coordinates of points in image 1
%   Returns:
%       pts2:   coordinates of points in image 2
%
    im1 = double(im1);
    im2 = double(im2);
    pts2 = zeros(size(pts1));
    pts1 = [pts1 ones(size(pts1,1),1)]';
    lines = F * pts1;
    
    windowsize = 10;
    
    for index = 1:size(lines, 2) % for each epipolar line
        x1 = pts1(1, index);
        y1 = pts1(2, index);
        im1_window = im1((y1-windowsize):(y1+windowsize), (x1-windowsize):(x1+windowsize), :);
        
        candidate_set_size = size(im2,2)-2*windowsize;
%         error = Inf(candidate_set_size, 1);
        min_error = Inf;
        temp = [0,0];
        
        for i=1+windowsize:candidate_set_size-windowsize % for each window of one epipolar line
            x2 = i;
            y2 = (-1*lines(3,index)-lines(1,index)*x2)/lines(2,index);
            im2_window = im2(round(y2-windowsize):round(y2+windowsize), round(x2-windowsize):round(x2+windowsize), :);
            diff = (im1_window - im2_window) .^ 2;
%             disp(size(diff));
%             error(i,1) = sqrt(sum(double(diff), 'all'));
            error = sum(sqrt(diff), 'all');
            if error < min_error
                temp = [x2 y2];
                min_error = error;
            end 
        end
        pts2(index, :) = temp;
    end
end
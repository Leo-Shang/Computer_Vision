function dispM = get_disparity(im1, im2, maxDisp, windowSize)
% GET_DISPARITY creates a disparity map from a pair of rectified images im1 and
%   im2, given the maximum disparity MAXDISP and the window size WINDOWSIZE.
    
    [row, col] = size(im1);
    dispM = zeros(size(im1));
    w = (windowSize-1)/2;
    
    for i = 1+w:row-w
        for j = 1+w+maxDisp:col-w-maxDisp
            disp_list = zeros(maxDisp, 1);
            for d = 0:maxDisp
                im1_patch = im1(i-w:i+w, j-w:j+w);
                im2_patch = im2(i-w:i+w, j-w-d:j+w-d);
                diff = (im1_patch - im2_patch).^2;
                mask = ones(windowSize, windowSize);
                diff = conv2(diff, mask);
                dist = sum(diff, 'all');
                
                disp_list(d+1, 1) = dist;
            end
            
            [~, index] = min(disp_list);
            dispM(i,j) = index - 1;
        end
    end
end

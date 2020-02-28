% datadir     = '../data';    %the directory containing the images
% imglist = dir(sprintf('%s/*.jpg', datadir));
% img = imread(sprintf('%s/%s', datadir, imglist(7).name));
% % img = imread('../data/img01.jpg');
% threshold = 0.03;
% rhoRes    = 2;
% thetaRes  = pi/90;
% nLines    = 20;
% [H, rhoScale, thetaScale] = myHoughTransform(myEdgeFilter(img,4), threshold, rhoRes, thetaRes);
% [rhos, thetas] = theHoughLines(H, nLines);

function [rhos, thetas] = myHoughLines(H, nLines)
%Your implemention here
    [rownum, colnum] = size(H);
    img_NMS = zeros(size(H));
    rhos = zeros(nLines, 1);
    thetas = zeros(nLines, 1);
    
    for row = 2:rownum - 1
        for col = 2:colnum - 1
            temp = H(row-1:row+1, col-1:col+1);
            if H(row, col) ~= max(reshape(temp, [], 1))
                img_NMS(row, col) = 0;
            else
                img_NMS(row, col) = H(row, col);
            end
        end
    end
    
    for i = 1:nLines
        highest = max(img_NMS(:));
        [x, y] = find(img_NMS == highest);
        rhos(i, 1) = x(1);
        thetas(i, 1) = y(1);
        img_NMS(x, y) = 0;
    end
    
%     imshow(rescale(H));
%     hold on;
%     plot(thetas, rhos, 'r+');
    
    
end
        
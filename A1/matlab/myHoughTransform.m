% datadir     = '../data';    %the directory containing the images
% imglist = dir(sprintf('%s/*.jpg', datadir));
% img = imread(sprintf('%s/%s', datadir, imglist(1).name));
% % img = imread('../data/img01.jpg');
% threshold = 0.03;
% rhoRes    = 2;
% thetaRes  = pi/90;
% img1 = myEdgeFilter(img, sigma);
% img1 = theHoughTransform(img1, threshold, rhoRes, thetaRes);
% imshow(img1, []);

% BW1 = edge(img, 'Canny');
% [H1, theta, rho] = hough(BW1);
% imshow(imadjust(rescale(H1)), []);


function [H, rhoScale, thetaScale] = myHoughTransform(Im, threshold, rhoRes, thetaRes)
%Your implementation here
%     Im = edge(Im, 'sobel');
    [rownum,colnum] = size(Im);
    maxRho = sqrt(rownum.^2 + colnum.^2);
    rhoScale = 0:rhoRes:maxRho;
    thetaRes = thetaRes * 180 / pi;
    thetaScale = 0:thetaRes:360;
    H = zeros(length(rhoScale), length(thetaScale));

    for row = 1:rownum
        for col = 1:colnum
            if(Im(row,col) > threshold)
                for thetaID = 1:length(thetaScale)
                    rho = col*cosd(thetaScale(thetaID)) + row*sind(thetaScale(thetaID));
                    if rho >= 0
                        rho = floor(rho);
                        theta = floor(thetaScale(thetaID));
                        thetaIndex = find(thetaScale==theta);
                        rhoIndex = find(rhoScale==rho);
                        H(rhoIndex, thetaIndex) = H(rhoIndex, thetaIndex) + 1;
%                         theta = theta + thetaRes;
                    end
                end
            end
        end
    end
    thetaScale = thetaScale .* (pi/180);
%     H = H';
end
        
        
% I1 = imread('../data/campus/sun_abslhphpiejdjmpz.jpg');
% I2 = imread('../data/landscape/sun_afiznkgdkgugndcx.jpg');
% I3 = imread('../data/airport/sun_aerinlrdodkqnypz.jpg');
% alpha = 500;
% k = 0.04;
% [points1] = getHarrisPoints1(I1, alpha, k);
% [points2] = getHarrisPoints1(I2, alpha, k);
% [points3] = getHarrisPoints1(I3, alpha, k);
% figure;
% imshow(I1);
% hold on;
% plot(points1(:,2), points1(:,1), 'r.');
% hold on;
% figure;
% imshow(I2);
% hold on;
% plot(points2(:, 2), points2(:,1), 'r.');
% hold on;
% figure;
% imshow(I3);
% hold on;
% plot(points3(:, 2), points3(:,1), 'r.');
% hold on;


function [points] = getHarrisPoints(I, alpha, k)
    if (ndims(I) == 3)
        I = rgb2gray(I);
    end
    I = double(I)/255;
    
    windowSize = 5;
    filter = ones(windowSize, windowSize);
    
%     horizontal_sobel = fspecial('sobel');
    [imgx,imgy] = imgradientxy(I);
%     vertical_sobel = horizontal_sobel';
%     imgx = conv2(I, horizontal_sobel, 'same');
%     imgy = conv2(I, vertical_sobel, 'same');
    
    Ixxs = conv2(imgx .* imgx, filter, 'same');
    Ixys = conv2(imgx .* imgy, filter, 'same');
    Iyxs = conv2(imgy .* imgx, filter, 'same');
    Iyys = conv2(imgy .* imgy, filter, 'same');
    
    R = ((Ixxs .* Iyys)-(Ixys .* Iyxs)) - (k * ((Ixxs + Iyys) .^ 2));
    
    angle = atan2(imgy, imgx);
    img_NMS = zeros(size(R));
    [rownum, colnum] = size(img_NMS);
    
    for row = 2:rownum - 1
        for col = 2:colnum - 1
            gradient = angle(row, col);
            if gradient < 0
                gradient = gradient + pi;
            end
%             disp(gradient);
            if gradient >= (7/8)*pi || gradient < (1/8)*pi
                if R(row, col) < R(row-1, col) || R(row, col) < R(row+1, col)
                    img_NMS(row, col) = 0;
                else
                    img_NMS(row, col) = R(row, col);
                end
            elseif gradient >= (1/8)*pi && gradient < (3/8)*pi
                if R(row, col) < R(row+1, col+1) || R(row, col) < R(row-1, col-1)
                    img_NMS(row, col) = 0;
                else
                    img_NMS(row, col) = R(row, col);
                end
            elseif gradient >= (3/8)*pi && gradient < (5/8)*pi
                if R(row, col) < R(row, col-1) || R(row, col) < R(row, col+1)
                    img_NMS(row, col) = 0;
                else
                    img_NMS(row, col) = R(row, col);
                end
            elseif gradient >= (5/8)*pi && gradient < (7/8)*pi
                if R(row, col) < R(row+1, col-1) || R(row, col) < R(row-1, col+1)
                    img_NMS(row, col) = 0;
                else
                    img_NMS(row, col) = R(row, col);
                end
            end
        end
    end
    
    R = img_NMS;
    
    [~,index] = maxk(R(:), alpha);
    [x, y] = ind2sub(size(I), index);
    points = [x y];
end
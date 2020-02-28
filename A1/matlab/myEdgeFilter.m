% datadir     = '../data';    %the directory containing the images
% imglist = dir(sprintf('%s/*.jpg', datadir));
% img = imread(sprintf('%s/%s', datadir, imglist(1).name));
% sigma     = 2;
% img1 = theEdgeFilter(img, sigma);
% imshow(img1, []);

function [img1] = myEdgeFilter(img0, sigma)
    %Your implemention
    [rownum,colnum] = size(img0); 
    img1 = zeros(rownum, colnum);
    hsize = 2 * ceil(3*sigma) + 1;
    % e = exp(1);
%     img0 = double(img0);
    % imgx = zeros(rownum, colnum);
    % imgy = zeros(rownum, colnum);
    horizontal_sobel = fspecial('sobel');
    vertical_sobel = horizontal_sobel';
    gaussian = fspecial('gaussian',hsize,sigma);

    % for i = 1:rownum
    %     for j = 1:colnum
    %         temp1 = (1/(2*pi*sigma.^2));
    %         temp2 = e.^((-1)*(i.^2+j.^2)/(2*sigma.^2));
    %         img0(i, j) = temp1*temp2;
    %     end
    % end
    img0 = myImageFilter(img0, gaussian);

    imgx = myImageFilter(img0, horizontal_sobel);
    imgy = myImageFilter(img0, vertical_sobel);
    % imshow([imgx,imgy])
    for i = 1:rownum
        for j = 1:colnum
            img1(i, j) = sqrt(imgx(i,j).^2 + imgy(i,j).^2);
        end
    end
%     disp(img1);
    
    angle = atan2(imgy, imgx);
    img_NMS = zeros(size(img1));
    [rownum, colnum] = size(img_NMS);
    
    for row = 2:rownum - 1
        for col = 2:colnum - 1
            gradient = angle(row, col);
            if gradient < 0
                gradient = gradient + pi;
            end
%             disp(gradient);
            if gradient >= (7/8)*pi || gradient < (1/8)*pi
                if img1(row, col) < img1(row-1, col) || img1(row, col) < img1(row+1, col)
                    img_NMS(row, col) = 0;
                else
                    img_NMS(row, col) = img1(row, col);
                end
            elseif gradient >= (1/8)*pi && gradient < (3/8)*pi
                if img1(row, col) < img1(row+1, col+1) || img1(row, col) < img1(row-1, col-1)
                    img_NMS(row, col) = 0;
                else
                    img_NMS(row, col) = img1(row, col);
                end
            elseif gradient >= (3/8)*pi && gradient < (5/8)*pi
                if img1(row, col) < img1(row, col-1) || img1(row, col) < img1(row, col+1)
                    img_NMS(row, col) = 0;
                else
                    img_NMS(row, col) = img1(row, col);
                end
            elseif gradient >= (5/8)*pi && gradient < (7/8)*pi
                if img1(row, col) < img1(row+1, col-1) || img1(row, col) < img1(row-1, col+1)
                    img_NMS(row, col) = 0;
                else
                    img_NMS(row, col) = img1(row, col);
                end
            end
        end
    end
    img1 = img_NMS;     
    
end
    
                
        
        

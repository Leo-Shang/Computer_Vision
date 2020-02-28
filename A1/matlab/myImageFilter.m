% datadir     = '../data';    %the directory containing the images
% imglist = dir(sprintf('%s/*.jpg', datadir));
% img = imread(sprintf('%s/%s', datadir, imglist(1).name));
% h = [-1 -2 -1; 0 0 0; 1 2 1];
% img1 = theImageFilter(img, h);
% imshow(img1, []);


function [img1] = myImageFilter(img0, h)
    [rownum,colnum] = size(img0);
    [hRow,hCol] = size(h);
    img1 = zeros(rownum, colnum);

    img0 = padarray(img0, [floor(hRow/2) floor(hCol/2)], 'replicate');
    img0 = double(img0);

    for row = 1:rownum
        for col = 1:colnum
            temp = img0(row:(row+hRow-1), col:(col+hCol-1));
            temp_reshape = reshape(temp, [], 1);
            h_reshape = reshape(h, [], 1);
            total = dot(temp_reshape, h_reshape);

            img1(row, col) = -1 * total;
        end
    end

end
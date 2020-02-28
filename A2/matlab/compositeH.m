function [ composite_img ] = compositeH( H2to1, template, img )
%COMPOSITE Create a composite image after warping the template image on top
%of the image using the homography

% Note that the homography we compute is from the image to the template;
% x_template = H2to1*x_photo
% For warping the template to the image, we need to invert it.
% H_template_to_img = inv(H2to1);

composite_img = img;
greyImg = rgb2gray(img);
[height, width] = size(greyImg);

for i = 1:height
    for j = 1:width
        if template(i,j,:) == [0;0;0]
            continue;
        end
        composite_img(i,j,:) = template(i,j,:);
    end
end

%% Create mask of same size as template
% mask = zeros(size(template));

%% Warp mask by appropriate homography
% mask = warpH(mask, H_template_to_img, size(mask), template);

%% Warp template by appropriate homography
% template = warpH(template, inv(H_template_to_img), size(mask));

%% Use mask to combine the warped template and the image

end

% warp_im = warpH(im, H, out_size,fill_value)
% hp_cover = template
% desk = img
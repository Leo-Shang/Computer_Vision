% Q3.3.1
vid_book = loadVid('../data/book.mov');
vid_source = loadVid('../data/ar_source.mov');
cv_img = imread('../data/cv_cover.jpg');
vid_length = min(size(vid_book, 2), size(vid_source, 2));
v = VideoWriter('../results/output.avi');
open(v);

for i = 1:vid_length
    vid_book_frame = vid_book(i).cdata;
    vid_source_frame = vid_source(i).cdata;
    vid_source_frame = imcrop(vid_source_frame, [0, 45, 640, 270]);
    [locs1, locs2] = matchPics(cv_img, vid_book_frame);
    [bestH2to1, ~] = computeH_ransac(locs1, locs2);
    vid_source_frame_scaled = imresize(vid_source_frame, [size(cv_img,1) size(cv_img,2)]);
    if sum(isnan(bestH2to1(:))) > 0
        writeVideo(v, vid_book_frame);
    else
        warp_source = warpH(vid_source_frame_scaled, bestH2to1, [size(vid_book_frame,1) size(vid_book_frame,2)]);
        img = compositeH(inv(bestH2to1), warp_source, vid_book_frame);
        writeVideo(v, img);
        fprintf('Processing: %d/%d\n',i,vid_length);
    end
end

close(v);
fprintf('The video processing has finished');
    
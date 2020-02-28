% A test script using templeCoords.mat
%
% Write your code here
%
img1 = imread('../data/im1.png');
img2 = imread('../data/im2.png');
corresp = load('../data/someCorresp.mat');

F = eightpoint(corresp.pts1, corresp.pts2, corresp.M);

img1 = double(img1);
img2 = double(img2);

coords = load('../data/templeCoords.mat');
[pts2] = epipolarCorrespondence(img1, img2, F, coords.pts1);

intrinsics = load('../data/intrinsics.mat');
E = essentialMatrix(F, intrinsics.K1, intrinsics.K2);

M1 = [eye(3) zeros(3, 1)];
P1 = intrinsics.K1 * M1;
[M2s] = camera2(E);
negative_depth_count = zeros(size(M2s,3), 1);
pts3ds = zeros(size(coords.pts1,1), 3, size(M2s, 3));
for i = 1:size(M2s,3)
    pts3d = triangulate(P1, coords.pts1, intrinsics.K2* M2s(:,:,i), pts2);
    negative_depth_count(i,1) = sum(pts3d(:,3) < 0);
    pts3ds(:,:,i) = pts3d;
end

[~,index] = min(negative_depth_count);
correct_M2 = M2s(:,:,index(1));
bestPts3d = pts3ds(:,:,index(1));

plot3(bestPts3d(:,1),bestPts3d(:,2),bestPts3d(:,3),'b.');
xlabel('x');
ylabel('y');
zlabel('z');

R1 = eye(3);
t1 = zeros(3, 1);
R2 = correct_M2(:,(1:3));
t2 = correct_M2(:,4);

% save extrinsic parameters for dense reconstruction
save('../data/extrinsics.mat', 'R1', 't1', 'R2', 't2');

P2 = intrinsics.K2*correct_M2;
reprojectIm1 = P1 * [bestPts3d ones(size(bestPts3d,1),1)]';
reprojectIm2 = P2 * [bestPts3d ones(size(bestPts3d,1),1)]';
reprojectIm1 = reprojectIm1 ./ reprojectIm1(end,:);
reprojectIm2 = reprojectIm2 ./ reprojectIm2(end,:);
reprojectIm1 = (reprojectIm1(1:2,:))';
reprojectIm2 = (reprojectIm2(1:2,:))';
errorIm1 = sum(sqrt(sum((reprojectIm1 - coords.pts1).^2,1)))/size(reprojectIm1,1);
errorIm2 = sum(sqrt(sum((reprojectIm2 - pts2).^ 2,1)))/size(reprojectIm2,1);
error = (errorIm1 + errorIm2)/2;
disp(['The average re-projection error in image 1 is: ', num2str(errorIm1)]);
disp(['The average re-projection error in image 2 is: ', num2str(errorIm2)]);
disp(['The overall average re-projection error is: ', num2str(error)]);


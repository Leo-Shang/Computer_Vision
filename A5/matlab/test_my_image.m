%% Network defintion
layers = get_lenet();

%% Loading data
fullset = false;
[xtrain, ytrain, xvalidate, yvalidate, xtest, ytest] = load_mnist(fullset);
actual = [10 4 5 7 3];
% load the trained weights
load lenet.mat

%% Testing the network
% Modify the code to get the confusion matrix
myimg = zeros(28*28, 5);
for i = 1:5
    path = strcat('./test/3.3.', num2str(i,'%01d'));
    img = imread(strcat(path, '.png'));
    img = rgb2gray(img);
    img = imresize(img, [28,28]);
    img = img';
    img = (img(:));
    myimg(:,i) = img ./ 255;
end

confusion = zeros(10, 10);
for i=1:100:size(xtest, 2)
    data = xtest(:, i:i+99);
    data(:,1:5) = myimg;
    [output, P] = convnet_forward(params, layers, data);
    [~, result] = max(P,[],1);
%     result = round(result);
    for j = 1:5
        fprintf('The actual class is: %d\n', actual(j));
        fprintf('The predicted class is %d\n',result(j));
        disp(P(:,j)');
    end
    break;
end





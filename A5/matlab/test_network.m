%% Network defintion
layers = get_lenet();

%% Loading data
fullset = false;
[xtrain, ytrain, xvalidate, yvalidate, xtest, ytest] = load_mnist(fullset);

% load the trained weights
load lenet.mat

%% Testing the network
% Modify the code to get the confusion matrix
confusion = zeros(10, 10);
for i=1:100:size(xtest, 2)
    [output, P] = convnet_forward(params, layers, xtest(:, i:i+99));
    [~, result] = max(P,[],1);
%     result = round(result);
    for j = 1:100
        actural = ytest(i+j-1);
        predicted = result(j);
        confusion(actural, predicted) = confusion(actural, predicted) + 1;
    end
end
disp('Confusion Matrix: ');
disp(confusion);
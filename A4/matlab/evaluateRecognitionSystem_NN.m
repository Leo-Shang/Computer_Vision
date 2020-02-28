clear all;
load('../data/traintest.mat');

K = 200;
filterBank = createFilterBank();
test_total = size(test_imagenames, 2);
train_total = size(train_imagenames, 2);

% RANDOM
load('visionRandom.mat');
numerator_euc = 0;
numerator_chi = 0;

C_euc = zeros(8,8);
C_chi = zeros(8,8);

for i = 1:test_total
    I = imread(strcat('../data/', test_imagenames{i}));
    [wordMap] = getVisualWords(I, filterBank, dictionary');
    [h] = getImageFeatures(wordMap, K);
    dist_euclidean = zeros(train_total, 1);
    dist_chi = zeros(train_total, 1);
    for j = 1:train_total
        [h_train] = trainFeatures(j,:);
        dist_euclidean(j,1) = getImageDistance(h, h_train, 'euclidean');
        dist_chi(j,1) = getImageDistance(h, h_train, 'chi2');
    end
    [~, min_euc_index] = min(dist_euclidean);
    [~, min_chi_index] = min(dist_chi);
    result_euc = trainLabels(min_euc_index);
    result_chi = trainLabels(min_chi_index);
    
    if result_euc == test_labels(i)
        numerator_euc = numerator_euc + 1;
    end
    if result_chi == test_labels(i)
        numerator_chi = numerator_chi + 1;
    end
    C_euc(test_labels(i), result_euc) = C_euc(test_labels(i), result_euc) + 1;
    C_chi(test_labels(i), result_chi) = C_chi(test_labels(i), result_chi) + 1;
end

fprintf('Random + euclidean: %6.2f percents \n', numerator_euc/test_total*100);
fprintf('Confustion Matrix: \n');
disp(C_euc);
fprintf('Random + chi2: %6.2f percents \n', numerator_chi/test_total*100);
fprintf('Confustion Matrix: \n');
disp(C_chi);

% HARRIS
load('visionHarris.mat');
numerator_euc = 0;
numerator_chi = 0;

C_euc = zeros(8,8);
C_chi = zeros(8,8);

for i = 1:test_total
    I = imread(strcat('../data/', test_imagenames{i}));
    [wordMap] = getVisualWords(I, filterBank, dictionary');
    [h] = getImageFeatures(wordMap, K);
    dist_euclidean = zeros(train_total, 1);
    dist_chi = zeros(train_total, 1);
    for j = 1:train_total
        [h_train] = trainFeatures(j,:);
        dist_euclidean(j,1) = getImageDistance(h, h_train, 'euclidean');
        dist_chi(j,1) = getImageDistance(h, h_train, 'chi2');
    end
    [~, min_euc_index] = min(dist_euclidean);
    [~, min_chi_index] = min(dist_chi);
    result_euc = trainLabels(min_euc_index);
    result_chi = trainLabels(min_chi_index);
    
    if result_euc == test_labels(i)
        numerator_euc = numerator_euc + 1;
    end
    if result_chi == test_labels(i)
        numerator_chi = numerator_chi + 1;
    end
    C_euc(test_labels(i), result_euc) = C_euc(test_labels(i), result_euc) + 1;
    C_chi(test_labels(i), result_chi) = C_chi(test_labels(i), result_chi) + 1;
end

fprintf('Harris + euclidean: %6.2f percents \n', numerator_euc/test_total*100);
fprintf('Confustion Matrix: \n');
disp(C_euc);
fprintf('Harris + chi2: %6.2f percents \n', numerator_chi/test_total*100);
fprintf('Confustion Matrix: \n');
disp(C_chi);
    
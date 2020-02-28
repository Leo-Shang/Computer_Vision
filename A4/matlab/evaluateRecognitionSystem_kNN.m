clear all;
k_max = 40;
x_array = [1:k_max];
accuracy = zeros(k_max, 1);

load('../data/traintest.mat');

K = 200;
filterBank = createFilterBank();
test_total = size(test_imagenames, 2);
train_total = size(train_imagenames, 2);

load('visionHarris.mat');

for k = 1:k_max
    disp(k);
    numerator = 0;

    C = zeros(8,8);
    best_accuracy = 0;
    C_best = C;
    
    for i = 1:test_total
        I = imread(strcat('../data/', test_imagenames{i}));
        [wordMap] = getVisualWords(I, filterBank, dictionary');
        [h] = getImageFeatures(wordMap, K);
        dist = zeros(train_total, 1);
        for j = 1:train_total
            [h_train] = trainFeatures(j,:);
            dist(j,1) = getImageDistance(h, h_train, 'chi2');
        end
        
%         [~, idxMin] = sort(dist);
%         kNN = idxMin(1:k);
        [~, kNN] = mink(dist, k);
        
        counts = zeros(8,1);
        for n = 1:k
            label = trainLabels(kNN(n));
            counts(label) = counts(label) + 1;
        end

        [~, result] = max(counts);

        if result == test_labels(i)
            numerator = numerator + 1;
        end

        C(test_labels(i), result) = C(test_labels(i), result) + 1;
        if numerator/test_total > best_accuracy
            C_best = C;
            best_accuracy = numerator/test_total;
        end
    end
    accuracy(k,1) = numerator/test_total*100;
end

plot(x_array, accuracy);
xlabel('k');
ylabel('Accuracy');
title('Size of k versus Accuracy');
fprintf('The confusion matrix for best k is: \n');
disp(C_best);


clear all;
load('../data/traintest.mat');
load('dictionaryRandom.mat');
load('dictionaryHarris.mat');


filterBank = createFilterBank();

K = 200;
T = size(train_imagenames,2);
trainFeatures = zeros(T,K);
trainLabels = train_labels;

dictionary = dictionaryRandom;
for i = 1:T
    I = imread(strcat('../data/', train_imagenames{i}));
    [wordMap] = getVisualWords(I, filterBank, dictionary');
    [h] = getImageFeatures(wordMap, K);
    trainFeatures(i,:) = h;
end
save('visionRandom.mat', 'dictionary', 'filterBank', 'trainFeatures', 'trainLabels');

dictionary = dictionaryHarris;
for i = 1:T
    I = imread(strcat('../data/', train_imagenames{i}));
    [wordMap] = getVisualWords(I, filterBank, dictionary');
    [h] = getImageFeatures(wordMap, K);
    trainFeatures(i,:) = h;
end
save('visionHarris.mat', 'dictionary', 'filterBank', 'trainFeatures', 'trainLabels');


    
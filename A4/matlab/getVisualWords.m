% I = imread('../data/bedroom/sun_abpmyykpuijkvxbq.jpg');
% showims(I);
% I = imread('../data/bedroom/sun_aweaiwcjpyjurkxw.jpg');
% showims(I);
% I = imread('../data/bedroom/sun_akffxfzdyktluhuq.jpg');
% showims(I);
% I = imread('../data/auditorium/sun_aaslkqqibkansrbd.jpg');
% showims(I);
% I = imread('../data/auditorium/sun_ahxfbcfdtvgnrivf.jpg');
% showims(I);
% I = imread('../data/auditorium/sun_bwglzyboasqjhbsx.jpg');
% showims(I);
% 
% function showims(I)
%     load('dictionaryRandom.mat');
%     load('dictionaryHarris.mat');
%     filterBank = createFilterBank();
%     [wordMap] = getVisualWords1(I, filterBank, dictionaryRandom');
%     [wordMap2] = getVisualWords1(I, filterBank, dictionaryHarris');
%     figure;
% %     imshow(I);
% %     title('original image');
% %     figure;
% %     imshow(label2rgb(wordMap));
% %     title('random points')
% %     figure;
% %     imshow(label2rgb(wordMap2));
% %     title('harris points');
%     space = ones(size(I,1),5,3) .* 255;
%     imshow([I space label2rgb(wordMap) space label2rgb(wordMap2)])
% end

function [wordMap] = getVisualWords(I, filterBank, dictionary)
    if (ndims(I) == 3)
        [H, W, ~] = size(I);
    else
        [H, W] = size(I);
    end
    
    colSize = 3*size(filterBank,1);
    
    dictionary = dictionary';
    [filterResponses] = extractFilterResponses(I, filterBank);
    filterResponses = reshape(filterResponses, H*W, colSize);

    distance = pdist2(filterResponses, dictionary, 'euclidean');
%     distance = getImageDistance(filterResponses, dictionary, 'euclidean');
    [~, index] = min(distance, [], 2);
    wordMap = reshape(index, H, W);
    
end
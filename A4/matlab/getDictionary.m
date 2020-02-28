function [dictionary] = getDictionary(imgPaths, alpha, K, method)
    filterBank = createFilterBank();
    N = size(imgPaths,2);
%     N = round(N/100);
    pixelResponses = zeros(alpha*N, 3*size(filterBank,1));
    pointer = 1;
    
    for i = 1:N     % for each image
%         disp(i)
%         disp(imgPaths(i))
        I = imread(strcat('../data/', imgPaths{1, i}));
        [filterResponses] = extractFilterResponses(I, filterBank);
        points = zeros(alpha, 2);
        if strcmp(method, 'random')
            points = getRandomPoints(I, alpha);
        elseif strcmp(method, 'harris')
            points = getHarrisPoints(I, alpha, K);
        else
            pointer = pointer + 1;
            continue
        end
        for j = 1:alpha     % for each point in an image
            row = filterResponses(points(j, 1), points(j, 2), :);
            row = reshape(row, 1, size(pixelResponses, 2));
            pixelResponses(pointer, :) = row;
            pointer = pointer + 1;
        end
    end
    [~, dictionary] = kmeans(pixelResponses, K, 'EmptyAction', 'drop');
end


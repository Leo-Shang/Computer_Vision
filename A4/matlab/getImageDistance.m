function [dist] = getImageDistance(hist1, hist2, method)
    if strcmp(method, 'euclidean')
        dist = pdist2(hist1, hist2, 'euclidean');
%         temp = sqrt((hist1 - hist2) .^ 2);
%         dist = sum(temp)/size(temp,2);
    elseif strcmp(method, 'chi2')
%         dist = sum(((hist1-hist2).^2) ./ (hist1+hist2))/2;
        dist = distChiSq(hist1, hist2);
    else
        dist = zeros(size(hist1,1), 1);
    end
end

function D = distChiSq( X, Y )
    m = size(X,1);  n = size(Y,1);
    mOnes = ones(1,m); D = zeros(m,n);
    for i=1:n
      yi = Y(i,:);  yiRep = yi( mOnes, : );
      s = yiRep + X;    d = yiRep - X;
      D(:,i) = sum( d.^2 ./ (s+eps), 2 );
    end
    D = D/2;
end

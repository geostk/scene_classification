function histInter = distanceToSet(wordHist, histograms)
% Inputs:
% 	wordHist: visual word histogram - K * (4^(L+1) − 1 / 3) × 1 vector
% 	histograms: matrix containing T features from T training images - K * (4^(L+1) − 1 / 3) × T matrix
% Output:
% 	histInter: histogram intersection similarity between wordHist and each training sample as a 1 × T vector

    nRows = length(wordHist(:,1))
    T = length(histograms(1, :))
    test = repmat(wordHist, 1, T);
    mini = min(test, histograms);
    histInter = sum(mini, 1);
end
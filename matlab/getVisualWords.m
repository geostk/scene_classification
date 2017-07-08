function [wordMap] = getVisualWords(img, filterBank, dictionary)
% Compute visual words mapping for the given image using the dictionary of visual words.

% Inputs:
% 	img: Input RGB image of dimension (h, w, 3)
% 	filterBank: a cell array of N filters
% Output:
%   wordMap: WordMap matrix of same size as the input image (h, w)

    filterResponses = extractFilterResponses(img, filterBank); % #pixels X 3F
    dictionary = dictionary'; % initially, 3F X K
    
    [ x minDist] = pdist2(dictionary, filterResponses, 'euclidean', 'Smallest', 1);
    
    minDist = minDist'; % initially, 1 X #pixels
    size(minDist);
    nRows = length(img(:, 1, 1));
    nCols = length(img(1, :, 1));
    wordMap = reshape(minDist, [nRows, nCols]);
    
    imagesc(wordMap);
end

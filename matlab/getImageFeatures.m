function [h] = getImageFeatures(wordMap, dictionarySize)
% Compute histogram of visual words
% Inputs:
% 	wordMap: WordMap matrix of size (h, w)
% 	dictionarySize: the number of visual words, dictionary size
% Output:
%   h: vector of histogram of visual words of size dictionarySize (l1-normalized, ie. sum(h(:)) == 1)

	% TODO Implement your code here
    nRows = length(wordMap(:,1));
    nCols = length(wordMap(1, :));
    wM = reshape(wordMap, [1, nRows*nCols]);
	h = histogram(wM, dictionarySize, 'Normalization', 'probability');
    h = h.Values;
	assert(numel(h) == dictionarySize);
end
function [h] = getImageFeaturesSPM(layerNum, wordMap, dictionarySize)
% Compute histogram of visual words using SPM method
% Inputs:
%   layerNum: Number of layers (L+1)
%   wordMap: WordMap matrix of size (h, w)
%   dictionarySize: the number of visual words, dictionary size
% Output:
%   h: histogram of visual words of size {dictionarySize * (4^layerNum - 1)/3} (l1-normalized, ie. sum(h(:)) == 1)

    rHi = length(wordMap(:,1));
    cHi = length(wordMap(1,:));
    h = [];
    h = helperSPM(layerNum - 1, 0, wordMap, 1, rHi, 1, cHi, dictionarySize);
    h = h';
end

function [h] = helperSPM(L, curLayer, wordMap, rLo, rHi, cLo, cHi, dictionarySize)
    if (curLayer == 0 | curLayer == 1)
        wt = 2^(-1*L);
    else
        wt = 2^(curLayer - L - 1);
    end

    if curLayer == L % fine grain
       temp = histogram(wordMap(rLo:rHi, cLo:cHi), dictionarySize);
       temp = temp.Values;
       temp = temp/sum(temp);
       temp = wt*temp;
       h = temp;
    else % coarse grain
        % h = [];
        temp1 = helperSPM(L, curLayer + 1, wordMap, rLo, (rLo + rHi)/2, cLo, (cLo + cHi)/2, dictionarySize);
        temp2 = helperSPM(L, curLayer + 1, wordMap, rLo, (rLo + rHi)/2, (cLo + cHi)/2, cHi, dictionarySize);
        temp3 = helperSPM(L, curLayer + 1, wordMap, (rLo + rHi)/2, rHi, cLo, (cLo + cHi)/2, dictionarySize);
        temp4 = helperSPM(L, curLayer + 1, wordMap, (rLo + rHi)/2, rHi, (cLo + cHi)/2, cHi, dictionarySize);
        
        temp5 = temp1(end - dictionarySize + 1: end) + temp2(end - dictionarySize + 1: end)...
            + temp3(end - dictionarySize + 1: end) + temp4(end - dictionarySize + 1: end);
        temp5 = temp5/sum(temp5);
        temp5 = temp5*wt;
        
        h = [temp1 temp2 temp3 temp4 temp5];
    end
end
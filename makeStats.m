function S = makeStats(varin)
% Let's make bins
Nb = 103;
% Bins are logarithmically spaced. Other binning methods can be implemented
% (MATLAB has them already, see 'help histogram')
binEdges = logspace(log10(min(varin.Diameter)),log10(max(varin.Diameter)),Nb);
rawCount = zeros(1,Nb-1);
% sorting is unnecessary
% varin = sortrows(varin,'Diameter','ascend');
for j = 1:Nb-1
    rawCount(j) = length( find(varin.Diameter >= binEdges(j) & varin.Diameter < binEdges(j+1)) );
end

pC = rawCount/sum(rawCount).*100;   % Percentage (number) of each size class wrt total count
cS = cumsum(pC);        % Cumulative sum of the percentages
S = struct('binEdges',binEdges,'count',rawCount,'percCount',pC,'cumPerc',cS);
end

function newHistogram(varin)
% Custom histogram plotting function. Shows pre-binned data from makeStats
% and cumulative percentages of each droplet class.
% Usage:
%   NEWHISTOGRAM(structin)
% where STRUCTIN is the output from MAKESTATS and contains fields:
% * binEdges
% * percCount
% * cumPerc
yyaxis left
histogram('BinEdges',varin.binEdges,'BinCounts',varin.percCount)
set(gca,'XScale',"log")
yyaxis right
stairs(varin.binEdges, [varin.cumPerc varin.cumPerc(end)],'-','LineWidth',1)
end
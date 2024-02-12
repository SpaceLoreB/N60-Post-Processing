function colours = newHistogram(varargin)
% % Custom histogram plotting function. Shows pre-binned data from translateTab and cumulative percentages of each droplet class.
% Usage:
%   NEWHISTOGRAM(structin)

colours = .66.*[
    0    0.4805    0.8906;
    0.9258    0.1992    0.1016;
    0.3922    0.4902    0.5686;
    rand(nargin-3,3)];    % Further colours are randomised

nOpen = length(findobj('type','figure'));

% figure(nOpen+1)
subplot(1,2,1)
yyaxis left
for j = 1:nargin
    histogram('BinEdges',varargin{j}.binEdges,'BinCounts',varargin{j}.percCount,'FaceColor',colours(j,:))
    hold on
end
    ylabel('Drop Size Distribution - % counted')%,'FontSize',fs)
    set(gca,'XScale',"log")

yyaxis right
for j = 1:nargin
    plot(varargin{j}.binCentres, varargin{j}.cumCount,'-','LineWidth',1,'Color',colours(j,:))
    hold on
end
    ylabel('Number Cumulative Distribution [%]')%,'FontSize',fs)
    grid on
xlabel('Droplet Diameter [\mum]')%,'FontSize',fs)
title('Numeric DSD');

% figure(nOpen+2)
subplot(1,2,2)
yyaxis left
for j = 1:nargin
    histogram('BinEdges',varargin{j}.binEdges,'BinCounts',varargin{j}.percVol,'FaceColor',colours(j,:))
    hold on
end
    ylabel('Drop Size Distribution - % volume')%,'FontSize',fs)
    set(gca,'XScale',"log")

yyaxis right
for j = 1:nargin
    plot(varargin{j}.binCentres, varargin{j}.cumVol,'-','LineWidth',1,'Color',colours(j,:))
    hold on
end
    ylabel('Volume Cumulative Distribution [%]')%,'FontSize',fs)
grid on
xlabel('Droplet Diameter [\mum]')%,'FontSize',fs)
title('Volumetric DSD');

end

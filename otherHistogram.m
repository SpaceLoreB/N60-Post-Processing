function colours = otherHist(varargin)
% % Custom histogram plotting function. Plots number- and volume-based
% DSDs and CSDs together. Each argument is plotted separately
% Usage:
%   otherhist(structin)
% where STRUCTIN is the output from MAKESTATS

colours = .66.*[
    0    0.4805    0.8906;
    0.9258    0.1992    0.1016;
    0.3922    0.4902    0.5686;   % info
    0.1020    0.5490    0.3922; % green, ex NaTec
    rand(nargin-2,3)];    % Further colours are randomised

nOpen = length(findobj('type','figure'));

for j = 1:nargin

figure(nOpen+j)
yyaxis left
    histogram('BinEdges',varargin{j}.binEdges,'BinCounts',varargin{j}.percCount,'FaceColor',colours(j,:))
    hold on
    histogram('BinEdges',varargin{j}.binEdges,'BinCounts',varargin{j}.percVol,'FaceColor',colours(j,:))
    legend('Number','Volume')
    ylabel('Frequency [%]')%,'FontSize',fs)
    set(gca,'XScale',"log")
    grid on

yyaxis right
    plot(varargin{j}.binCentres, varargin{j}.cumCount,'-','LineWidth',1,'Color',colours(j,:))
    hold on
    plot(varargin{j}.binCentres, varargin{j}.cumVol,'-','LineWidth',1,'Color',colours(j,:))
    legend('Number','Volume')
    ylabel('Cumulative Distribution [%]')%,'FontSize',fs)
    grid on
xlabel('Droplet Diameter [\mum]')%,'FontSize',fs)
% title('Numeric DSD');

end
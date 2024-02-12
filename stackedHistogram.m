function [ax,colours] = stackedHistogram(varargin)
% % Custom histogram plotting function. Shows pre-binned data from makeStats
% and cumulative percentages of each droplet class.
% Usage:
%   STACKEDHIST(structin)

colours = .66.*[
    0    0.4805    0.8906;
    0.9258    0.1992    0.1016;
    0.3922    0.4902    0.5686;
    rand(nargin-3,3)];    % Further colours are randomised

nOpen = length(findobj('type','figure'));
% 
% figure(nOpen+1)
% for j = 1:nargin
% ax(j) = subplot(3,1,j);
%     histogram('BinEdges',varargin{j}.binEdges,'BinCounts',varargin{j}.percCount,'FaceColor',colours(j,:))
%     grid on
% end
% 
% linkaxes([ax(1), ax(2), ax(3)],'x')


figure(nOpen+1)
p = [1,3,5];
tits = ["Test A", "Test B", "Test C"];

for j = 1:3
    ax(j) = subplot(3,2,p(j));
    histogram('BinEdges',varargin{j}.binEdges,'BinCounts',varargin{j}.percCount,'FaceColor',colours(j,:))
    ylabel('% num')
    xlabel('Droplet Diameter [\mum]')
    title(tits(j))
    grid on
    ax(j+3) = subplot(3,2,p(j)+1);
    histogram('BinEdges',varargin{j}.binEdges,'BinCounts',varargin{j}.percVol,'FaceColor',colours(j,:))
    ylabel('% vol')
    xlabel('Droplet Diameter [\mum]')
    title(tits(j))
    grid on
end

linkaxes([ax(1),ax(2),ax(3)],'x')
linkaxes([ax(4),ax(5),ax(6)],'x')

% 
% yyaxis left
% for j = 1:nargin
%     histogram('BinEdges',varargin{j}.binEdges,'BinCounts',varargin{j}.percCount,'FaceColor',colours(j,:))
%     hold on
% end
%     ylabel('Drop Size Distribution - % counted')%,'FontSize',fs)
%     set(gca,'XScale',"log")
% 
% yyaxis right
% for j = 1:nargin
%     plot(varargin{j}.binCentres, varargin{j}.cumCount,'-','LineWidth',1,'Color',colours(j,:))
%     hold on
% end
%     ylabel('Number Cumulative Distribution [%]')%,'FontSize',fs)
%     grid on
% xlabel('Droplet Diameter [\mum]')%,'FontSize',fs)
% title('Numeric DSD');
% 
% figure(nOpen+2)
% yyaxis left
% for j = 1:nargin
%     histogram('BinEdges',varargin{j}.binEdges,'BinCounts',varargin{j}.percVol,'FaceColor',colours(j,:))
%     hold on
% end
%     ylabel('Drop Size Distribution - % volume')%,'FontSize',fs)
%     set(gca,'XScale',"log")
% 
% yyaxis right
% for j = 1:nargin
%     plot(varargin{j}.binCentres, varargin{j}.cumVol,'-','LineWidth',1,'Color',colours(j,:))
%     hold on
% end
%     ylabel('Volume Cumulative Distribution [%]')%,'FontSize',fs)
% grid on
% xlabel('Droplet Diameter [\mum]')%,'FontSize',fs)
% title('Volumetric DSD');

end

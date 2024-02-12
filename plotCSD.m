function plotCSD(varargin)

colours = .66.*[
    0    0.4805    0.8906;
    0.9258    0.1992    0.1016;
    0.3922    0.4902    0.5686;   % info
    0.1020    0.5490    0.3922; % green, ex NaTec
    rand(nargin-3,3)];    % Further colours are randomised

% figure(1)
% for j = 1:nargin
%     plot(varargin{j}.binCentres, varargin{j}.cumCount,'-','LineWidth',2,'Color',colours(j,:))
%     hold on
% end
%     ylabel('Number Cumulative Distribution [%]')%,'FontSize',fs)
%     grid on
% xlabel('Droplet Diameter [\mum]')%,'FontSize',fs)
% title('Numeric DSD');
% % 
figure(2)
for j = 1:nargin
    plot(varargin{j}.binCentres, varargin{j}.cumVol,'-','LineWidth',2,'Color',colours(j,:))
    hold on
    plot(varargin{j}.dVxx,[10 50 90],'o','Color',colours(j,:),'HandleVisibility','off','LineWidth',1,'MarkerSize',8)
end
    ylabel('Volume Cumulative Distribution [%]')%,'FontSize',fs)
grid minor
xlabel('Droplet Diameter [\mum]')%,'FontSize',fs)
title('Volumetric DSD');

end
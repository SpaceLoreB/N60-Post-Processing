function out = translateTab(in)
% Get edges of bins
% Use:
% % HC = translateTab(TXBtot);

binEdges = [in.bin1; in.bin2(end)]';
% Centres of the bins for the cumulative curves
binCentres = movsum(binEdges,2,"Endpoints","discard")./2;

out = struct('binEdges',binEdges,'binCentres',binCentres, ...
    'percCount',in.NUMBER','cumCount',cumsum(in.NUMBER'), ...
    'percVol',in.VOLUME','cumVol',in.CUMVOL', ...
    'dVxx',[interpolateX(10,binCentres,in.CUMVOL) interpolateX(50,binCentres,in.CUMVOL) interpolateX(90,binCentres,in.CUMVOL)], ...
    'V100',interpolateX(100,in.CUMVOL,binCentres) );
end
    % 'dNxx',[interpolateX(10,binCentres,cumCount) interpolateX(50,binCentres,cumCount) interpolateX(90,binCentres,cumCount)], ...

function dVx = interpolateX(Y,ascissa,ordinata)
I = find(ordinata(ordinata < Y),1,'last');
dVx = ascissa(I) + ( Y - ordinata(I) )*( ascissa(I+1) - ascissa(I) )/( ordinata(I+1) - ordinata(I) );
end
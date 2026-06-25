function out = processRaw(in)
% Process the raw table from the N60 into a MATLAB Table that can be worked
% with. Some relevant results are (re)calculated, such as:
%   - cumulative percentage (number- and volume-based) vectors;
%   - volume percentiles dVx;
%   - the volume fractions Vy are included, but so far commented out due to
%   robustness concerns. See for yourself if you need them.
% How to use:
%   nozzleData = processRaw( inputTable );
%
% Built by SpaceLoreB
binEdges = [in.bin1; in.bin2(end)]';
% Centres of the bins for the cumulative curves
binCentres = movsum(binEdges,2,"Endpoints","discard")./2;

out = struct('binEdges',binEdges,'binCentres',binCentres, ...
    'percCount',in.NUMBER','cumCount',cumsum(in.NUMBER'), ...
    'percVol',in.VOLUME','cumVol',in.CUMVOL', ...
    'dVxx',[interpolateX(10,binCentres,in.CUMVOL) interpolateX(50,binCentres,in.CUMVOL) interpolateX(90,binCentres,in.CUMVOL)] );%, ...
    % 'Vyy',[interpolateX(100,in.CUMVOL,binCentres) interpolateX(200,in.CUMVOL,binCentres)], ...
    % 'yy', [100,200] );  % which fractions are being saved?
end
    % 'dNxx',[interpolateX(10,binCentres,cumCount) interpolateX(50,binCentres,cumCount) interpolateX(90,binCentres,cumCount)], ...

function dVx = interpolateX(Y,ascissa,ordinata)
I = find(ordinata(ordinata < Y),1,'last');
dVx = ascissa(I) + ( Y - ordinata(I) )*( ascissa(I+1) - ascissa(I) )/( ordinata(I+1) - ordinata(I) );
end
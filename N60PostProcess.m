%% MAIN N60 POST-PROCESSING SCRIPT
% Lorenzo Becce, 04.02.2022
% This is the main file where we (io e chi?) will gather and compare result
% files for different nozzles. We will chiefly fit distributions and create
% figures.
% It will likely evolve into a live script to export processed data into LaTeX for publication.
% We will make the most use of functions for code modularity and reusability.

%% IMPORT DATA
filename = input('Open file: ', 's');
test = importVSP(filename);

%% Get statistics
DQ = getQuartiles(test)
AVG = makeAvgs(test)

%% TEMPORARY
pD = fitdist(test.Diameter,'lognormal');
base = linspace(min(test.Diameter),max(test.Diameter),1e4);
plot(base,pD.cdf(base));
    
%% FUNCTIONS
function quart = getQuartiles(T)
    quart = double.empty(3,0);
    pD = fitdist(T.Diameter,'lognormal');
    base = linspace(min(T.Diameter),max(T.Diameter),1e4);
    cD = pD.cdf(base);
    
    % Dv90
    I = find(cD < 0.9, 1, 'last');
    quart.Dv90 = mean(base(I:I+1));
    % Dv50
    I = find(cD < 0.5, 1, 'last');
    quart.Dv50 = mean(base(I:I+1));
    I = find(cD < 0.1, 1, 'last');
    % J = find(cD > 0.1,1);
    quart.Dv10 = mean(base(I:I+1));
end

function avgs = makeAvgs(test00)
% makes averages
    avgs = double.empty(0,5);
    avgs.Arithmetic = mean(test00.Diameter);
    avgs.Surface = sqrt(mean(test00.Diameter.^2));
    avgs.Volume = (mean(test00.Diameter.^3))^(1/3);
    avgs.Sauter = sum(test00.Diameter.^3)/sum(test00.Diameter.^2);
    avgs.Sample = max(test00.Diameter)^3/sum(test00.Diameter.^2);
end
%% MAIN N60 POST-PROCESSING SCRIPT
% Lorenzo Becce, 04.02.2022
% This is the main file where we (io e chi?) will gather and compare result
% files for different nozzles. We will chiefly fit distributions and create
% figures.
% It will likely evolve into a live script to export processed data into LaTeX for publication.
% We will make the most use of functions for code modularity and reusability.
%
% Lorenzo Becce, 09.2023
% % This script automates the reading of text report files from all the
% subfolders. It gives some basic error message when reading fails, but
% make sure to have all the subfolders set correctly.
% % TO DO!:
%   * turn regexp parsing from scanReport into a function
%   * adjust and enrich documentation
%   * make it a bit more user-friendly

%% IMPORT DATA
clearvars
clc

% % A .mat file will be saved after importing. Enter a name for the file.
outFilename = 'prove';
% % Enter here the path of the (sub)folder where you stored the txt files.
mfi = dir('C:\Users\LBecce\Desktop\N60 ripresi sett23\commitFeb24\N60pp\sampleData/*.txt');      %  get all txt files in subdirectories
mfi = {mfi.name};           % save only names

% % Importing the data.
tstart = tic;
% errCount = 0;
names = cell(length(mfi),1);
for i = 1:length(mfi)
    [errMsg, names{i}] = scanReportExt(mfi{i});
    fprintf('%s for file %s\n',errMsg,mfi{i});
end
tElapsed = toc(tstart);
fprintf('\n%i files have been parsed in %4.2f s.\n',length(mfi),tElapsed);

% % Timestamping and saving
% t = datetime('now','Format','yyyy_MM_dd-hh_mm');
saveFileName = sprintf('%s_%s_raw',string(datetime('now','Format','yyyy_MM_dd-hh_mm')),outFilename);
save(saveFileName,names{1:end})

clear errMsg i tstart saveFileName %outFilename

%% %% Processing all the datasets
% if files are already loaded, process them
for k = 1 : length(names)
  F = names{k};
  assignin('base',F,translateTab(evalin('base',F)));
end

% % If you need to load a previously saved file, uncomment the next lines and comment the previous 
% names = load('sampleData/2024_02_08-07_05_prove.mat');
% % get names
% fn = fieldnames(names);
% Fc = length(fn);
% for k = 1 : Fc
%   F = fn{k}
%   % % https://it.mathworks.com/matlabcentral/answers/471356-how-to-post-process-each-variable-in-a-mat-file
%   % S.(F) = renamevars(S.(F),1:width(S.(F)),newNames);
%   names.(F) = translateTab(names.(F));
% end

% % Save the newly modified variables
saveFileName = sprintf('%s_%s_processed',string(datetime('now','Format','yyyy_MM_dd-hh_mm')),outFilename);
save(saveFileName,names{1:end})

clear k Fc F

%% FROM NOW ON...
% ...Proceed as needed. You can plot using one of the custom plotting functions. Each
% can be fed any number of arguments. 
% * newHistrogram() plots number- and volume-based histograms with
% cumulative curves on two figures. Arguments are plotted on top of each
% other.
% * plotCSD() plots the cumulative curves (number- or volume-based) , without the bins
% * otherHistogram() plots cumulative and histograms of each argument,
% separately
% * stackedHistogram() plots up to three separate arguments in pretty much
% the same way as newHistogram(). Will likely get removed at some point.

%% FUNCTIONS DECLARATION
function [errMsg, varName] = scanReportExt(fname)
% Script for importing data from the following text file:
% Auto-generated by MATLAB on 06-Sep-2023
% Converted and extended by L.B. on 18-dec-2023 and many other times

errMsg = "ok";

% % Parsing report for variables to make var name
raw = fileread(fname);
% Reads pressures from report
nzID = regexp(raw, '(?<="Nozzle ID"\s*)[^\n\r]*', 'match', 'once');
nzSp = regexp(raw, '(?<="Nozzle specimen"\s*)[^\n\r]*', 'match', 'once');
% Checking fro robustness
if (isempty(nzID) || isempty(nzSp))
    errMsg = 'Empty header';
    return
end
nzID = regexp(nzID,'\w*','match');
nzSp = regexp(nzSp,'\w*','match');
% make varName
varName = sprintf('%s_%s',nzID{1},nzSp{1});

% % Actual file import
% % Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 9);
% Specify range and delimiter

% % Find the start of the results table (changes depending on user-defined
% parameters)
A = regexp(raw,'\n','split');
lineStart = find(contains(A,'DIAMETER'))+1;

opts.DataLines = [lineStart, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["bin1", "bin2", "RAWCOUNT", "PROBEVOLUME", "NUMBER", "AREA", "VOLUME", "CUMVOL"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts.ConsecutiveDelimitersRule = "join";

% Specify variable properties
% opts = setvaropts(opts, ["NUMBER", "AREA", "VOLUME", "CUMVOL", "AVSPDms"], "TrimNonNumeric", true);
% opts = setvaropts(opts, ["bin1", "bin2", "RAWCOUNT", "PROBEVOLUME", "NUMBER", "AREA", "VOLUME", "CUMVOL"], "TrimNonNumeric", true);
opts = setvaropts(opts, ["bin1", "bin2", "RAWCOUNT", "PROBEVOLUME", "NUMBER", "AREA", "VOLUME", "CUMVOL"], "ThousandsSeparator", ",");

% Import the data
report = readtable(fname, opts);

% Cleaning in case there are NaN
checkNaN = find(isnan(report.bin1(:,1)),1);
if ~isempty(checkNaN)
report = report(1:checkNaN-1,:);
end

assignin('base',varName,report);

% Clear temporary variables
clear opts checkNaN

end

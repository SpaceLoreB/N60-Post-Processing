function [test00] = importVSP(filename)
%IMPORTVSP Import data from a text file
%  TEST00 = IMPORTVSP(FILENAME) reads data from text file FILENAME for
%  the default selection.  Returns the data as a table.
%
%  Example:
%  test00 = IMPORTVSP("C:\Users\LBecce\OneDrive - Scientific Network South Tyrol\ProveN60\scripts\dati\test00.txt");
%
% Auto-generated by MATLAB and edited by Lorenzo Becce on 04-Feb-2022

%% Set up the Import Options and import the data
    opts = delimitedTextImportOptions("NumVariables", 6);
    % Specify range and delimiter
    opts.DataLines = [10, Inf];
    opts.Delimiter = "\t";
    % Specify column names and types
    opts.VariableNames = ["Frame", "ParticleID", "Diameter", "Velocity", "Angle", "ShapeFactor"];
    opts.VariableTypes = ["double", "double", "double", "double", "double", "double"];
    % Specify file level properties
    opts.ExtraColumnsRule = "ignore";
    opts.EmptyLineRule = "read";
    % Import the data
    test00 = readtable(filename, opts);

    if nargout == 0
        name = input('Enter variable name: ', 's');
%         name = filename;
        assignin('base',name,test00);
        disp(sprintf('Saved data in variable %s',name));
    end
end
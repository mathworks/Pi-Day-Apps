function [data_OUT] = load_data()
%% Load and return data

persistent data;
% addpath C:\work\EXPO\MATLAB_APPS\PISearch\data;
% addpath PISearch\data;
if isempty(data)
    
    % Load MAT-file in my_struct variable
    my_struct=load('digits_results');
    
    % Extract data from results field of my_struct
    data = my_struct.results;
    
    % Ensure to free memory with clear
    clear my_struct

end

data_OUT = data;

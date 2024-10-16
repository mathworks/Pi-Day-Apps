function [start_pos,end_pos,nb] = find_string_position(str2find)
%% Find all occurrences position of str2find (entered by user) in 200 000 000 first decimals of PI

pi_str = load_data();

% Parameter: number of characters that are saved in each part of pi_str
PART_LENGTH = length(pi_str{1});

%% Find all occurrences of str2find in pi_str

% First look in each part of pi_str separatly
% -------------------------------------------
start_pos = arrayfun(@(x) (x-1)*PART_LENGTH+regexp(pi_str{x},str2find), 1:length(pi_str), 'UniformOutput', false);
start_pos = [start_pos{:}];

% Look in junction of each parts of pi_str
% ----------------------------------------
% Define starting and ending point of each part to make join
relative_start_idx = PART_LENGTH - length(str2find) + 2;
relative_end_idx = length(str2find) - 1;

if length(pi_str) > 1
    
    % Create a cell array with all junctions of parts of PI decimals
    part_join_str = cellfun(@(x,y) [x(relative_start_idx:end) y(1:relative_end_idx)], pi_str(1:end-1), pi_str(2:end), 'UniformOutput', false);
    
    % Find string occurence in join
    part_join_pos = cellfun(@(x,y) (y-1)*10e6 + (relative_start_idx-1) + regexp(x,str2find), part_join_str, num2cell(1:length(pi_str)-1)', 'UniformOutput', false);
    part_join_pos = [part_join_pos{:}];
    
    % Add finding position in list of all position (use UNIQUE to sort data in ascending order)
    start_pos = unique([start_pos part_join_pos]);
    
end

% Calculate end position of string
end_pos = start_pos + length(str2find) - 1;

% Convert data type
start_pos = int32(start_pos);
end_pos = int32(end_pos);

nb = int32(length(start_pos));

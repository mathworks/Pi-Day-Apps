function [str] = get_string_at_position(idx_start, idx_end)
%%

try
    pi_str = load_data();
        
    % Parameter: number of characters that are saved in each part of pi_str
    PART_LENGTH = length(pi_str{1});
    
    idx = double(max(idx_start,1):min(idx_end,PART_LENGTH*length(pi_str)));
    
    if isempty(idx)
        
        % In specific case of empty IDx (for first values), return empty string
        str = '';
        
    else
        
        % Find cell which contains data corresponding to each indexes (first
        % and last)
        idx_cell_start = ceil(idx(1)/PART_LENGTH);
        idx_cell_end = ceil(idx(end)/PART_LENGTH);
        
        % In most of cases, it is the same cell that contains all data to
        % display so idx_cell_start == idx_cell_end
        if (idx_cell_start == idx_cell_end)
            
            idx = idx - (idx_cell_start-1)*PART_LENGTH;
            str = pi_str{idx_cell_start}(idx(idx > 0 & idx <= PART_LENGTH));
            
        else
            
            % When string is split between 2 cells, concatenate part from each cells.
            % Use MAX and MIN to ensure that indexes are not greater than upper
            % limit or under 1.
            % UNIQUE is used to avoid index repetition due to MAX/MIN
            idx1 = idx - (idx_cell_start-1)*PART_LENGTH;
            idx2 = idx - (idx_cell_end-1)*PART_LENGTH;
            
            str = [pi_str{idx_cell_start}(idx1(idx1 > 0 & idx1 <= PART_LENGTH)) ...
                pi_str{idx_cell_end}(idx1(idx2 > 0 & idx2 <= PART_LENGTH))];
            
        end
        
    end
    
catch me
    
    save('C:\Temp\error.mat')
    
    rethrow(me)
    
end
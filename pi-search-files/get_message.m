function [msg,is_found] = get_message(id,lang)
%% Get message corresponding to ID in selected language

% Initialize output message with ID, this value will be replaced if a
% corresponding message is found in associated text file
msg = id;
is_found = false;

% Open file which contains messages
fid = fopen(['msg_' lang '.txt']);

if (fid > 0)
   
    % Read data in file
    data = textscan(fid, '%s%s', 'Delimiter', '=', 'CommentStyle', '#');
    
    % Close file
    fclose(fid);
    
    % If ID is found in data, set message to string found in text file
    if any(strcmpi(data{1}, id))
        msg = data{2}{strcmpi(data{1}, id)};
        is_found = true;
    end
    
end


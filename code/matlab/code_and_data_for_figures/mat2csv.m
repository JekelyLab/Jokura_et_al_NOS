function mat2csv(in_filename, out_filename, start_from)
    % Check if 'start_from' was provided; if not, default to 1
    if nargin < 3 || isempty(start_from)
        start_from = 1;
    end

    % Verify the file exists before proceeding
    if ~isfile(in_filename)
        error('The file "%s" could not be found.', in_filename);
    end
    
    
    % Load the contents of the .mat file into a structure array
    matData = load(in_filename);
    
    % Get the names of all variables/structures stored in the file
    varNames = fieldnames(matData);
    
    % Loop through each variable and export it to a separate CSV
    for i = 1:length(varNames)
        % Calculate the current file number
        fileNumber = start_from + i - 1;

        % Generate the output filename (e.g., "myoutput1.csv")
        csvFilename = sprintf('%s%d.csv', out_filename, fileNumber);
        
        % Extract the data for the current variable
        currentData = matData.(varNames{i});
        
        try
            % Export based on the data type
            if istable(currentData)
                writetable(currentData, csvFilename);
                
            elseif isnumeric(currentData) || islogical(currentData) || isstring(currentData)
                writematrix(currentData, csvFilename);
                
            elseif iscell(currentData)
                writecell(currentData, csvFilename);
                
            elseif isstruct(currentData)
                % Attempt to convert flat structures into a table format for CSV
                structAsTable = struct2table(currentData, 'AsArray', true);
                writetable(structAsTable, csvFilename);
                
            else
                warning('Variable "%s" (type %s) cannot be easily written to CSV. Skipping.', ...
                    varNames{i}, class(currentData));
                continue;
            end
            
            fprintf('Saved variable "%s" to %s\n', varNames{i}, csvFilename);
            
        catch ME
            warning('Could not save variable "%s" to CSV. Reason: %s', varNames{i}, ME.message);
        end
    end
end
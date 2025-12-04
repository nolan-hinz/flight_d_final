function T = read_data(filename)
% READXPLANELOG  Load X-Plane style telemetry file into a MATLAB table.
%
%   T = readXPlaneLog(filename)
%
% The function:
%   - Reads all lines
%   - Detects the last (most complete) header row
%   - Cleans header names to valid MATLAB identifiers
%   - Reads the remainder of the file into a numeric table

    % --- Read entire file ---
    fid = fopen(filename,'r');
    raw = textscan(fid, '%s', 'Delimiter', '\n', 'Whitespace','');
    fclose(fid);
    raw = raw{1};

    % --- Detect header lines (contain many commas, no numbers) ---
    isHeader = cellfun(@(s) isempty(regexp(s, '\d', 'once')), raw) & ...
               contains(raw, ',');
    headerLines = raw(isHeader);

    if isempty(headerLines)
        error('No header lines detected.');
    end

    % --- Use the LAST (most complete) header line ---
    headerLine = headerLines{end};

    % --- Split header into names ---
    headers = strtrim(strsplit(headerLine, ','));

    % --- Clean MATLAB variable names ---
    headers = matlab.lang.makeValidName(headers, 'ReplacementStyle','delete');

    % --- Find the first numeric data line ---
    firstDataIdx = find(~isHeader, 1, 'first');

    % --- Create a temporary file with cleaned header + data ---
    tempFile = [tempname '.csv'];
    fid = fopen(tempFile,'w');
    fprintf(fid, '%s\n', strjoin(headers, ','));

    % Write all remaining lines starting from first data line
    for i = firstDataIdx:length(raw)
        fprintf(fid, '%s\n', raw{i});
    end

    fclose(fid);

    % --- Read table normally ---
    T = readtable(tempFile);

    % Clean up
    delete(tempFile);
end
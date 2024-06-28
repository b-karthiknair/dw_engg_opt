function edit = edit_file(file_name,xf,yf,thetaf,va,wa);

% File name of the script to be modified
fileName = file_name;

% Read the content of the file into a cell array of strings
fileContent = fileread(fileName);
lines = strsplit(fileContent, '\n');

c = 0;
% Modify the desired line
for i = 1:length(lines)
    if contains(lines{i}, 'xi =')
        lines{i} = sprintf('xi = %d;', xf);
        c = c+1;
    end
    if contains(lines{i}, 'yi =')
        lines{i} = sprintf('yi = %d;', yf);
        c = c+1;
    end
    if contains(lines{i}, 'thetai =')
        lines{i} = sprintf('thetai = %d;', thetaf);
        c = c+1;
    end
    if contains(lines{i}, 'va =')
        lines{i} = sprintf('va = %d;', va);
        c = c+1;
    end
    if contains(lines{i}, 'wa =')
        lines{i} = sprintf('wa = %d;', wa);
        c = c+1;
    end
    if c == 5
        break;
    end
end

% Write the modified content back to the file
fid = fopen(fileName, 'w');
fprintf(fid, '%s\n', lines{:});
fclose(fid);

disp('Script has been updated.');
edit = 1;

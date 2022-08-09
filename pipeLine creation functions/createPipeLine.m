function [status] = createPipeLine(path_pipeLine)
%creates an initial pipeLine in the location path_pipeLine;
fid = fopen(path_pipeLine,'w');
if fid > 0
    % Create a new workspace (File|New).
    fprintf(fid,'File_New\r\n');
    fprintf(fid,';\r\n');
    fprintf(fid,'\r\n');
    % end addition
    status = fclose(fid);
else
    status = -1;
    disp(['Error Creating pipeline file']);
end
end
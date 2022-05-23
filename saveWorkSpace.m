function saveWorkSpace(path_pipeLine,varargin)
%save workspace
p = inputParser;
addOptional(p,'path','');
parse(p,varargin{:});
workSpacepath = p.Results.path;
fid = fopen(path_pipeLine,'a');
if fid > 0
    % Create a new workspace (File|New).
    fprintf(fid,'File_Save_As\r\n');
    if ~strcmp(workSpacepath,'')
        fprintf(fid,'/FILE_NAME=%s\r\n',workSpacepath);
    end
    fprintf(fid,';\r\n');
    fprintf(fid,'\r\n');
    % end addition
    status = fclose(fid);
else
    status = -1;
    disp(['Error Saving']);
end
%recalc(path_pipeLine)
end
function Open_File(path_pipeLine, varargin)
p = inputParser;
addOptional(p,'path_motion','');
parse(p,varargin{:});
path_motion = p.Results.path_motion;

%add motion to analyze
fid = fopen(path_pipeLine,'a');
if fid > 0
    % Insert a motion file (File|Open).
    fprintf(fid,'Open_File\r\n');
    if ~strcmp(path_motion,'')
        fprintf(fid,'/FILE_NAME=%s\r\n',path_motion);
    else
        fprintf(fid,'! /FILE_NAME=%s\r\n',[]);
    end
    fprintf(fid,';\r\n');
    fprintf(fid,'\r\n');
    
    status = fclose(fid);
else
    status = -1;
    disp(['Error adding motion file']);
end
function addMotion(path_pipeLine, varargin)
p = inputParser;
addOptional(p,'path_motion','');
addOptional(p,'modelName','');
addOptional(p,'Assign_Model_File',true);
parse(p,varargin{:});
path_motion = p.Results.path_motion;
modelName = p.Results.modelName;
Assign_Model_File = p.Results.Assign_Model_File;

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

    % Assign the model to the motion file (Model|Assign Model to Motion
    % files).
    if Assign_Model_File == true
        fprintf(fid,'Assign_Model_File\r\n');
        if strcmp(modelName,'')
            fprintf(fid,'! /CALIBRATION_FILE=%s\r\n',[path_motion]);
        else
            fprintf(fid,'/CALIBRATION_FILE=%s\r\n',[modelName]);
        end
        if ~strcmp(path_motion,'')
            fprintf(fid,'/MOTION_FILE_NAMES=%s\r\n',[path_motion]);
        else
            fprintf(fid,'! /MOTION_FILE_NAMES=%s\r\n',[path_motion]);
        end
        fprintf(fid,'! /REMOVE_EXISTING_ASSIGNMENTS=%s\r\n',['FALSE']);
        fprintf(fid,';\r\n');
        fprintf(fid,'\r\n');
    end
    status = fclose(fid);
else
    status = -1;
    disp(['Error adding motion file']);
end
end

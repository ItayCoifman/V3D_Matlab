function scaleModel(path_pipeLine,varargin)
% add to the V3D pipeline model scaling
% inputs - path_pipeLine
% optional inputs - if not inputed a prompt will appear on V3D
%path_pipeLine
%path_staticTrial
%subjectMass
%subjectHeight
p = inputParser;
addOptional(p,'path_GenericModel','');
addOptional(p,'path_staticTrial','');
addOptional(p,'subjectMass','');
addOptional(p,'subjectHeight','');

parse(p,varargin{:});

path_GenericModel =p.Results.path_GenericModel;
path_staticTrial =p.Results.path_staticTrial;

subjectMass = p.Results.subjectMass;
subjectHeight =p.Results.subjectHeight;

if isnumeric(subjectMass)
    subjectMass = num2str(subjectMass);
end
if isnumeric(subjectHeight)
    subjectHeight = num2str(subjectHeight);
end

%

fid = fopen(path_pipeLine,'a');
if fid > 0
    % Create a hybrid model (Model|Create|Hybrid Model from C3DFile).
    fprintf(fid,'Create_Hybrid_Model\r\n');
    fprintf(fid,'/CALIBRATION_FILE=%s\r\n',[path_staticTrial]);
    % here is optional to set range in the static file at the future
    fprintf(fid,'! /RANGE=ALL_FRAMES\r\n');
    fprintf(fid,';\r\n');
    fprintf(fid,'\r\n');

        % add weight
    fprintf(fid,'Set_Subject_Weight\r\n');
    fprintf(fid,'! /CALIBRATION_FILE=%s\r\n',[path_staticTrial]);
    fprintf(fid,'/WEIGHT=%s\r\n',[subjectMass]);
    fprintf(fid,';\r\n');
    fprintf(fid,'\r\n');

    % add height
    fprintf(fid,'Set_Subject_Height\r\n');
    fprintf(fid,'! /CALIBRATION_FILE=%s\r\n',[path_staticTrial]);
    fprintf(fid,'/HEIGHT=%s\r\n',[subjectHeight]);
    fprintf(fid,';\r\n');
    fprintf(fid,'\r\n');

    % Apply a model template (Model|Apply Model Template).
    fprintf(fid,'Apply_Model_Template\r\n');
    fprintf(fid,'/MODEL_TEMPLATE=%s\r\n',[path_GenericModel]);
    fprintf(fid,'/CALIBRATION_FILE=%s\r\n',[path_staticTrial]);
    fprintf(fid,';\r\n');
    fprintf(fid,'\r\n');



    % Build model
    fprintf(fid,'Build_Model\r\n');
    fprintf(fid,'/CALIBRATION_FILE=%s\r\n',[path_staticTrial]);
    fprintf(fid,'! /REBUILD_ALL_MODELS=FALSE\r\n');
    fprintf(fid,';\r\n');
    fprintf(fid,'\r\n');

    status = fclose(fid);
else
    status = -1;
    disp(['Error adding scaling to the pipeline file']);
end
end
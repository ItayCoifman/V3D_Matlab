
function calculateJoint(path_pipeLine, functionName, jointName, varargin)
%optional functionNames 'JOINT_ANGLE','JOINT_MOMENT','JOINT_POWER','JOINT_VELOCITY'
%optional joints 'hip','knee','ankle'
%optional inputs:
%'resultName' output variable name
%'direction' defults 'R', for left side calcultions use 'L'

p = inputParser;
addOptional(p,'resultName','');
addOptional(p,'direction','R');
parse(p,varargin{:});
resultName = p.Results.resultName;
if strcmp(resultName,'')
    resultName = [jointName '_' extractAfter(functionName,'_')];
end
%if ~strcmp(functionName,'JOINT_VELOCITY')
    switch jointName
        case 'hip'
            segment = 'RTH';
            REFERENCE_SEGMENT = 'RPV';
            %RESOLUTION_COORDINATE_SYSTEM = ;
        case 'knee'
            segment = 'RSK';
            REFERENCE_SEGMENT = 'RTH';
            %RESOLUTION_COORDINATE_SYSTEM = ;
        case 'ankle'
            segment = 'RFT';
            REFERENCE_SEGMENT = 'RSK';
            %RESOLUTION_COORDINATE_SYSTEM = ;
    end
    RESOLUTION_COORDINATE_SYSTEM ='';
    if strcmp(functionName,'JOINT_MOMENT')
        RESOLUTION_COORDINATE_SYSTEM = REFERENCE_SEGMENT;
        REFERENCE_SEGMENT = '';
    end
    %{
else
    switch jointName
        case 'hip'
            segment = 'RTH';
            REFERENCE_SEGMENT = 'RPV';
            %RESOLUTION_COORDINATE_SYSTEM = ;
        case 'knee'
            segment = 'RSK';
            REFERENCE_SEGMENT = 'RSK';
            %RESOLUTION_COORDINATE_SYSTEM = ;
        case 'ankle'
            segment = 'RFT';
            REFERENCE_SEGMENT = 'RTH';
            %RESOLUTION_COORDINATE_SYSTEM = ;
    end
    %}
%end
if strcmp(p.Results.direction,'L')
    segment(1)='L';
    REFERENCE_SEGMENT(1)='L';
end


fid = fopen(path_pipeLine,'a');
if fid > 0
    fprintf(fid,'Compute_Model_Based_Data\r\n');
    fprintf(fid,'/RESULT_NAME=%s\r\n',[resultName]);
    fprintf(fid,'/FUNCTION=%s\r\n',[functionName]);
    fprintf(fid,'/SEGMENT=%s\r\n',[segment]);
    fprintf(fid,'/REFERENCE_SEGMENT=%s\r\n',[REFERENCE_SEGMENT]);
    fprintf(fid,'/RESOLUTION_COORDINATE_SYSTEM=%s\r\n',[RESOLUTION_COORDINATE_SYSTEM]);
    fprintf(fid,'! /USE_CARDAN_SEQUENCE=%s\r\n',['FALSE']);
    fprintf(fid,'! /NORMALIZATION=%s\r\n',['FALSE']);
    fprintf(fid,'/NORMALIZATION_METHOD=%s\r\n',['TRUE']);
    fprintf(fid,'! /NORMALIZATION_METRIC=%s\r\n',['']);
    fprintf(fid,'! /NEGATEX=%s\r\n',['FALSE']);
    fprintf(fid,'! /NEGATEY=%s\r\n',['FALSE']);
    fprintf(fid,'! /NEGATEXZ=%s\r\n',['FALSE']);
    fprintf(fid,'! /AXIS1=%s\r\n',['X']);
    fprintf(fid,'! /AXIS2=%s\r\n',['Y']);
    fprintf(fid,'! /AXIS3=%s\r\n',['Z']);
    fprintf(fid,';\r\n');
    fprintf(fid,'\r\n');
    status = fclose(fid);
else
    status = -1;
    disp(['Error Creating pipeline file']);
end
end
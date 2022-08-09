function changeMetric(path_pipeLine,METRIC_NAME,METRIC_VALUE,varargin)
% Change excisting metric in the model
% inputs:
%path_pipeLine
%METRIC_NAME - metric name as specified at V3D
%METRIC_VALUE -the numeric\ cacultion of the new value
% optional inputs
%recalc
p = inputParser;
addOptional(p,'recalc',true);
addOptional(p,'modelName','');
parse(p,varargin{:});
%path_GenericModel =p.Results.path_GenericModel;
if isnumeric(METRIC_VALUE)
    METRIC_VALUE = num2str(METRIC_VALUE);
end
fid = fopen(path_pipeLine,'a');
if fid > 0
    % Create a hybrid model (Model|Create|Hybrid Model from C3DFile).
    fprintf(fid,'Set_Model_Metric\r\n');
    fprintf(fid,'/CALIBRATION_FILE=%s\r\n',[p.Results.modelName]);
    % here is optional to set range in the static file at the future
    fprintf(fid,['/METRIC_NAME=' [METRIC_NAME] '\r\n']);
    fprintf(fid,['/METRIC_VALUE=' [METRIC_VALUE] '\r\n']);
    fprintf(fid,';\r\n');
    fprintf(fid,'\r\n');
    if p.Results.recalc
        %recalc
        fprintf(fid,'Recalc\r\n');
        fprintf(fid,';\r\n');
        fprintf(fid,'\r\n');
    end
    status = fclose(fid);

else
    status = -1;
    disp(['Error adding scaling to the pipeline file']);
end


end
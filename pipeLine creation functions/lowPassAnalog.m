
function lowPassAnalog(path_pipeLine,varargin)
p = inputParser;
addOptional(p,'cutoff',20);
addOptional(p,'recalc',true);

parse(p,varargin{:});
cutoff =  p.Results.cutoff;

fid = fopen(path_pipeLine,'a');
if fid > 0
    fprintf(fid,'Select_Active_File\r\n');
    fprintf(fid,'/FILE_NAME=%s\r\n',['ALL_FILES']);
    fprintf(fid,';\r\n');
    fprintf(fid,'\r\n');
    %low pass filter
    fprintf(fid,'Lowpass_Filter\r\n');
    fprintf(fid,'/SIGNAL_TYPES=%s\r\n',['ANALOG']);
    fprintf(fid,'! /SIGNAL_FOLDER=%s\r\n',['ORIGINAL']);
    fprintf(fid,'! /SIGNAL_NAMES=%s\r\n',['LFx2+RFx2+LFy2+RFy2+LFz2+RFz2+LMx2+RMx2+LMy2+RMy2+LMz2+RMz2']);
    fprintf(fid,'! /RESULT_FOLDER=%s\r\n',['PROCESSED']);
    fprintf(fid,'! /RESULT_SUFFIX=%s\r\n',['']);
    fprintf(fid,'! /FILTER_CLASS=%s\r\n',['BUTTERWORTH']);
    fprintf(fid,'/FREQUENCY_CUTOFF=%s\r\n',[num2str(cutoff)]);
    fprintf(fid,'! /NUM_EXTRAPOLATED=%s\r\n',['0']);
    fprintf(fid,'! /TOTAL_BUFFER_SIZE=%s\r\n',['6']);
    fprintf(fid,'! /NUM_BIDIRECTIONAL_PASSES=%s\r\n',['1']);
    fprintf(fid,';\r\n');
    fprintf(fid,'\r\n');
    % use processed Motion data
    fprintf(fid,'Set_Use_Processed_Analog\r\n');
    fprintf(fid,'/USE_PROCESSED=%s\r\n',['TRUE']);
    fprintf(fid,';\r\n');
    fprintf(fid,'\r\n');

    if p.Results.recalc
        %recalc
        fprintf(fid,'Recalc\r\n');
        fprintf(fid,';\r\n');
        fprintf(fid,'\r\n');
    end
    %
    status = fclose(fid);
else
    status = -1;
    disp(['Error Creating pipeline file']);
end
end
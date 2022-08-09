
function exportMatFile(path_pipeLine,varargin)
p = inputParser;
addOptional(p,'SIGNAL_TYPES','');
addOptional(p,'SIGNAL_FOLDER','');
addOptional(p,'SIGNAL_NAMES', '');
addOptional(p,'MATLAB_NAMES', '');
parse(p,varargin{:});
if strcmp(p.Results.SIGNAL_TYPES,'')
    flag = 0; %defult
else
    SIGNAL_TYPES = p.Results.SIGNAL_TYPES;
    SIGNAL_FOLDER = p.Results.SIGNAL_FOLDER;
    SIGNAL_NAMES = p.Results.SIGNAL_NAMES;
    MATLAB_NAMES = p.Results.MATLAB_NAMES;
    if ~strcmp(SIGNAL_TYPES,'')&strcmp(SIGNAL_NAMES,'')&...
            strcmp(SIGNAL_FOLDER,'')&strcmp(MATLAB_NAMES,'')
        flag = 1;
        %check that user inputed all info needed
    else
        disp('Not all neded values for non defult has been enterd')
    end
end


fid = fopen(path_pipeLine,'a');
if fid > 0
    fprintf(fid,'Set_Pipeline_Parameter_To_List_Of_Tagged_Files\r\n');
    fprintf(fid,'/PARAMETER_NAME=%s\r\n','FILENAMES');
    fprintf(fid,'/TAG_NAME=%s\r\n','ALL_FILES');
    fprintf(fid,'! /GET_CURRENT_SELECTED_FILES=%s\r\n',['TRUE']);
    fprintf(fid,'! /USE_SHORT_FILENAMES=%s\r\n',['false']);
    fprintf(fid,';\r\n');
    fprintf(fid,'\r\n');
    %start for loop between all the active files
    fprintf(fid,'For_Each\r\n');
    fprintf(fid,'/ITERATION_PARAMETER_NAME=%s\r\n','INDEX');
    fprintf(fid,'/ITEMS=%s\r\n','::FILENAMES');
    fprintf(fid,';\r\n');
    fprintf(fid,'\r\n');
        %?.
        fprintf(fid,'Select_Active_File\r\n');
        fprintf(fid,'/FILE_NAME=%s\r\n','::INDEX');
        fprintf(fid,';\r\n');
        fprintf(fid,'\r\n');
        %?.
        fprintf(fid,'Set_Pipeline_Parameter\r\n');
        fprintf(fid,'/PARAMETER_NAME=%s\r\n','NEW_INDEX');
        fprintf(fid,'/PARAMETER_VALUE=%s\r\n','::INDEX');
        fprintf(fid,'/PARAMETER_VALUE_SEARCH_FOR=%s\r\n','.c3d');
        fprintf(fid,'/PARAMETER_VALUE_REPLACE_WITH=%s\r\n','.mat');
        fprintf(fid,'! /PARAMETER_VALUE_PREFIX=%s\r\n','');
        fprintf(fid,'! /PARAMETER_VALUE_APPEND=%s\r\n','');
        fprintf(fid,';\r\n');
        fprintf(fid,'\r\n');
        % maybe can be more effective
        fprintf(fid,'Export_Data_To_Matfile\r\n');
        fprintf(fid,'/SIGNAL_TYPES=%s\r\n',[ ...
            'LINK_MODEL_BASED+LINK_MODEL_BASED+LINK_MODEL_BASED' ...%POWER
            '+LINK_MODEL_BASED+LINK_MODEL_BASED+LINK_MODEL_BASED' ...%VEL
            '+LINK_MODEL_BASED+LINK_MODEL_BASED+LINK_MODEL_BASED' ...%MOMENTS
            '+LINK_MODEL_BASED+LINK_MODEL_BASED+LINK_MODEL_BASED'...%Angels
            '+FORCE+FORCE+COFP+COFP'...%FP
            '+KINETIC_KINEMATIC+KINETIC_KINEMATIC'...%FP_PROC
            '+TARGET'] ...%MARKER
            );
        fprintf(fid,'/SIGNAL_FOLDER=%s\r\n',[ ...
            'ORIGINAL+ORIGINAL+ORIGINAL' ...%POWER
            '+ORIGINAL+ORIGINAL+ORIGINAL+' ...%VEL
            'ORIGINAL+ORIGINAL+ORIGINAL+' ...%Moments
            'ORIGINAL+ORIGINAL+ORIGINAL'...%Angeles
            '+ORIGINAL+ORIGINAL+ORIGINAL+ORIGINAL'...%FP
            '+RFT+RFT'...%FP_PROC
            '+PROCESSED'] ...%MARKER
            );
        fprintf(fid,'/SIGNAL_NAMES=%s\r\n',[ ...
            'R_ANK_POW+R_KNEE_POW+R_HIP_POW' ...%POWER
            '+R_ANK_VEL+R_KNEE_VEL+R_HIP_VEL' ...%VEL
            '+R_ANK_MOM+R_KNEE_MOM+R_HIP_MOM' ...%Moments
            '+R_ANK_ANG+R_KNEE_ANG+R_HIP_ANG'...%Angeles
            '+FP2+FP1+FP1+FP2' ...%FP
            '+COP_1+FORCE_1'...%FP_PROC
            '+L_FAL'] ...%Marker
            );
        fprintf(fid,'/FILE_NAME=%s\r\n','::NEW_INDEX');
        fprintf(fid,'/MATLAB_NAMES=%s\r\n', ...
            ['RA_POW+RK_POW+RH_POW' ...%POWER
            '+RA_VEL+RK_VEL+RH_VEL' ...%VEL
            '+RA_MOM+RK_MOM+RH_MOM' ...%Moments
            '+RA_ANG+RK_ANG+RH_ANG'...%Angeles
            '+R_FP+L_FP+L_COP+R_COP'...%FP
            '+R_COP_PROC+R_FP_PROC'...%FP_PROC
            '+L_FAL'] ...%Marker
            );
        fprintf(fid,'/PARAMETER_NAMES=%s\r\n','::INDEX');
        fprintf(fid,'/PARAMETER_GROUPS=%s\r\n','FILE');
        fprintf(fid,'/OUTPUT_PARAMETER_NAMES=%s\r\n','FILENAME');
        fprintf(fid,'/USE_NAN_FOR_DATANOTFOUND=%s\r\n','TRUE');
        fprintf(fid,';\r\n');
        fprintf(fid,'\r\n');

    %end for loop between all the active files   
    fprintf(fid,'End_For_Each\r\n');
    fprintf(fid,'/ITERATION_PARAMETER_NAME=%s\r\n','INDEX');
    fprintf(fid,';\r\n');
    fprintf(fid,'\r\n');
    
    status = fclose(fid);
else
    status = -1;
    disp(['Error Creating pipeline file']);
end
end
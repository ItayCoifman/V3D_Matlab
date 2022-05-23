
function exportMatFile(path_pipeLine)
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
    fprintf(fid,'/SIGNAL_TYPES=%s\r\n',['LINK_MODEL_BASED+LINK_MODEL_BASED+LINK_MODEL_BASED+LINK_MODEL_BASED+LINK_MODEL_BASED+LINK_MODEL_BASED+LINK_MODEL_BASED+LINK_MODEL_BASED+LINK_MODEL_BASED+LINK_MODEL_BASED+LINK_MODEL_BASED+LINK_MODEL_BASED+FORCE+FORCE+COFP+COFP']);
    fprintf(fid,'/SIGNAL_FOLDER=%s\r\n',['ORIGINAL+ORIGINAL+ORIGINAL+ORIGINAL+ORIGINAL+ORIGINAL+ORIGINAL+ORIGINAL+ORIGINAL+ORIGINAL+ORIGINAL+ORIGINAL+ORIGINAL+ORIGINAL+ORIGINAL+ORIGINAL']);
    fprintf(fid,'/SIGNAL_NAMES=%s\r\n',['R_ANK_POW+R_KNE_POW+R_HIP_POW+R_ANK_VEL+R_KNEE_VEL+R_HIP_VEL+R_ANK_MOM+R_KNEE_MOM+R_HIP_MOM+R_ANK_ANG+R_KNEE_ANG+R_HIP_ANG+FP2+FP1+FP1+FP2']);
    fprintf(fid,'/FILE_NAME=%s\r\n','::NEW_INDEX');
    fprintf(fid,'/MATLAB_NAMES=%s\r\n','RA_POW+RK_POW+RH_POW+RA_VEL+RK_VEL+RH_VEL+RA_MOM+RK_MOM+RH_MOM+RA_ANG+RK_ANG+RH_ANG+R_FP+L_FP+L_COP+R_COP');
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
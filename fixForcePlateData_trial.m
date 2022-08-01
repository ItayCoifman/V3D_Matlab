
function fixForcePlateData_trial(path_pipeLine,varargin)
p = inputParser;
addOptional(p,'recalc',true);
addOptional(p,'FP_ZERO','0+0');
addOptional(p,'singleFile',false);

parse(p,varargin{:});
FP_ZERO = p.Results.FP_ZERO;
%specific lab functions
fid = fopen(path_pipeLine,'a');

if fid > 0
    % ?.
    if ~p.Results.singleFile == true
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
    end
    %Modify force plate parameters.
    fprintf(fid,'Modify_Force_Platform_Parameters\r\n');
    fprintf(fid,'/FP_USED=%s\r\n','2');
    fprintf(fid,'/FP_TYPE=%s\r\n','4+4');
    fprintf(fid,'/FP_CHANNEL=%s\r\n','7+8+9+10+11+12+1+2+3+4+5+6');
    fprintf(fid,'/FP_ORIGIN=%s\r\n','-279.5+889+-0+279.5+889+-0');
    fprintf(fid,'/FP_CALMATRIX=%s\r\n','500+0+0+0+0+0+0+500+0+0+0+0+0+0+1000+0+0+0+0+0+0+800000+0+0+0+0+0+0+400000+0+0+0+0+0+0+400000+500+0+0+0+0+0+0+500+0+0+0+0+0+0+1000+0+0+0+0+0+0+800000+0+0+0+0+0+0+400000+0+0+0+0+0+0+400000');
    fprintf(fid,'/STORE_CALMATRIX=%s\r\n','BYCOLUMN');
    fprintf(fid,'/FP_ZERO=%s\r\n',FP_ZERO);
    fprintf(fid,'!/FP_ZEROS=%s\r\n','0+0+0+0');
    fprintf(fid,'! /FP_CORNER1=%s\r\n',['']);
    fprintf(fid,'! /FP_CORNER2=%s\r\n',['']);
    fprintf(fid,'! /FP_CORNER3=%s\r\n',['']);
    fprintf(fid,'! /FP_CORNER4=%s\r\n',['']);
    fprintf(fid,'/FP_COP_POLYNOMIAL=%s\r\n','0+0+0+0+0+0+0+0+0+0+0+0+1.35632e-19+1.35632e-19+1.35632e-19+1.35632e-19+1.35632e-19+1.35632e-19+1.35632e-19+1.35632e-19+1.35632e-19+1.35632e-19+1.35632e-19+1.45113e-08');
    fprintf(fid,'/FP_COP_TRANSLATION=%s\r\n','0+0+1.35632e-13+1.35632e-13+1.35632e-13+1.35632e-13');
    fprintf(fid,'/FP_COP_ROTATION=%s\r\n','1.35632e-13+2.11167e-13+0+1.35632e-13+1.35632e-13+2.20333e+14');
    fprintf(fid,'/UPDATE_C3D_FILE=%s\r\n','TRUE');
    fprintf(fid,'! /MODIFY_CAL_FILE=%s\r\n','FALSE');
    fprintf(fid,';\r\n');
    fprintf(fid,'\r\n');
    if ~p.Results.singleFile == true

        %end for loop between all the active files
        fprintf(fid,'End_For_Each\r\n');
        fprintf(fid,'/ITERATION_PARAMETER_NAME=%s\r\n','INDEX');
        fprintf(fid,';\r\n');
        fprintf(fid,'\r\n');
    end

    %recalc
    if p.Results.recalc
        %recalc
        fprintf(fid,'Recalc\r\n');
        fprintf(fid,';\r\n');
        fprintf(fid,'\r\n');
    end
    status = fclose(fid);
else
    status = -1;
    disp(['Error adding motion file']);
end
end
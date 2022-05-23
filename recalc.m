
function recalc(path_pipeLine)
fid = fopen(path_pipeLine,'a');
if fid > 0
    %recalc
    fprintf(fid,'Recalc\r\n');
    fprintf(fid,';\r\n');
    fprintf(fid,'\r\n');
    status = fclose(fid);
else
    status = -1;
    disp(['Error Creating pipeline file']);
end

end
function runPipeline(path_pipeLine, varargin)
%this function gets as an input the pipeline nd run it.
%it asumes that the path for the V3D.exe is -
%C:\Program Files\Visual3D x64\Visual3D.exe'
% if diffrent path is used enter the input 'path_V3D' with the currenct
% path.

p = inputParser;
addOptional(p,'path_V3D','C:\Program Files\Visual3D x64\Visual3D.exe');
parse(p,varargin{:});
path_V3D = p.Results.path_V3D;
[filepath,name,ext] = fileparts(path_pipeLine);
copyfile(path_pipeLine,[cd '\' name,ext]);
[status,result] = dos(['"' path_V3D '" /s ' [name,ext] '&']);
% add delete file when the run is over.
pause(10)
delete([cd '\' name,ext]);
end
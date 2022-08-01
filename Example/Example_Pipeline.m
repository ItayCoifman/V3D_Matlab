%% init the path to the V3D.exe
path_V3D = 'C:\Program Files\Visual3D x64\Visual3D.exe';
%% inputs
inputDir = [cd '\c3d\'];
outputDir =[cd '\outputs\'];
if ~exist(outputDir,'dir')
    mkdir(outputDir);
end
path_GenericModel =[inputDir 'CAST.mdh'];
path_staticTrial =[inputDir 'Static.c3d'];
motions = [{[inputDir 'run_1.c3d']};{[inputDir 'run_2.c3d']}];

subjectMass = '50';
subjectHeight ='1.7';
workSpacepath = [inputDir 'workSpace.cmz'];

%%  Create PipeLine
pipeLinesDir =[outputDir];
path_pipeLine = [pipeLinesDir 'pipeline.v3s'];
status = createPipeLine(path_pipeLine);
%% scale generic model using static Trial
scaleModel(path_pipeLine,'path_GenericModel',path_GenericModel,...
    'path_staticTrial',path_staticTrial,'subjectMass',subjectMass,...
    'subjectHeight',subjectHeight);
%% change Weight metric
changeMetric(path_pipeLine,'addedMass_Thigh',0)
changeMetric(path_pipeLine,'addedMass_Shank',0)
changeMetric(path_pipeLine,'addedMass_Foot',0)
%% load trial
%add many motions as you like
%motion - 1
for i = 1:length(motions)
    addMotion(path_pipeLine, 'path_motion',motions{i});
end


%% Modify_Force_Platform_Parameters
fixForcePlateData(path_pipeLine,'recalc',false);
%% filter Raw data
% low pass filter markers
lowPassMotionCapture(path_pipeLine,'cutoff',10,'recalc',false);
% low pass filter Analog Data
lowPassAnalog(path_pipeLine,'cutoff',20,'recalc',false);
recalc(path_pipeLine)
%% caculations
%optional functionNames 'JOINT_ANGLE','JOINT_MOMENT','JOINT_POWER','JOINT_VELOCITY'
%optional joints 'hip','knee','ankle'
calculateJoint(path_pipeLine,'JOINT_ANGLE', 'hip',  'resultName', 'R_HIP_ANG');
calculateJoint(path_pipeLine,'JOINT_MOMENT', 'hip',  'resultName', 'R_HIP_MOM');
calculateJoint(path_pipeLine,'JOINT_POWER', 'hip',  'resultName', 'R_HIP_POW');
calculateJoint(path_pipeLine,'JOINT_VELOCITY', 'hip',  'resultName', 'R_HIP_VEL');


calculateJoint(path_pipeLine,'JOINT_ANGLE', 'knee',  'resultName', 'R_KNEE_MOM');
calculateJoint(path_pipeLine,'JOINT_MOMENT', 'knee',  'resultName', 'R_KNEE_ANG');
calculateJoint(path_pipeLine,'JOINT_POWER', 'knee',  'resultName', 'R_KNEE_POW');
calculateJoint(path_pipeLine,'JOINT_VELOCITY', 'knee',  'resultName', 'R_KNEE_VEL');


calculateJoint(path_pipeLine,'JOINT_ANGLE', 'ankle',  'resultName', 'R_ANK_ANG');
calculateJoint(path_pipeLine,'JOINT_MOMENT', 'ankle',  'resultName', 'R_ANK_MOM');
calculateJoint(path_pipeLine,'JOINT_POWER', 'ankle',  'resultName', 'R_ANK_POW');
calculateJoint(path_pipeLine,'JOINT_VELOCITY', 'ankle',  'resultName', 'R_ANK_VEL');


%% export calcutltions to matlabStruct
exportMatFile(path_pipeLine);
%% save workspace
saveWorkSpace(path_pipeLine,'path', [outputDir 'workspcae.cmz'])
%% run pipline
%% Move outputs and close V3D
% terminate program
runPipeline(path_pipeLine,'path_V3D',path_V3D);
%% wait till V3D finished
flag = true;
while flag
    pause(3)
    if length(dir(fullfile(inputDir,['*.' 'mat']))) == length(motions);
        pause(1)
        flag = false;
    end
end
moveFiles(inputDir,outputDir,'mat','copy',false)
%% Close V3D
%[status1]=dos(['"C:\Windows\System32\taskkill.exe"' '/F /im ' 'Visual3D.exe']);








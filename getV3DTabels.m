function [ikTable idTable,powerTable,forceTable,forceTableProc] = getV3DTabels(v3dData,varargin)
if strcmp(v3dData,'')
    [file path] = uigetfile();
    v3dPath =[path file];
    v3dData = load(v3dPath);
end
FS = v3dData.FRAME_RATE{:};
p = inputParser;
addOptional(p,'timeVec',[]);
addOptional(p,'FS',FS);
addOptional(p,'startTime',0);
addOptional(p,'endTime',0);
parse(p,varargin{:});
vec  = v3dData.RA_ANG{:}(:,1);
Header =getTimeVector(p,vec);

%% extract cell data for Force Table
forceTable =[];
try
ground_force_2_v = v3dData.R_FP{:};
ground_force_1_v = v3dData.L_FP{:};
ground_force_2_p = v3dData.R_COP{:};
ground_force_1_p = v3dData.L_COP{:};
forceTable = table(Header,ground_force_1_v,ground_force_1_p,ground_force_2_v,ground_force_2_p);
forceTable = chgeForceTableNames(forceTable);
end


%% extract cell data for Force Table
forceTableProc=[];
try
ground_force_2_v = v3dData.R_FP_PROC{:};
ground_force_2_p = v3dData.R_COP_PROC{:};
forceTableProc = table(Header,ground_force_2_v,ground_force_2_p);
forceTableProc = chgeForceTableNames(forceTableProc);
end

%% extract cell data for IK table
ankle_angle_r = v3dData.RA_ANG{:}(:,1);
knee_angle_r = v3dData.RK_ANG{:}(:,1);
hip_flexion_r = v3dData.RH_ANG{:}(:,1);
hip_adduction_r =v3dData.RH_ANG{:}(:,2);
ikTable = table(Header,hip_flexion_r,hip_adduction_r,knee_angle_r,ankle_angle_r);
%% extract cell data for ID table
ankle_angle_r_moment = v3dData.RA_MOM{:}(:,1);
knee_angle_r_moment = v3dData.RK_MOM{:}(:,1);
hip_flexion_r_moment = v3dData.RH_MOM{:}(:,1);
hip_adduction_r_moment =v3dData.RH_MOM{:}(:,2);
idTable = table(Header,hip_flexion_r_moment,hip_adduction_r_moment,knee_angle_r_moment,ankle_angle_r_moment);



%% extract cell data for Power Table
try
ankle_angle_r_power = v3dData.RA_POW{:}(:,2);
knee_angle_r_power = v3dData.RK_POW{:}(:,2);
hip_flexion_r_power = v3dData.RH_POW{:}(:,2);
hip_adduction_r_power =v3dData.RH_POW{:}(:,1);
powerTable = table(Header,hip_flexion_r_power,hip_adduction_r_power,knee_angle_r_power,ankle_angle_r_power);
catch
    powerTable = [];
end

%plot(v3dData.RK_POW{:}(:,2))
%% cut tabels if needed
t0 = p.Results.startTime;
tn = p.Results.endTime;
[ikTable, idTable] = cutTables(t0, ikTable, idTable, tn);
end

function forceTable = chgeForceTableNames(forceTable)
forceTable = splitvars(forceTable);
tableNames = forceTable.Properties.VariableNames;
tableNames = replace(tableNames,'p_1','_px');
tableNames = replace(tableNames,'p_2','_py');
tableNames = replace(tableNames,'p_3','_pz');
tableNames = replace(tableNames,'v_1','_vx');
tableNames = replace(tableNames,'v_2','_vy');
tableNames = replace(tableNames,'v_3','_vz');
forceTable.Properties.VariableNames = tableNames;
end

function Header = getTimeVector(p, vec)
if isempty(p.Results.timeVec)
    if p.Results.FS~=0
        FS = p.Results.FS
        dt = 1/FS;
        Header =(0:dt:(length(vec)-1)/FS)';
    else
        disp('Please add FS or time vector')
        Header = [];
    end
else
    Header = p.Results.timeVec;
    if length(Header)~=length(vec)
        Header = Header(1:length(vec));
    end
end
end

function [ikTable, idTable] = cutTables(t0, ikTable, idTable, tn)
if t0>0
    ikTable = ikTable(ikTable.Header >= t0,:);
    idTable = idTable(idTable.Header >= t0,:);

end
if tn>0
    ikTable = ikTable(ikTable.Header <= tn,:);
    idTable = idTable(idTable.Header <= tn,:);
end
end
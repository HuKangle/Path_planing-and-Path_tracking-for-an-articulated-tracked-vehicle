ObstList = []; % Obstacle point list

ObstLine = []; % Park lot line for collision check
%% initiate scenario
% 
% for i = -40:40
%     ObstList(end+1,:) = [i,10];
% end
% for i = -10:10
%     ObstList(end+1,:) = [i, 5];
% end
% for i = -40:-10
%     ObstList(end+1,:) = [i, 0];
% end
% for i = 10:40
%     ObstList(end+1,:) = [i, 0];
% end
% for i = 0:5
%     ObstList(end+1,:) = [10, i];
% end
% for i = 0:5
%     ObstList(end+1,:) = [-10, i];
% end
% 
% ObstLine = []; % Park lot line for collision check
% tLine = [-40, 10 , 40, 10]; %start_x start_y end_x end_y
% ObstLine(end+1,:) = tLine;
% tLine = [-40, 0, -10, 0];
% ObstLine(end+1,:) = tLine;
% tLine = [-10, 0, -10, 5];
% ObstLine(end+1,:) = tLine;
% tLine = [-10, 5, 10, 5];
% ObstLine(end+1,:) = tLine;
% tLine = [10, 5, 10, 0];
% ObstLine(end+1,:) = tLine;
% tLine = [10, 0, 40, 0];
% ObstLine(end+1,:) = tLine;
% tLine = [-40, 0, -40, 10];
% ObstLine(end+1,:) = tLine;
% tLine = [40, 0, 40, 10];
% ObstLine(end+1,:) = tLine;


for i = 0:100
    ObstList(end+1,:) = [i,100];
end
for i = 0:100
    ObstList(end+1,:) = [i, 0];
end
for i = 0:100
    ObstList(end+1,:) = [0, i];
end
for i = 0:100
    ObstList(end+1,:) = [100, i];
end

tLine = [0, 0, 0, 100];
ObstLine(end+1,:) = tLine;
tLine = [0, 100, 100, 100];
ObstLine(end+1,:) = tLine;
tLine = [100, 100, 100, 0];
ObstLine(end+1,:) = tLine;
tLine = [100, 0, 0, 0];
ObstLine(end+1,:) = tLine;

%% 1st obstacle scenario
for i = 20:60
    ObstList(end+1,:) = [i, 10];
end
for i = 20:60
    ObstList(end+1,:) = [i, 40];
end

for i = 10:40
    ObstList(end+1,:) = [20, i];
end
for i = 10:40
    ObstList(end+1,:) = [60, i];
end

for i = 50:70
    ObstList(end+1,:) = [i, 60];
end
for i = 50:70
    ObstList(end+1,:) = [i, 80];
end

for i = 60:80
    ObstList(end+1,:) = [50, i];
end
for i = 60:80
    ObstList(end+1,:) = [70, i];
end

tLine = [20, 10 , 20, 40]; %start_x start_y end_x end_y
ObstLine(end+1,:) = tLine;
tLine = [20, 40, 60, 40];
ObstLine(end+1,:) = tLine;
tLine = [60, 40, 60, 10];
ObstLine(end+1,:) = tLine;
tLine = [60, 10, 20, 10];
ObstLine(end+1,:) = tLine;
tLine = [50, 60, 50, 80];
ObstLine(end+1,:) = tLine;
tLine = [50, 80, 70, 80];
ObstLine(end+1,:) = tLine;
tLine = [70, 80, 70, 60];
ObstLine(end+1,:) = tLine;
tLine = [70, 60, 50, 60];
ObstLine(end+1,:) = tLine;
% %% 2rd obstacle scenario
% for i = 20:60
%     ObstList(end+1,:) = [i, 10];
% end
% for i = 20:60
%     ObstList(end+1,:) = [i, 30];
% end
% for i = 10:30
%     ObstList(end+1,:) = [20, i];
% end
% for i = 10:30
%     ObstList(end+1,:) = [60, i];
% end
% 
% for i = 70:90
%     ObstList(end+1,:) = [i, 10];
% end
% for i = 70:90
%     ObstList(end+1,:) = [i, 40];
% end
% for i = 10:40
%     ObstList(end+1,:) = [70, i];
% end
% for i = 10:40
%     ObstList(end+1,:) = [90, i];
% end
% 
% for i = 10:50
%     ObstList(end+1,:) = [i, 40];
% end
% for i = 10:50
%     ObstList(end+1,:) = [i, 60];
% end
% for i = 40:60
%     ObstList(end+1,:) = [10, i];
% end
% for i = 40:60
%     ObstList(end+1,:) = [50, i];
% end
% 
% for i = 20:80
%     ObstList(end+1,:) = [i, 70];
% end
% for i = 20:80
%     ObstList(end+1,:) = [i, 90];
% end
% for i = 70:90
%     ObstList(end+1,:) = [20, i];
% end
% for i = 70:90
%     ObstList(end+1,:) = [80, i];
% end
% 
% tLine = [20, 10 , 20, 30]; %start_x start_y end_x end_y
% ObstLine(end+1,:) = tLine;
% tLine = [20, 30 , 60, 30]; 
% ObstLine(end+1,:) = tLine;
% tLine = [60, 30 , 60, 10]; 
% ObstLine(end+1,:) = tLine;
% tLine = [60, 10 , 20, 10]; 
% ObstLine(end+1,:) = tLine;
% 
% tLine = [70, 10 , 70, 40]; 
% ObstLine(end+1,:) = tLine;
% tLine = [70, 40 , 90, 40]; 
% ObstLine(end+1,:) = tLine;
% tLine = [90, 40 , 90, 10]; 
% ObstLine(end+1,:) = tLine;
% tLine = [90, 10 , 70, 10]; 
% ObstLine(end+1,:) = tLine;
% 
% tLine = [10, 40 , 10, 60]; 
% ObstLine(end+1,:) = tLine;
% tLine = [10, 60 , 50, 60]; 
% ObstLine(end+1,:) = tLine;
% tLine = [50, 60 , 50, 40]; 
% ObstLine(end+1,:) = tLine;
% tLine = [50, 40 , 10, 40]; 
% ObstLine(end+1,:) = tLine;
% 
% tLine = [20, 70 , 20, 90]; 
% ObstLine(end+1,:) = tLine;
% tLine = [20, 90 , 80, 90]; 
% ObstLine(end+1,:) = tLine;
% tLine = [80, 90 , 80, 70]; 
% ObstLine(end+1,:) = tLine;
% tLine = [80, 70 , 20, 70]; 
% ObstLine(end+1,:) = tLine;
% %% Obstacle 3rd
% 
% for i = 20:40
%     ObstList(end+1,:) = [i, 10];
% end
% for i = 20:40
%     ObstList(end+1,:) = [i, 30];
% end
% for i = 10:30
%     ObstList(end+1,:) = [20, i];
% end
% for i = 10:30
%     ObstList(end+1,:) = [40, i];
% end
% 
% for i = 50:65
%     ObstList(end+1,:) = [i, 5];
% end
% for i = 50:65
%     ObstList(end+1,:) = [i, 25];
% end
% for i = 5:25
%     ObstList(end+1,:) = [50, i];
% end
% for i = 5:25
%     ObstList(end+1,:) = [65, i];
% 
% end
% for i = 70:90
%     ObstList(end+1,:) = [i, 10];
% end
% for i = 70:90
%     ObstList(end+1,:) = [i, 30];
% end
% for i = 10:30
%     ObstList(end+1,:) = [70, i];
% end
% for i = 10:30
%     ObstList(end+1,:) = [90, i];
% end
% 
% for i = 10:30
%     ObstList(end+1,:) = [i, 40];
% end
% for i = 10:30
%     ObstList(end+1,:) = [i, 60];
% end
% for i = 40:60
%     ObstList(end+1,:) = [10, i];
% end
% for i = 40:60
%     ObstList(end+1,:) = [30, i];
% end
% 
% for i = 40:75
%     ObstList(end+1,:) = [i, 40];
% end
% for i = 40:75
%     ObstList(end+1,:) = [i, 60];
% end
% for i = 40:60
%     ObstList(end+1,:) = [40, i];
% end
% for i = 40:60
%     ObstList(end+1,:) = [75, i];
% end
% 
% for i = 80:95
%     ObstList(end+1,:) = [i, 35];
% end
% for i = 80:95
%     ObstList(end+1,:) = [i, 75];
% end
% for i = 35:75
%     ObstList(end+1,:) = [80, i];
% end
% for i = 35:75
%     ObstList(end+1,:) = [95, i];
% end
% 
% for i = 10:15
%     ObstList(end+1,:) = [i, 70];
% end
% for i = 10:15
%     ObstList(end+1,:) = [i, 90];
% end
% for i = 70:90
%     ObstList(end+1,:) = [10, i];
% end
% for i = 70:90
%     ObstList(end+1,:) = [15, i];
% end
% 
% for i = 20:40
%     ObstList(end+1,:) = [i, 70];
% end
% for i = 20:40
%     ObstList(end+1,:) = [i, 90];
% end
% for i = 70:90
%     ObstList(end+1,:) = [20, i];
% end
% for i = 70:90
%     ObstList(end+1,:) = [40, i];
% end
% 
% for i = 50:70
%     ObstList(end+1,:) = [i, 65];
% end
% for i = 50:70
%     ObstList(end+1,:) = [i, 90];
% end
% for i = 65:90
%     ObstList(end+1,:) = [50, i];
% end
% for i = 65:90
%     ObstList(end+1,:) = [70, i];
% end
% 
% tLine = [20, 10 , 20, 30]; %start_x start_y end_x end_y
% ObstLine(end+1,:) = tLine;
% tLine = [20, 30 , 40, 30];
% ObstLine(end+1,:) = tLine;
% tLine = [40, 30 , 40, 10];
% ObstLine(end+1,:) = tLine;
% tLine = [40, 10 , 20, 10];
% ObstLine(end+1,:) = tLine;
% 
% tLine = [50, 5 , 50, 25];
% ObstLine(end+1,:) = tLine;
% tLine = [50, 25 , 65, 25];
% ObstLine(end+1,:) = tLine;
% tLine = [65, 25 , 65, 5];
% ObstLine(end+1,:) = tLine;
% tLine = [65, 5 , 50, 5];
% ObstLine(end+1,:) = tLine;
% 
% tLine = [70, 10 , 70, 30];
% ObstLine(end+1,:) = tLine;
% tLine = [70, 30 , 90, 30];
% ObstLine(end+1,:) = tLine;
% tLine = [90, 30 , 90, 10];
% ObstLine(end+1,:) = tLine;
% tLine = [90, 10 , 70, 10];
% ObstLine(end+1,:) = tLine;
% 
% tLine = [10, 40 , 10, 60];
% ObstLine(end+1,:) = tLine;
% tLine = [10, 60 , 30, 60];
% ObstLine(end+1,:) = tLine;
% tLine = [30, 60 , 30, 40];
% ObstLine(end+1,:) = tLine;
% tLine = [30, 40 , 10, 40];
% ObstLine(end+1,:) = tLine;
% 
% tLine = [40, 40 , 40, 60];
% ObstLine(end+1,:) = tLine;
% tLine = [40, 60 , 75, 60];
% ObstLine(end+1,:) = tLine;
% tLine = [75, 60 , 75, 40];
% ObstLine(end+1,:) = tLine;
% tLine = [75, 40 , 40, 40];
% ObstLine(end+1,:) = tLine;
% 
% tLine = [80, 35 , 85, 75];
% ObstLine(end+1,:) = tLine;
% tLine = [85, 75 , 95, 75];
% ObstLine(end+1,:) = tLine;
% tLine = [95, 75 , 95, 35];
% ObstLine(end+1,:) = tLine;
% tLine = [95, 35 , 80, 35];
% ObstLine(end+1,:) = tLine;
% 
% tLine = [10, 70 , 10, 90];
% ObstLine(end+1,:) = tLine;
% tLine = [10, 90 , 15, 90];
% ObstLine(end+1,:) = tLine;
% tLine = [15, 90 , 15, 70];
% ObstLine(end+1,:) = tLine;
% tLine = [15, 70 , 10, 70];
% ObstLine(end+1,:) = tLine;
% 
% tLine = [20, 70 , 20, 90];
% ObstLine(end+1,:) = tLine;
% tLine = [20, 90 , 40, 90];
% ObstLine(end+1,:) = tLine;
% tLine = [40, 90 , 40, 70];
% ObstLine(end+1,:) = tLine;
% tLine = [40, 70 , 20, 70];
% ObstLine(end+1,:) = tLine;
% 
% tLine = [50, 65 , 50, 90];
% ObstLine(end+1,:) = tLine;
% tLine = [50, 90 , 75, 90];
% ObstLine(end+1,:) = tLine;
% tLine = [75, 90 , 75, 50];
% ObstLine(end+1,:) = tLine;
% tLine = [75, 50 , 50, 50];
% ObstLine(end+1,:) = tLine;
%%
Vehicle.WB = 5;  % [m] wheel base: rear to front steer
Vehicle.W = 2; % [m] width of vehicle
Vehicle.LF = 2.5; % [m] distance from rear to vehicle front end of vehicle
Vehicle.LB = 2.0; % [m] distance from rear to vehicle back end of vehicle
Vehicle.MAX_STEER = 0.4; % [rad] maximum steering angle 
Vehicle.MIN_CIRCLE = 17; % [m] mininum steering circle radius
Vehicle.MAX_STEER_reed = 0.3;
% ObstList and ObstLine
Configure.ObstList = ObstList;
Configure.ObstLine = ObstLine;

% Motion resolution define
Configure.MOTION_RESOLUTION = 1; % [m] path interporate resolution
Configure.N_STEER = 20.0; % number of steer command
Configure.EXTEND_AREA = 0; % [m] map extend length
Configure.XY_GRID_RESOLUTION = 2.0; % [m]
Configure.YAW_GRID_RESOLUTION = deg2rad(15.0); % [rad]
% Grid bound
Configure.MINX = min(ObstList(:,1))-Configure.EXTEND_AREA;
Configure.MAXX = max(ObstList(:,1))+Configure.EXTEND_AREA;
Configure.MINY = min(ObstList(:,2))-Configure.EXTEND_AREA;
Configure.MAXY = max(ObstList(:,2))+Configure.EXTEND_AREA;
Configure.MINYAW = -pi;
Configure.MAXYAW = pi;
% Cost related define
Configure.SB_COST = 5; % switch back penalty cost
Configure.BACK_COST = 5; % backward penalty cost
Configure.STEER_CHANGE_COST = 8; % steer angle change penalty cost
Configure.STEER_COST = 2; % steer angle change penalty cost
Configure.H_COST = 1; % Heuristic cost

%%
% Start = [2, 2, 0];
% End = [90, 90, pi/2];

Start = [40, 2, 0];
End = [20, 80, pi/2];
%%
% 使用完整约束有障碍情况下用A*搜索的最短路径最为hybrid A*的启发值
ObstMap = GridAStar(Configure.ObstList,End,Configure.XY_GRID_RESOLUTION);
Configure.ObstMap = ObstMap;
cla %  从当前坐标区删除包含可见句柄的所有图形对象。
[x,y,th,D,delta] = New_HybridAStar226(Start,End,Vehicle,Configure);
psi = th -delta;
% GridAStar(ObstList,End,2);
if isempty(x)
    disp("Failed to find path!")
else
    New_VehicleAnimation(x,y,th,psi,Configure,Vehicle)
end

path.x = x;
path.y = y;
path.theta =th;
path.psi = psi;
path.delta = delta;
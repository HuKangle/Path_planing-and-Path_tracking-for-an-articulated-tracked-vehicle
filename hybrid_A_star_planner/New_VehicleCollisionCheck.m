function isCollision = New_VehicleCollisionCheck(pVec,ObstLine,Vehicle)
    W = Vehicle.W;
    LF = Vehicle.LF;
    LB = Vehicle.LB;
    % 前车框架
    Cornerfl = [LF, W/2];
    Cornerfr = [LF, -W/2];
    Cornerrl = [-LB, W/2];
    Cornerrr = [-LB, -W/2];
    % 后车框架
    t_Cornerfl = [LF, W/2];
    t_Cornerfr = [LF, -W/2];
    t_Cornerrl = [-LB, W/2];
    t_Cornerrr = [-LB, -W/2];

    Pos = pVec(1:2);
    theta = pVec(3);
    gamma = pVec(4);
    psi   = theta-gamma;
    t_Pos    = Pos - [LF*cos(theta), LF*sin(theta)] - [LF*cos(psi), LF*sin(psi)];
    dcm = angle2dcm(-theta, 0, 0); % 方向余弦矩阵，负号是 把坐标转换为基坐标
    t_dcm = angle2dcm(-psi, 0, 0); % 方向余弦矩阵，负号是 把坐标转换为基坐标
    % 前车运动表达
    tvec = dcm*[Cornerfl';0]; % 旋转变换
    tvec = tvec';
    Cornerfl = tvec(1:2)+Pos; % 平移变换
    
    tvec = dcm*[Cornerfr';0];
    tvec = tvec';
    Cornerfr = tvec(1:2)+Pos;
    
    tvec = dcm*[Cornerrl';0];
    tvec = tvec';
    Cornerrl = tvec(1:2)+Pos;
    
    tvec = dcm*[Cornerrr';0];
    tvec = tvec';
    Cornerrr = tvec(1:2)+Pos;  

    %后车运动表达
    tvec = t_dcm*[t_Cornerfl';0]; % 旋转变换
    tvec = tvec';
    t_Cornerfl = tvec(1:2)+t_Pos; % 平移变换
    
    tvec = t_dcm*[t_Cornerfr';0];
    tvec = tvec';
    t_Cornerfr = tvec(1:2)+t_Pos;
    
    tvec = t_dcm*[t_Cornerrl';0];
    tvec = tvec';
    t_Cornerrl = tvec(1:2)+t_Pos;
    
    tvec = t_dcm*[t_Cornerrr';0];
    tvec = tvec';
    t_Cornerrr = tvec(1:2)+t_Pos;  
    % 记录构成车辆模型的四条直线的起止坐标   
    Rect = [];                            %  _ _ _ _ _
    Rect(end+1,:) = [Cornerfl, Cornerfr]; % |    ^    |
    Rect(end+1,:) = [Cornerfr, Cornerrr]; % |    ^    |
    Rect(end+1,:) = [Cornerrr, Cornerrl]; % |    ^    |
    Rect(end+1,:) = [Cornerrl, Cornerfl]; % | _ _^ _ _|
    %
    t_Rect = [];  
    t_Rect(end+1,:) = [t_Cornerfl, t_Cornerfr];
    t_Rect(end+1,:) = [t_Cornerfr, t_Cornerrr];
    t_Rect(end+1,:) = [t_Cornerrr, t_Cornerrl];
    t_Rect(end+1,:) = [t_Cornerrl, t_Cornerfl];
    % obs_self_define=[-25, 30; 25, 30; 25, 5; 10, 5; 10, 0; -10, 0; -10, 5; -25, 5; -25, 30]; % 手动根据地图修改障碍物线段,地图变换时需要修改此数据
%     obs_self_define=[-40, 10; 40, 10; 40, 0; 10, 0; 10, 5; -10, 5; -10, 0; -40, 0; -40, 10]; % 手动根据地图修改障碍物线段,地图变换时需要修改此数
      obs_self_define = [20,10;20,40;60,40;60,10;20,10; 50,60;50,80;70,80;70,60;50,60];
%     obs_self_define = [20,10;20,30;60,30;60,10;20,10;
%                        10,40;10,60;50,60;50,40;10,40;
%                        70,10;70,50;90,50;90,10;70,10;
%                        20,70;20,90;80,90;80,70;20,70];
%     obs_self_define = [20,10;20,30;40,30;40,10;20,10; 50,5;50,25;65,25;65,5;50,5; 70,10;70,30;90,30;90,10;70,10;....
%     10,40;10,60;30,60;30,40;10,40; 40,40;40,60;75,60;75,40;40,40;  80,35;80,75;95,75;95,35;80,35;....
%     10,70;10,90;15,90;15,70;10,70; 20,70;20,90;40,90;40,70;20,70; 50,65;50,90;70,90;70,65;50,65];
    isCollision = false;
    for i = 1:5:6
        [xf,~] = polyxpoly([Rect(:,1);Rect(1,1)],[Rect(:,2);Rect(1,2)],obs_self_define(i:i+4,1),obs_self_define(i:i+4,2)); % 检测车身是否与边界相交
        [xr,~] = polyxpoly([t_Rect(:,1);t_Rect(1,1)],[t_Rect(:,2);t_Rect(1,2)],obs_self_define(i:i+4,1),obs_self_define(i:i+4,2)); % 检测车身是否与边界相交
        if isempty(xr)==0 || isempty(xf)==0
            isCollision = true;
        end
        if isCollision == true
            return
        end
    end
%         for i = 1:length(ObstLine)
%         [xi,yi] = polyxpoly([Rect(:,1);Rect(1,1)],[Rect(:,2);Rect(1,2)],obs_self_define(:,1),obs_self_define(:,2)); % 检测车身是否与边界相交
%         [xr,yr] = polyxpoly([t_Rect(:,1);t_Rect(1,1)],[t_Rect(:,2);t_Rect(1,2)],obs_self_define(:,1),obs_self_define(:,2));
%         if isempty(xi)==0 || isempty(xr)==0
%             isCollision = true;
%         end
%         if isCollision == true
%             return
%         end
%         end
end

function isCollision = RectLineCollisionCheck(Rect, Line)
    isCollision = SATCheckObj2Line(Rect, Line, Line);
    if isCollision == false
        return
    else
        isCollision = SATCheckObj2Line(Rect, Line, Rect(1,:));
        if isCollision == false
            return
        else
            isCollision = SATCheckObj2Line(Rect, Line, Rect(2,:));
        end
    end
end

function isCollision = SATCheckObj2Line(Object, workLine, refLine)
    theta = atan2(refLine(4)-refLine(2),refLine(3)-refLine(1));
    dcm = angle2dcm(theta, 0, 0);
    % dcm*x 表示将基坐标中的x表示到旋转后的坐标系中，即计算坐标旋转后各向量在新坐标中的表示
    pStart = dcm*[workLine(1:2)'; 0];
    pEnd = dcm*[workLine(3:4)'; 0];
    LineMinx = min(pStart(1), pEnd(1));
    LineMaxx = max(pStart(1), pEnd(1));
    LineMiny = min(pStart(2), pEnd(2));
    LineMaxy = max(pStart(2), pEnd(2));
    % To find the max and min corrdination of object
    dim = size(Object);
    objLineMinx = inf;
    objLineMaxx = 0;
    objLineMiny = inf;
    objLineMaxy = 0;
    for i = 1:dim(1)
        objpStart = dcm*[Object(i,1:2) 0]';
        objpEnd = dcm*[Object(i,3:4) 0]';
        objLineMinx = min([objLineMinx, objpStart(1), objpEnd(1)]);
        objLineMaxx = max([objLineMaxx, objpStart(1), objpEnd(1)]);
        objLineMiny = min([objLineMiny, objpStart(2), objpEnd(2)]);
        objLineMaxy = max([objLineMaxy, objpStart(2), objpEnd(2)]);
    end

    isCollision = true;
    if LineMinx > objLineMaxx || LineMaxx < objLineMinx || ...
            LineMiny > objLineMaxy || LineMaxy < objLineMiny
        isCollision = false;
        return
    end
end

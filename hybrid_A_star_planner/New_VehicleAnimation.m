function New_VehicleAnimation(x,y,theta,psi,cfg,veh)
    sz=get(0,'screensize');
    figure('outerposition',sz);
    videoFWriter = VideoWriter('Parking.mp4','MPEG-4');
    open(videoFWriter);
    ObstList = cfg.ObstList;
    scatter(ObstList(:,1),ObstList(:,2),10,'r') % 画散点图
    hold on
    axis equal
    xlim([cfg.MINX,cfg.MAXX]);
    ylim([cfg.MINY,cfg.MAXY]);
    plot(x,y,'b') % 规划出来的轨迹，蓝色曲线   
    px = x(1);
    py = y(1);
    pth = theta(1);
    phi = psi(1);
    [vehx,vehy,vehtx,vehty,t_Pos] = getVehTran(px,py,pth,phi,veh); % 根据后轴中心的位姿计算车辆边框的位姿
    h1 = plot(vehx,vehy,'k'); % 车辆边框
    h2 = plot(px,px,'rx','MarkerSize',10); % 车辆后轴中心
    ht1 = plot(vehtx,vehty,'g');% 后车边框 
    ht2 = plot(t_Pos(1),t_Pos(2),'r+','MarkerSize',10); % 车辆后轴中心
    img = getframe(gcf);
    writeVideo(videoFWriter,img);
    for i = 2:length(theta)
        px = x(i);
        py = y(i);
        ptheta = theta(i);
        pth    = psi(i);
        [vehx,vehy,vehtx,vehty,t_Pos] = getVehTran(px,py,ptheta,pth,veh);
        h1.XData = vehx; % 更新h1图像句柄,把车辆边框四个角点的x坐标添加进去
        h1.YData = vehy;
        h2.XData = px; % 更新h2图像句柄,把车辆边框四个角点的y坐标添加进去
        h2.YData = py;
        ht1.XData = vehtx;
        ht1.YData = vehty;
        ht2.XData = t_Pos(1);
        ht2.YData = t_Pos(2);
        img = getframe(gcf);
        writeVideo(videoFWriter,img);
%         pause(0.005)
    end
    close(videoFWriter);
end

 % 根据后轴中心的位姿计算车辆边框的位姿
function [x,y,t_x,t_y,t_Pos] = getVehTran(x,y,theta,psi,veh)
    W = veh.W;
    LF = veh.LF;
    LB = veh.LB;
    
    % 车辆的边框由四个角点确定
    Cornerfl = [LF, W/2]; % 左前方角点
    Cornerfr = [LF, -W/2]; % 右前方角点
    Cornerrl = [-LB, W/2]; % 左后方角点
    Cornerrr = [-LB, -W/2]; % 右后方角点
    % 后车
    t_Cornerfl = [LF, W/2]; % 左前方角点
    t_Cornerfr = [LF, -W/2]; % 右前方角点
    t_Cornerrl = [-LB, W/2]; % 左后方角点
    t_Cornerrr = [-LB, -W/2]; % 右后方角点

    Pos = [x,y]; % 后轴中心坐标
    t_Pos    = Pos - [LF*cos(theta), LF*sin(theta)] - [LF*cos(psi), LF*sin(psi)];

    dcm = angle2dcm(-theta, 0, 0); % 计算四个角点的旋转矩阵,由于是刚体的一部分，旋转矩阵相同，将角度转换为方向余弦矩阵，旋转顺序是ZYX
    t_dcm = angle2dcm(-psi, 0, 0);

    tvec = dcm*[Cornerfl';0]; % 旋转变换，Cornerfl旋转后形成的列向量，位置向量3*1，最后一个是z坐标
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


    %rear vehicle
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
    % 返回车辆边框四个角点的x,y坐标
    x = [Cornerfl(1),Cornerfr(1),Cornerrr(1),Cornerrl(1),Cornerfl(1)];
    y = [Cornerfl(2),Cornerfr(2),Cornerrr(2),Cornerrl(2),Cornerfl(2)];

    t_x = [t_Cornerfl(1),t_Cornerfr(1),t_Cornerrr(1),t_Cornerrl(1),t_Cornerfl(1)];
    t_y = [t_Cornerfl(2),t_Cornerfr(2),t_Cornerrr(2),t_Cornerrl(2),t_Cornerfl(2)];
end
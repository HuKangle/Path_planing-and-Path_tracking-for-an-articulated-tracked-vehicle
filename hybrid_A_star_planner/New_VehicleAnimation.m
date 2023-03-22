function New_VehicleAnimation(x,y,theta,psi,cfg,veh)
    sz=get(0,'screensize');
    figure('outerposition',sz);
    videoFWriter = VideoWriter('Parking.mp4','MPEG-4');
    open(videoFWriter);
    ObstList = cfg.ObstList;
    scatter(ObstList(:,1),ObstList(:,2),10,'r') % ��ɢ��ͼ
    hold on
    axis equal
    xlim([cfg.MINX,cfg.MAXX]);
    ylim([cfg.MINY,cfg.MAXY]);
    plot(x,y,'b') % �滮�����Ĺ켣����ɫ����   
    px = x(1);
    py = y(1);
    pth = theta(1);
    phi = psi(1);
    [vehx,vehy,vehtx,vehty,t_Pos] = getVehTran(px,py,pth,phi,veh); % ���ݺ������ĵ�λ�˼��㳵���߿��λ��
    h1 = plot(vehx,vehy,'k'); % �����߿�
    h2 = plot(px,px,'rx','MarkerSize',10); % ������������
    ht1 = plot(vehtx,vehty,'g');% �󳵱߿� 
    ht2 = plot(t_Pos(1),t_Pos(2),'r+','MarkerSize',10); % ������������
    img = getframe(gcf);
    writeVideo(videoFWriter,img);
    for i = 2:length(theta)
        px = x(i);
        py = y(i);
        ptheta = theta(i);
        pth    = psi(i);
        [vehx,vehy,vehtx,vehty,t_Pos] = getVehTran(px,py,ptheta,pth,veh);
        h1.XData = vehx; % ����h1ͼ����,�ѳ����߿��ĸ��ǵ��x������ӽ�ȥ
        h1.YData = vehy;
        h2.XData = px; % ����h2ͼ����,�ѳ����߿��ĸ��ǵ��y������ӽ�ȥ
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

 % ���ݺ������ĵ�λ�˼��㳵���߿��λ��
function [x,y,t_x,t_y,t_Pos] = getVehTran(x,y,theta,psi,veh)
    W = veh.W;
    LF = veh.LF;
    LB = veh.LB;
    
    % �����ı߿����ĸ��ǵ�ȷ��
    Cornerfl = [LF, W/2]; % ��ǰ���ǵ�
    Cornerfr = [LF, -W/2]; % ��ǰ���ǵ�
    Cornerrl = [-LB, W/2]; % ��󷽽ǵ�
    Cornerrr = [-LB, -W/2]; % �Һ󷽽ǵ�
    % ��
    t_Cornerfl = [LF, W/2]; % ��ǰ���ǵ�
    t_Cornerfr = [LF, -W/2]; % ��ǰ���ǵ�
    t_Cornerrl = [-LB, W/2]; % ��󷽽ǵ�
    t_Cornerrr = [-LB, -W/2]; % �Һ󷽽ǵ�

    Pos = [x,y]; % ������������
    t_Pos    = Pos - [LF*cos(theta), LF*sin(theta)] - [LF*cos(psi), LF*sin(psi)];

    dcm = angle2dcm(-theta, 0, 0); % �����ĸ��ǵ����ת����,�����Ǹ����һ���֣���ת������ͬ�����Ƕ�ת��Ϊ�������Ҿ�����ת˳����ZYX
    t_dcm = angle2dcm(-psi, 0, 0);

    tvec = dcm*[Cornerfl';0]; % ��ת�任��Cornerfl��ת���γɵ���������λ������3*1�����һ����z����
    tvec = tvec';
    Cornerfl = tvec(1:2)+Pos; % ƽ�Ʊ任
    
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
    tvec = t_dcm*[t_Cornerfl';0]; % ��ת�任
    tvec = tvec';
    t_Cornerfl = tvec(1:2)+t_Pos; % ƽ�Ʊ任
    
    tvec = t_dcm*[t_Cornerfr';0];
    tvec = tvec';
    t_Cornerfr = tvec(1:2)+t_Pos;
    
    tvec = t_dcm*[t_Cornerrl';0];
    tvec = tvec';
    t_Cornerrl = tvec(1:2)+t_Pos;
    
    tvec = t_dcm*[t_Cornerrr';0];
    tvec = tvec';
    t_Cornerrr = tvec(1:2)+t_Pos; 
    % ���س����߿��ĸ��ǵ��x,y����
    x = [Cornerfl(1),Cornerfr(1),Cornerrr(1),Cornerrl(1),Cornerfl(1)];
    y = [Cornerfl(2),Cornerfr(2),Cornerrr(2),Cornerrl(2),Cornerfl(2)];

    t_x = [t_Cornerfl(1),t_Cornerfr(1),t_Cornerrr(1),t_Cornerrl(1),t_Cornerfl(1)];
    t_y = [t_Cornerfl(2),t_Cornerfr(2),t_Cornerrr(2),t_Cornerrl(2),t_Cornerfl(2)];
end
classdef New_Node < Node
    properties
        yaw_idx = 0;
        psi     = 0;
        gamma   = 0;
    end
        methods
        function obj = Node(xidx,yidx,yawidx,D,delta,x,y,theta,parent,cost) % 构造函数，声明的时候就定义了
            obj.xidx = xidx;
            obj.yidx = yidx;
            obj.yawidx = yawidx;
            obj.D = D;
            obj.delta = delta;
            obj.x = x;
            obj.y = y;
            obj.theta = theta;
            obj.parent = parent;
            obj.cost = cost;
        end
    end
end
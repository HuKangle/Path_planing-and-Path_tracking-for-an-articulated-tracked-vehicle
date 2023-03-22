function demo0_minimum_snap_simple()
%     clear,clc;
    xy= load('point_xy15.mat');
    waypts = [xy.path.x;xy.path.y];
    %% condition
%     waypts = [0,0;
%               1,2;
%               2,-1;
%               4,8;
%               5,2]';
    v0 = [3,0];
    a0 = [0,0];
    v1 = [-3,0];
    a1 = [0,0];
    T = 25;
    ts = arrangeT(waypts,T);
%     ts = new_arrangeT(waypts);
    n_order = 5;
    
    %% trajectory plan
    polys_x = minimum_snap_single_axis_close_form(waypts(1,:),ts,n_order,v0(1),a0(1),v1(1),a1(1));
    polys_y = minimum_snap_single_axis_close_form(waypts(2,:),ts,n_order,v0(2),a0(2),v1(2),a1(2));
    
    %% result show
    figure(32); hold on;
    figure(33); hold on;
    figure(34); hold on;
    figure(35); hold on;figure(36); hold on;figure(37); hold on;
    xx = [];
    yy = [];
    vxx =[];
    vyy =[]; 
    yaw = [0];
    d_yaw = [];
    axx = [];
    ayy = [];
    T_total  = [0];
%     K =[];
%     plot(waypts(1,:),waypts(2,:),'*r');hold on;
%     plot(waypts(1,:),waypts(2,:),'b--');
    title('minimum snap trajectory');
    color = ['grc'];
    for i=1:size(polys_x,2)
        delta_t = ts(i):0.01:ts(i+1);
        tt = delta_t(1:end);
        xx_int = polys_vals(polys_x,ts,tt,0);
        yy_int = polys_vals(polys_y,ts,tt,0);
        vxx_int = polys_vals(polys_x,ts,tt,1);
        axx_int = polys_vals(polys_x,ts,tt,2);
        jxx_int = polys_vals(polys_x,ts,tt,3);
        vyy_int = polys_vals(polys_y,ts,tt,1);
        ayy_int = polys_vals(polys_y,ts,tt,2);
        jyy_int = polys_vals(polys_y,ts,tt,3);
        yaw_int = atan(vyy_int./vxx_int);
        d_yaw_int = (ayy_int./vxx_int-axx_int.*vyy_int./vxx_int.^2)./(1+(vyy_int./vxx_int).^2);
%         K_int = abs(vxx_int.*ayy_int-axx_int.*vyy_int)./(vxx_int.*vxx_int+vyy_int.*vyy_int).^(3/2);
%         for j=1:length(tt)
%             if j ==1
%             d_yaw_int(1)=(yaw_int(1)-yaw(end))/(tt(1)-T_total(end));
%             else
%                 d_yaw_int(j) = (yaw_int(j)-yaw_int(j-1))/(tt(j)-tt(j-1));
%             end
%         end
        figure(32); plot(xx_int,yy_int,color(mod(i,3)+1));
        figure(33); plot(tt,vxx_int,color(mod(i,3)+1));
        figure(34); plot(tt,vyy_int,color(mod(i,3)+1));
        figure(35); plot(tt,yaw_int,color(mod(i,3)+1));
        figure(36); plot(tt,d_yaw_int,color(mod(i,3)+1));
%         figure(27); plot(tt,K_int,color(mod(i,3)+1));
        xx  = [xx xx_int];
        yy  = [yy yy_int];
        vxx = [vxx vxx_int];
        vyy = [vyy vyy_int];
        axx = [axx axx_int];
        ayy = [ayy ayy_int];
        yaw = [yaw yaw_int];
        d_yaw = [d_yaw d_yaw_int];
        T_total = [T_total tt];
%         K = [K K_int];
        clear xx_int yy_int vxx_int vyy_int yaw_int d_yaw_int
    end

    figure(2)
    vxx = polys_vals(polys_x,ts,tt,1);
    axx = polys_vals(polys_x,ts,tt,2);
    jxx = polys_vals(polys_x,ts,tt,3);
    vyy = polys_vals(polys_y,ts,tt,1);
    ayy = polys_vals(polys_y,ts,tt,2);
    jyy = polys_vals(polys_y,ts,tt,3);
    
    subplot(421),plot(tt,xx);title('x position');
    subplot(422),plot(tt,yy);title('y position');
    subplot(423),plot(tt,vxx);title('x velocity');
    subplot(424),plot(tt,vyy);title('y velocity');
    subplot(425),plot(tt,axx);title('x acceleration');
    subplot(426),plot(tt,ayy);title('y acceleration');
    subplot(427),plot(tt,jxx);title('x jerk');
    subplot(428),plot(tt,jyy);title('y jerk');
end


function polys = minimum_snap_single_axis_simple(waypts,ts,n_order,v0,a0,ve,ae)
p0 = waypts(1);
pe = waypts(end);

n_poly = length(waypts)-1;
n_coef = n_order+1;

% compute Q
Q_all = [];
for i=1:n_poly
    Q_all = blkdiag(Q_all,computeQ(n_order,3,ts(i),ts(i+1)));
end
b_all = zeros(size(Q_all,1),1);

Aeq = zeros(4*n_poly+2,n_coef*n_poly);
beq = zeros(4*n_poly+2,1);

% start/terminal pva constraints  (6 equations)
Aeq(1:3,1:n_coef) = [calc_tvec(ts(1),n_order,0);
                     calc_tvec(ts(1),n_order,1);
                     calc_tvec(ts(1),n_order,2)];
Aeq(4:6,n_coef*(n_poly-1)+1:n_coef*n_poly) = ...
                    [calc_tvec(ts(end),n_order,0);
                     calc_tvec(ts(end),n_order,1);
                     calc_tvec(ts(end),n_order,2)];
beq(1:6,1) = [p0,v0,a0,pe,ve,ae]';

% mid p constraints    (n_ploy-1 equations)
neq = 6;
for i=1:n_poly-1
    neq=neq+1;
    Aeq(neq,n_coef*i+1:n_coef*(i+1)) = calc_tvec(ts(i+1),n_order,0);
    beq(neq) = waypts(i+1);
end

% continuous constraints  ((n_poly-1)*3 equations)
for i=1:n_poly-1
    tvec_p = calc_tvec(ts(i+1),n_order,0);
    tvec_v = calc_tvec(ts(i+1),n_order,1);
    tvec_a = calc_tvec(ts(i+1),n_order,2);
    neq=neq+1;
    Aeq(neq,n_coef*(i-1)+1:n_coef*(i+1))=[tvec_p,-tvec_p];
    neq=neq+1;
    Aeq(neq,n_coef*(i-1)+1:n_coef*(i+1))=[tvec_v,-tvec_v];
    neq=neq+1;
    Aeq(neq,n_coef*(i-1)+1:n_coef*(i+1))=[tvec_a,-tvec_a];
end

Aieq = [];
bieq = [];

p = quadprog(Q_all,b_all,Aieq,bieq,Aeq,beq);

polys = reshape(p,n_coef,n_poly);

end
function polys = minimum_snap_single_axis_close_form(wayp,ts,n_order,v0,a0,v1,a1)
n_coef = n_order+1;
n_poly = length(wayp)-1;
% compute Q
Q_all = [];
for i=1:n_poly
    Q_all = blkdiag(Q_all,computeQ(n_order,3,ts(i),ts(i+1)));
end

% compute Tk   Tk(i,j) = ts(i)^(j-1)
tk = zeros(n_poly+1,n_coef);
for i = 1:n_coef
    tk(:,i) = ts(:).^(i-1);
end

% compute A (n_continuous*2*n_poly) * (n_coef*n_poly)
n_continuous = 3;  % 1:p  2:pv  3:pva  4:pvaj  5:pvajs
A = zeros(n_continuous*2*n_poly,n_coef*n_poly);
for i = 1:n_poly
    for j = 1:n_continuous
        for k = j:n_coef
            if k==j
                t1 = 1;
                t2 = 1;
            else %k>j
                t1 = tk(i,k-j+1);
                t2 = tk(i+1,k-j+1);
            end
            A(n_continuous*2*(i-1)+j,n_coef*(i-1)+k) = prod(k-j+1:k-1)*t1;
            A(n_continuous*2*(i-1)+n_continuous+j,n_coef*(i-1)+k) = prod(k-j+1:k-1)*t2;
        end
    end
end

% compute M
M = zeros(n_poly*2*n_continuous,n_continuous*(n_poly+1));
for i = 1:n_poly*2
    j = floor(i/2)+1;
    rbeg = n_continuous*(i-1)+1;
    cbeg = n_continuous*(j-1)+1;
    M(rbeg:rbeg+n_continuous-1,cbeg:cbeg+n_continuous-1) = eye(n_continuous);
end

% compute C
num_d = n_continuous*(n_poly+1);
C = eye(num_d);
df = [wayp,v0,a0,v1,a1]';% fix all pos(n_poly+1) + start va(2) + end va(2) 
fix_idx = [1:3:num_d,2,3,num_d-1,num_d];
free_idx = setdiff(1:num_d,fix_idx);
C = [C(:,fix_idx) C(:,free_idx)];

AiMC = inv(A)*M*C;
R = AiMC'*Q_all*AiMC;

n_fix = length(fix_idx);
Rff = R(1:n_fix,1:n_fix);
Rpp = R(n_fix+1:end,n_fix+1:end);
Rfp = R(1:n_fix,n_fix+1:end);
Rpf = R(n_fix+1:end,1:n_fix);

dp = -inv(Rpp)*Rfp'*df;

p = AiMC*[df;dp];

polys = reshape(p,n_coef,n_poly);

end

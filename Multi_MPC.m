V = 2;
OMEGA = 0;
x0 = [0; 0; 0; 0; 0]; 
u0 = [V 0 V OMEGA];

%%
% Discretize the continuous-time model using the zero-order holder method
% in the |obstacleVehicleModelDT| function.
Ts = 0.02;
[Ad,Bd,Cd,Dd,U,Y,X,DX] = ArticulatedVehicleModelDT(x0,u0);
dsys = ss(Ad,Bd,Cd,Dd,'Ts',Ts);
dsys.InputName = {'Vel','Hitch','ref_V','ref_yawrate'};
dsys.StateName = {'X','Y','Theta','Psi','Gamma'};
dsys.OutputName = dsys.StateName;
dsys = setmpcsignals(dsys,'MV',[1,2],'MD',[3 4]);
%% MPC Design at the Nominal Operating Point
% Design a model predictive controller that can make the ego car maintain
% a desired velocity and stay in the middle of the center lane.
status = mpcverbosity('off');
mpcobj_M_27 = mpc(dsys,Ts);
%% 
% The prediction horizon is |25| steps, which is equivalent to 0.5 seconds.
mpcobj_M_27.PredictionHorizon = 25;%25;
mpcobj_M_27.ControlHorizon = 5;%5;
%%
% To prevent the ego car from accelerating or decelerating too quickly, add
% a hard constraint of 0.2 (m/s^2) on the throttle rate of change.
mpcobj_M_27.ManipulatedVariables(1).Min = -4;
mpcobj_M_27.ManipulatedVariables(1).Max = 4;

mpcobj_M_27.ManipulatedVariables(2).Min = -0.5;
mpcobj_M_27.ManipulatedVariables(2).Max = 0.5;

mpcobj_M_27.ManipulatedVariables(1).RateMin = -5*Ts; 
mpcobj_M_27.ManipulatedVariables(1).RateMax = 5*Ts;

mpcobj_M_27.ManipulatedVariables(2).RateMin = -5*Ts; 
mpcobj_M_27.ManipulatedVariables(2).RateMax = 5*Ts;
%%
% Scale the throttle and steering angle by their respective operating
% ranges.
mpcobj_M_27.ManipulatedVariables(1).ScaleFactor = 3;
mpcobj_M_27.ManipulatedVariables(2).ScaleFactor = 0.2;

mpcobj_Modified.DisturbanceVariables(1).ScaleFactor = 3;
mpcobj_Modified.DisturbanceVariables(2).ScaleFactor = 0.1;

mpcobj_M_27.OutputVariables(1).ScaleFactor = 1;
mpcobj_M_27.OutputVariables(2).ScaleFactor = 1;
mpcobj_M_27.OutputVariables(3).ScaleFactor = 0.1;
mpcobj_M_27.OutputVariables(4).ScaleFactor = 0.1;
mpcobj_M_27.OutputVariables(5).ScaleFactor = 0.1;
%%
% Since there are only two manipulated variables, to achieve zero
% steady-state offset, you can choose only two outputs for perfect
% tracking. In this example, choose the Y position and velocity by setting
% the weights of the other two outputs (X and theta) to zero. Doing so lets
% the values of these other outputs float.
mpcobj_M_27.Weights.OutputVariables = [0.5 2 4 0.2 0];
mpcobj_M_27.Weights.ManipulatedVariables = [0, 0];
mpcobj_M_27.Weights.ManipulatedVariablesRate = [0.2, 0.2];
mpcobj_M_27.OutputVariables(5).Min = -0.6;
mpcobj_M_27.OutputVariables(5).Max = 0.6;
%% 
% Update the controller with the nominal operating condition. For a
% discrete-time plant:
%
% * |U = u0|
% * |X = x0|
% * |Y = Cd*x0 + Dd*u0|
% * |DX = Ad*X0 + Bd*u0 - x0|
%
mpcobj_M_27.Model.Nominal = struct('U',U,'Y',Y,'X',X,'DX',DX);
%%
% Use a constant reference signal.
% refSignal = [0 0 0 0];
%%
% Initialize plant and controller states.
% x = x0;
% u = u0;
% egoStates = mpcstate(mpcobj);

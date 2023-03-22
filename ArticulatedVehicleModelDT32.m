function [Ad,Bd,Cd,Dd,U,Y,X,DX] = ArticulatedVehicleModelDT32(x,u)
% The ego car has rectangular shaper with a length of 5 meters and width of
% 2 meters. The model has four states:
%
% * |xPos| - Global horizontal position of the car center
% * |yPos| - Global vertical position of the car center
% * |theta| - Heading angle of the car (0 when facing east, counterclockwise positive)
% * |V| - Speed of the car (positve)
%
% There are two manipulated variables:
%
% * |throttle| - Throttle (positive when accelerating, negative when braking)
% * |delta| - Steering angle change (counterclockwise positive)

%#codegen

% Define continuous-time linear model from Jacobian of the nonlinear model.
Ts = 0.02;
u  = u';
V  = u(1); 
gamma  = x(5);
ex     = x(1);
ey     = x(2);
etheta = x(3);
D = 4.92;L1=2.66; L2 = 2.26;
Ac = [0     V*sin(gamma)/D   0   0   0;
    -V*sin(gamma)/D      0   0   0   0;
     0      0       0   0   V/(L1+L2);
     0      0       0   0   V/(L1+L2);
     0      0       0   0   0];
 Bc = [1,    L2*ey/D,    -1,  0;
      sin(etheta),              -L2*ex/D,     0,  0;
     0,                L2/(L1+L2),  0,  -1;
     0,                -L1/(L1+L2), 0,  -1;
     0                 1,           0,  0];
Cc = eye(5);
Dc = zeros(5,4);
% Generate discrete-time model using ZOH.
[Ad, Bd] = adasblocks_utilDicretizeModel(Ac,Bc,Ts);
Cd = Cc;
Dd = Dc;
% Nominal conditions for discrete-time plant
X = x;
U = u;
Y = x;
DX = Ad*x+Bd*u-x;
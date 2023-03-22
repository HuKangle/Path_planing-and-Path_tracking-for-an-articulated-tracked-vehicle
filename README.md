# Path_planing-and-Path_tracking-for-an-articulated-tracked-vehicle
This repository is used to present the code for the study for the path planning and path tracking of an artiuclated tracked vehicle(ATV).
This work is implemented by the cosimulation platform as Simulink and Recurdyn.
The proposed controller is an adaptive controller, and it is compared with a switch MPC controller.
The control actions produced by the controller to the virtual vehicle model are the tracks rotating speed and the articuation angle rate at the hitch joint.
The planner for the ATV is obtained from the modified hybrid A* method, which considers the kinematic characteristic of the ATV and the reed-shepp curve.

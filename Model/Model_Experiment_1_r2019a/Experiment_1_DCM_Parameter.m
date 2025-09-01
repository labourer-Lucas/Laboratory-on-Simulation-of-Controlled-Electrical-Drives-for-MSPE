%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   File Name    :   Experiment_1_DCM_Parameter.m
%   Date         :   06.11.2017
% 
%   Chair of Electrical Drive Systems and Power Electronics
%   Technical University of Munich
%   Arcisstr. 21, 80333 Munich, Germany
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%
%--------------------------------------------------------------------------
%  ### DO NOT MAKE ANY CHANGES AT THIS SECTION! ###
%--------------------------------------------------------------------------

clc;
close all;
clear all;

%--------------------------------------------------------------------------
% Sampling time of the Model
dt = 1e-5;           % Step Size [s]
t_end = 2;           % Simulation Length [s]
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% Parameters of the Mangnetization Curve (nonlinear, without Hysteresis) 
% Psi_E/Psi_EN = a1*atan(I_E/I_EN) + a2*atan(2*I_E/I_EN) + a3*atan(3*I_E/I_EN)
a1 = -1.122;
a2 = 2.553;
a3 = -0.759;
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% Sensing (Current Measurement $ Position Detection)
EncoderLines = 4096;    % Resolution of the Encoder [1]
dt_omega = 5e-4;        % Sampling Time for the Angle Detection [s]

% Noise Characteristics of the Current Measurement
n_Igain = 0.075;        % Interanl Amplification of the Noise Generation [1]
n_Imax = 0.15;          % Maximum Noise Amplitude (Percent)[1]
n_Imin = -n_Imax;       % Minimum Noise Amplitude (Percent)[1]
%--------------------------------------------------------------------------


%%
%-------------------------------------------------------------------------
%  ### INSERT THE MISSING PARAMETER VALUES AT THIS SECTION ###
%--------------------------------------------------------------------------

% Direct Current Machine (DCM)

% Nominal Values of the Seperatly Excited DC Machine 
N_N = 2000;                 % Nominal Rotor Speed [RPM]
P_N = 200;                  % = Omega_N*M_MN (Mechanical) Nominal Power [W] 
M_MN = 0.955;     % Nominal Torque [Nm]
U_AN = 220;                 % Nominal Armature Voltage [V]    
I_AN = 1;                   % Nominal Armature Current [A]    
U_EN = 220;                 % Nominal Armature Current [A]]    
I_EN = 0.1;                 % Nominal Excitation Current [A]  

% Armature Current Circuit 
L_A = 374e-3;               % Inductance [H = Vs/A]
R_A = 22;                   % Resistance [Ohm = V/A]
T_A = L_A/R_A;              % Time Constant [s]

% Excitation Current Circuit  
R_E = 2200;                 % Resistance [Ohm]

% Mechanic
Theta_M = 0.0013;           % Rotor Inertia Moment [kg*m]
C_M = 0.96;                 % Machine Constant [1]
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% Electronic Actuation 
% without Approximation 
T_c = 1/1000;                  % Time Constant of the Carrier Signal [s]

% with PT1 Approximation
V_CON = 220;                % Amplification [V]
T_CON = T_c;                % Time Constant [s]
%--------------------------------------------------------------------------



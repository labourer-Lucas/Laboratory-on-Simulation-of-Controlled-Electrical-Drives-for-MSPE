%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   File Name    :   Experiment_2_DCM_Parameter.m
%   Date         :   08.11.2017
% 
%   Chair of Electrical Drive Systems and Power Electronics
%   Technical University of Munich
%   Arcisstr. 21, 80333 Munich, Germany
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
close all;
clear all;

%--------------------------------------------------------------------------
% Sampling time of the Model
dt = 5e-6;           % Step Size [s]
t_end = 2;           % Simulation Length [s]


%% ### PARAMETERS DRIVE SYSTEM ###

% Direct Current Machine (DCM)

% Nominal Values of the Seperatly Excited DC Machine 
N_N = 2000;                 % Nominal Rotor Speed [RPM]
Omega_MN = N_N*pi/30;       % Nominal Rotor Speed [rad/s]
P_N = 200;                  % Nominal Power [W] (Omega_N*M_MN)
M_MN = P_N/(N_N*pi/30);     % Nominal Torque [Nm]
U_AN = 220;                 % Nominal Armature Voltage [V]    
I_AN = 1;                   % Nominal Armature Current [A]   
I_A_max = 2;                % Maximum Armature Current [A]
U_EN = 220;                 % Nominal Armature Current [A]    
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
Psi_EN = 1;                 % Nominal Excitation Flux Linkage [Vs]
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% Electronic Actuation 
T_c = 1/1000;               % Switch Period [s]
U_dc = 220;                 % DC-Bus [V]
% with PT1 Approximation
V_CON = 220;                % Amplification [V]
T_CON = T_c;                % Time Constant [s]
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% Parameters of the Mangnetization Curve (nonlinear, without Hysteresis) 
% Psi_E/Psi_EN = a1*atan(I_E/I_EN) + a2*atan(2*I_E/I_EN) + a3*atan(3*I_E/I_EN)
a1 = -1.122;
a2 = 2.553;
a3 = -0.759;
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% Parameters of the Friction Curve (nonlinear, with static friction)
% M_R(Omega_M) = C_M*Psi_EN*(b1*sgn(Omega_M) + b2*atan(b3*Omega_M))
b1 = 0.0876;
b2 = 0.1030;
b3 = 4.8586;

%--------------------------------------------------------------------------
% Sensing (Current Measurement $ Position Detection)
EncoderLines = 4096;    % Resolution of the Encoder [1]
dt_omega = 5e-4;        % Sampling Time for the Angle Detection [s]

% Noise Characteristics of the Current Measurement
n_Igain = 0.075;        % Interanl Amplification of the Noise Generation [1]
n_Imax = 0.15;          % Maximum Noise Amplitude (Percent)[1]
n_Imin = -n_Imax;       % Minimum Noise Amplitude (Percent)[1]
%--------------------------------------------------------------------------



%% ### PARAMETER CONTROLLER ###
%--------------------------------------------------------------------------
% Measurment Value Filtering
T_f_I_A = 0.002;              % Time Constant PT1-Filter I_A [s]
T_f_I_E = 0.002;              % Time Constant PT1-Filter I_E [s]
T_f_Omega_M = 0.002;          % Time Constant PT1-Filter Omega [s] 
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% Current Controller:
V_S_I_A=V_CON/R_A;
T_n_I_A=T_A;
T_sigma_I_A=T_f_I_A+T_CON;

V_r_I_A=T_A/(2*V_S_I_A*T_sigma_I_A);
K_p_i=V_r_I_A;
K_i_i=V_r_I_A/T_n_I_A; %0.283/0.017

%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% Rotor Speed Controller
T_equ_I_A=2*T_sigma_I_A-T_f_I_A;%4ms
V_s_omega_m=R_A/(C_M*Psi_EN);%22.92
T_1_omega_m=(R_A*Theta_M)/(C_M*Psi_EN)^2;%31ms
T_sigma_omega_m=T_equ_I_A+T_f_Omega_M; %6ms
T_n_omega_m=4*T_sigma_omega_m; %24ms
V_r_omega_m=T_1_omega_m/(2*V_s_omega_m*T_sigma_omega_m); %0.113
K_p_omega=V_r_omega_m;
K_i_omega=V_r_omega_m/T_n_omega_m;
T_G=4*T_sigma_omega_m;


%--------------------------------------------------------------------------

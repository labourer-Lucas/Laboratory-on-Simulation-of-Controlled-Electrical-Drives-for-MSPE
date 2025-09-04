%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   File Name    :   Experiment_3_ASM_Parameter.m
%   Date         :   15.11.2017
% 
%   Chair of Electrical Drive Systems and Power Electronics
%   Technical University of Munich
%   Arcisstr. 21, 80333 Munich, Germany
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
close all;
clear all;

%--------------------------------------------------------------------------
dt = 1e-5;           % Step Size [s]
t_end = 1;           % Simulation Length [s]
%--------------------------------------------------------------------------

%% ### MODEL PARAMETERS OF THE INVESTIGATED ASYNCHRONOUS MACHINE ###

P_N = 2.2e3;                          % Nominal Power [W]
N_N = 2890;                           % Nominal Rotor Speed [RPM] 
omega_MN = N_N*pi/30;                 % Nominal Rotor Speed [rad/s]
M_MN = P_N / (N_N*pi/30);             % Nominal Torque [N.m]

L_m = 0.326;                          % Mutual Inductance between Stator and Rotor [H]

R_s = 2.2;                            % Stator Resistance [Ohm]
L_s = 0.340;                          % Stator Inductance [H]
L_sigma_s = L_s - L_m;                % Stator Leakage Inductance [H]

R_r = 2.9;                            % Rotor Resistance (transformed to Stator Coordinates) [Ohm]
L_r = 0.340;                          % Rotor Inductance (transformed to Stator Coordinates) [H]
L_sigma_r = L_r - L_m;                % Rotor Leakage Inductance (transformed to Stator Coordinates) [H]

sigma = (L_s*L_r - L_m^2)/(L_s*L_r);  % Leakage Coefficient [1]

p = 1;                                % Pole Pair Number [1]

Theta_M = 0.0022;                     % Rotor Inertia Moment [kg*m^2]



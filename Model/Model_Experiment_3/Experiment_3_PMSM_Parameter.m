%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   File Name    :   Experiment_3_PMSM_Parameter.m
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
dt = 5e-6;           % Step Size [s]
t_end = 3;           % Simulation Length [s]
%--------------------------------------------------------------------------


%% ### MODEL PARAMETERS OF THE INVESTIGATED SYNCHRONOUS MACHINE ###

Psi_PM = 0.36;          % Flux Linkage based on the Permanent Magnets [Vs]

R_s = 1.2;              % Stator Resistance [Ohm]
L_s = 12.e-3;           % Stator Inductance [H]

p = 3;                  % Pole Pair Number [1]
Theta_M = 1.0e-3;       % Rotor Inertia Moment [kg*m^2]

f_N = 100;              % Voltage Nominal Frequency with Symmetrical Sinusodial Feed [Hz]


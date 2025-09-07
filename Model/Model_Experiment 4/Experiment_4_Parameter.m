%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   File Name    :   Experiment_4_Parameter.m
%   Date         :   17.11.2017
% 
%   Chair of Electrical Drive Systems and Power Electronics
%   Technical University of Munich
%   Arcisstr. 21, 80333 Munich, Germany
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear all
close all

dt = 5e-6;                            % Step Size [s]
t_end = 1;                            % Simulation Length [s]

%% ### MODEL PARAMETERS OF THE INVESTIGATED ASYNCHRONOUS MACHINE ###

P_N = 2.2e3;                          % Nominal Power [W]
I_N = 4.5*sqrt(2);                    % Nominal Current [A]
N_N = 2890;                           % Nominal Rotor Speed [RPM]
omega_N = N_N*pi/30;                  % Nominal Rotor Speed [rad/s]
M_MN = P_N / omega_N;                 % Nominal Torque [Nm]
f_N = 50;                             % Nominal Frequency [Hz]

L_m = 0.326;                          % Mutual Inductance between Stator and Rotor [H]

R_s = 2.3;                            % Stator Resistance [Ohm]
L_s = 0.340;                          % Stator Indcuctance [H]
L_sigma_s = L_s - L_m;                % Stator Leakage Inductance [H]

R_r = 2.9;                            % Rotor Resistance (transformed to Stator Coordinates) [Ohm]
L_r  = 0.340;                         % Rotor Inductance (transformed to Stator Coordinates) [H]
L_sigma_r = L_r - L_m;                % Rotor Leakage Inductance (transformed to Stator Coordinates) [H]

sigma = (L_s*L_r - L_m^2)/(L_s*L_r);  % Leakage Coefficient [1]

R0 = R_s + L_m^2/L_r^2*R_r;           % Equivalent Resistance [Ohm]
R_prime=R0;
L_prime= sigma*L_s;
p = 1;                                % Pole Pair Number [1]
Theta_M = 0.0022;                     % Rotor Inertia Moment [kg*m^2]
Psi_rN = 0.95;                        % Nominal Value of the Rotor Flux Space Vector [Vs]


%% ## ELECTRONIC ACTUATION ##
T_c = 1/4000;                         % Carrier Period PWM [s]
U_dc = 560;                           % DC-Bus [V]
T_PE=T_c;
V_PE=U_dc/2;
%% ## SENSING ##
%--------------------------------------------------------------------------
% Sensing (Current Measurement $ Position Detection)
EncoderLines = 4096;    % Resolution of the Encoder [1]
dt_omega = 5e-4;        % Sampling Time for the Angle Detection [s]

% Noise Characteristics of the Current Measurement
n_Igain = 0.075;        % Interanl Amplification of the Noise Generation [1]
n_Imax = 0.15;          % Maximum Noise Amplitude (Percent)[1]
n_Imin = -n_Imax;       % Minimum Noise Amplitude (Percent)[1]
%--------------------------------------------------------------------------

% Smoothing of the Measurment Signals
T_f_omega_m = 2e-3;


%% ## CONTROLLER ##

% Plant Parameters of the Current Circuit
V_S_i=V_PE/R_prime;
T_sigma_i=T_PE;
T_1_i=L_prime/R_prime;
% Current Controller
V_C_i = T_1_i / (2*V_S_i*T_sigma_i);                          
T_n_i = T_1_i;                                            
K_p_i=V_C_i;
K_i_i=V_C_i/T_n_i;
T_equi_i = 2*T_sigma_i;  
% Plant Parameters of the Flux Circuit
V_psi=L_m;
T_sigma_psi=T_equi_i;
T_psi=L_r/R_r;
T_1_psi=T_psi;
% Flux Controller
V_C_psi=T_1_psi/(2*T_sigma_psi*V_psi);
T_n_psi=T_1_psi;
K_p_psi=V_C_psi;
K_i_psi=V_C_psi/T_n_psi;
% Plant Parameters of the Rotor Speed Circuit
V_S_omega_m= 3*pi*Psi_rN*f_N*L_m/(L_r*M_MN);
T_1_omega_m=Theta_M*2*pi*f_N / (p*M_MN);
T_sigma_omega_m=T_equi_i+T_f_omega_m;
% Rotor Speed Controller
V_C_omega=T_1_omega_m / (2*T_sigma_omega_m*V_S_omega_m);
T_n_omecga_m = 4*T_sigma_omega_m;
K_p_omega=V_C_omega;
K_i_omega=V_C_omega/T_n_omecga_m;




close all

%% plot settings

set(0,'DefaultFigureWindowStyle','docked')
set(0, 'DefaultLineLineWidth', 1.5);
set(0,'defaultAxesFontSize',13)
set(groot,'defaultAxesXGrid','on')
set(groot,'defaultAxesYGrid','on')

%% sim settings

N = 3600*1;  % sim time in sec
T = 1;  % sample time


std_dev_sat_pos = 10;

receiver_clock_drift = 1e-3;
receiver_clock_bias = c*receiver_clock_drift;

%%

constants

simulation
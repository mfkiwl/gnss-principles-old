
% everything in SI units
%% physical

c = 3e8;  % vacuum speed of light
mu = 3.986e14;  % earth gravitational parameter
Re = 6371e3;  % earth mean radius

%% sim

orbital_radius = 20e6 + Re;  % usual altitude of GNSS satellites + Earth's mean radius
orbital_period = 2*pi*sqrt(orbital_radius^3/mu);

Mdot = 2*pi/orbital_period;  % mean anomaly change
Omegadot = 2*pi/(24*60*60);  % Earth's radial velocity (rad/s)

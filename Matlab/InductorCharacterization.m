%{ 
Creator: AlledgedlyEngineering
Date: 2/7/2021
Tile: Inductor Characterization
Description: Plot recorded value to characterize an inductor used
in a TRIAC circuit for AC Motor Speed Control.

Equipment: 
 Oscilloscope: Siglent SDS1104X-E 100MHz 4Ch
 Frequency Generator: Krohn-hite Model 1600 3MHz
 DMM: Fluke 87V

Signal:
 Sinewave with 10[Vpp]

Circuit:

Function Generator
.-----------------|  
|       50 Ohm    |    Rref     Va2
|   .---^^^^-------*---^^^^^---*
|   |             | Va1        |
|   |             |            >
|  (~) Vin        |            > Resr
|   |             |            >
|   |             |            |
|   |             |            &
|   |             |            & L
|   |             |            &
|   |             |            |
|   '---------------- GND -----'
'-----------------'
%}
clc
clear all

% DC Resistance
Vdc = 4.983; % Volts
Idc = 0.567; % Amps
Rdc = Vdc/Idc;
fprintf('DC Resistance: %0.2f [V]\n', Rdc);

% Reference Resistor
Rref = 99.9; % ohms
fprintf('Reference Resistor: %0.1f [Ohms]\n', Rref);

% Data Points Collected
Va1 = [9.8, 10, 10.2, 10.0, 10,  10, 10, 10, 10, 10, 10, 10.2, 10.2, 10.2, 10.2, 10.2, 10.2, 10.2, 10.4 10.4, 10.4, 10.8, 11, 11.2, 11.4, 11.6, 12.2, 12.6, 13.6, 13.8, 14.4, 14.6, 15.4, 15.8]; % Volts
Va2 = [0.004, 0.0044, 0.0044, 0.0052, 0.0132,  0.0276, 0.0464, 0.0648, 0.1072, 0.1314, 0.246, 0.372, 0.472, 0.596, 0.704, 0.904, 1.12, 1.38, 1.62, 2.12, 3.18, 4.16, 5.04, 5.52, 6, 6.8, 8.08, 8.88, 10.88, 11.2, 12.16, 12.72, 13.4, 13.6]; % Volts
theta=[92.5, 92, 92.7, 91.4, 90.1,  -89.5, -89.2, -89.4, -89.5,-89.23, -83.11, -84.2, -82.2, -80.1, -80.4, -79.3, -77.75, -76.7, -75.2, -72.8, -67.4, -63.1, -57.2, -56.6, -54.7, -50.2, -45, -40.6, -30.3, -28.6, -21.5, -19.4, -10, -6]+90; % Deg
freq =[60, 100, 200, 300, 1000, 2000, 3500, 5000, 8100, 10000, 20000, 30000, 40000, 50000, 60000,80000, 100000, 125000, 150000, 200000, 300000, 400000, 500000, 550000 604000, 700000, 876639, 1*10^6, 1.41*10^6, 1.5*10^6, 1.8*10^6, 2.01*10^6, 2.5*10^6, 3*10^6]; % Hz



% Impedance [Ohms]
z = Va2*Rref ./ sqrt( (Va1.^2) - 2 * Va1 .* Va2 .* cosd(theta) + Va2.^2);
[val,indx] = max(z);
fprintf('Resonance Frequency: %.1f [kHz]\n', freq(indx)*10^-3); 

% Angle of Impedance [Degrees]
angle = theta - atand(-1*Va2.*sind(theta)/ (Va1-Va2.*cosd(theta)));

% Now we can convert to rectangular form ZZ of the impedance to find the
% resistance and capacitance. 
%       Z  = Resr + j*X    
%          => Resr + j*2*pi*freq*L 
%          => Z*cos(angle) + j*Z*sin(angle) %}

Resr = z .* cosd(angle);
L = z.*sind(angle) ./ (2 * pi * freq);

% Inductive Reactance
X = 2*pi.*freq.*L;


figure(1)
    subplot 231
    semilogx(freq, z), grid on;
    xlabel('Frequency [Hz]'), ylabel('Impedance [Ohms]');
    title('Inductor Impedance');
    
    subplot 232
    semilogx(freq, angle), grid on;
    xlabel('Frequency [Hz]'), ylabel('Phase [deg]');
    title('Angle of Impedance');
    
    subplot 233
    semilogx(freq, abs(L*10^6)), grid on;
    xlabel('Frequency [Hz]'), ylabel('Inductance [uH]');
    title('Inductance vs Frequency');
    
    subplot 234
    semilogx(freq, Resr), grid on;
    xlabel('Frequency [Hz]'), ylabel('Resr [Ohms]');
    title('Resr vs Frequency');
    
    subplot 235
    semilogx(freq, X), grid on;
    xlabel('Frequency [Hz]'), ylabel('Inductive Reactance [Ohms]');
    title('Reactance X_L vs Frequency');
    
    subplot 236
    semilogx(freq, (Va1-Va2)./Rref), grid on
    xlabel('Frequency [Hz]'), ylabel('Current [A]');
    title('Current over Rref');
    

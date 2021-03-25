%{
Creator: AlledgedEngineering
Date: 3/20/2021
Tile: Inductor Characterization
Description: Plot recorded value of the power factor at different potentiometer resistance amounts.
Collect values from LTspice.


%}
clc
clear all

% Data Points Collected
Rpot = [100, 158.5, 251.19, 398.1, 631, 1000, 1584.89, 2511.89, 3981.07, 6309.6, 10000, 15849, 25119, 39810, 63095, 100000, 158489, 251189, 300000]; % Potentiometer Resistance
PF = [0.8421, 0.8423, 0.8426, 0.8431, 0.8438, 0.8422, 0.8466, 0.8493, 0.8500, 0.8555, 0.8674, 0.8728, 0.8922, 0.9065, 0.8940, 0.8174, 0.6967, 0.4625, 0.4921]; % Power Factor


figure(1)
    plot(Rpot, PF), grid on;
    xlabel('Potentiometer Resistance [Ohms]'), ylabel('Power Factor');
    title('Power Factor vs Potentiometer Resistance');

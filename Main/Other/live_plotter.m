% Test script for loading .mat files and plotting new data
clear;
close all;
clc;

% Initialise variables
plot_data = [];
x = 1;
t = 1;
max_iterations = 65;  % Define loop termination condition

% Create figure for plotting
figure;
hold on;
xlabel('Time');
ylabel('Impedance Values');
title("Kiwi Impedance Values over Time");

% Continuous data loading and plotting loop
while t <= max_iterations
    data = load("arrdata.mat");
    matrix_values = data.arr;
    plot_data = [plot_data; matrix_values];  % Append new data
    
    % Plot data for 32 impedance values
    for i = 1:32
        plot(x, plot_data(:, i), '--');
    end
    
    pause(1);  % Pause to simulate real-time data acquisition
    t = t + 1;
    x = [x, t];
end

hold off;

% Normalise the impedance values
a = normalize(plot_data, 'range');

% Plot normalised impedance values
figure;
hold on;
for i = 1:32
    plot(x, a(:, i), '--');
end

xlabel('Time');
ylabel('Normalised Impedance Values');
title("Normalised Kiwi Impedance Values over Time");
hold off;

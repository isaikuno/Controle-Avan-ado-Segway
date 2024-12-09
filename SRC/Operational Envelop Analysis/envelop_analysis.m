%% Simulation %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;clc;
mdl = 'full_state_nonlinear_model.slx';


g_q = [0; 1];
mc = 1.5;                            % mass of the cart
mp = 0.5;                            % mass of the pendulum
g = 9.82;                            % gravity
L = 1;                               % length of the pendulum
d1 = 1e-2;                           % damping of the cart displacement
d2 = 1e-2;                           % damping of the joint

K_lqr = [-7.0711 83.7210 -9.6684 24.8294];

%initial_angle_conditions = -90:10:90;
%initial_angle_conditions = -200:10:-70;
initial_angle_conditions = -180:10:180;
initial_state_conditions = zeros(4, length(initial_angle_conditions));
initial_state_conditions(2, :) = deg2rad(initial_angle_conditions);

for i = 1:length(initial_angle_conditions)
    simulations(i) = Simulink.SimulationInput(mdl);
    simulations(i) = simulations(i).setModelParameter('StopTime', '200');
    simulations(i) = simulations(i).setModelParameter('TimeOut', 60);

    simulations(i) = simulations(i).setBlockParameter('full_state_nonlinear_model/Plant','x_0', mat2str(initial_state_conditions(:, i)));
    simulations(i) = simulations(i).setBlockParameter('full_state_nonlinear_model/Plant','g_q', 'g_q');

end

simout = sim(simulations);

%% Result Analysis %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create the figure and subplots once outside the loop
figure;
ax1 = subplot(2, 1, 1);      % Top subplot
hold(ax1, 'on');             % Enable multiple plots on this axis
xlabel(ax1, 'Time (s)');
ylabel(ax1, 'q1');
title(ax1, 'q1 over Time');

ax2 = subplot(2, 1, 2);      % Bottom subplot
hold(ax2, 'on');             % Enable multiple plots on this axis
xlabel(ax2, 'Time (s)');
ylabel(ax2, 'q2');
title(ax2, 'q2 over Time');
xlim([0 2]);

% Iterate through the simulation data
for sim_run_index = 1:length(simout)
    sim_time = simout(sim_run_index).tout;
    sim_q1 = simout(sim_run_index).logsout{1}.Values.Data;
    sim_q2 = simout(sim_run_index).logsout{3}.Values.Data;
    
    % Plot on the specific axes using their handles
    plot(ax1, sim_time, sim_q1, 'DisplayName', sprintf('Run %d', sim_run_index));
    plot(ax2, sim_time, sim_q2, 'DisplayName', sprintf('Run %d', sim_run_index));
end

% Add legends after the loop
%legend(ax1, 'show');
%legend(ax2, 'show');
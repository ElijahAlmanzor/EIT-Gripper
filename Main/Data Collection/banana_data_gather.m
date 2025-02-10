clear all;
clc;

% Initialise Arduino and Servo
a = arduino('COM7', 'Uno', 'Libraries', 'Servo');
s = servo(a, 'D3');

% Ensure the servo is in the initial position
writePosition(s, 0);

% Import UR RTDE interfaces
import py.rtde_receive.RTDEReceiveInterface;
import py.rtde_control.RTDEControlInterface;

% Establish RTDE connection
robot_ip = "169.254.189.21";
rtde_r = RTDEReceiveInterface(robot_ip);
rtde_c = RTDEControlInterface(robot_ip);

% Get robot state data
actual_q = rtde_r.getActualQ();
actual_tcp_pose = rtde_r.getActualTCPPose();

% Convert to MATLAB arrays
actual_q_array = cellfun(@double, cell(actual_q));
actual_tcp_pose_array = cellfun(@double, cell(actual_tcp_pose));

% Define movement positions
sideways_position = [-0.159, 0.118, 0.334, 0.093, -2.29, -2.1];

% Move robot to initial position
rtde_c.moveL(sideways_position);

% Experimental loop
num_trials = 10;
num_repetitions = 5;
before = zeros(num_trials, num_repetitions, 6);
after = zeros(num_trials, num_repetitions, 6);

for j = 1:num_repetitions
    for i = 1:num_trials
        % Open servo
        writePosition(s, 0);
        pause(3);

        % Wait until data file is available
        while true
            try
                data = load("arrdata.mat");
                break;
            catch
                disp("Could not load file, retrying...");
            end
        end
        before(i, j, :) = data.arr;

        % Close servo
        writePosition(s, 1);
        pause(10);

        % Wait until data file is available
        while true
            try
                data = load("arrdata.mat");
                break;
            catch
                disp("Could not load file, retrying...");
            end
        end
        after(i, j, :) = data.arr;

        pause(5);
        fprintf("Finished trial: %d\n", i);
    end
    fprintf("--------- CHANGE THE BANANA ---------\n");
    pause(20);
end

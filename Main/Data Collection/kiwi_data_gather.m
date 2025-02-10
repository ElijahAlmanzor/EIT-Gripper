% Clear workspace and connect to Arduino with a servo motor
clearvars;

% Connect to the Arduino
arduino_port = 'COM7';
a = arduino(arduino_port, 'Uno', 'Libraries', 'Servo');
s = servo(a, 'D3');
writePosition(s, 0);

% Load Python modules for robot control
import py.rtde_receive.RTDEReceiveInterface
import py.rtde_control.RTDEControlInterface

robot_ip = "169.254.189.10";
rtde_r = RTDEReceiveInterface(robot_ip);
rtde_c = RTDEControlInterface(robot_ip);

% Get actual joint positions and TCP pose
actual_q = rtde_r.getActualQ();
actual_tcp_pose = rtde_r.getActualTCPPose();

% Convert Python lists to MATLAB arrays
actual_q_array = cellfun(@double, cell(actual_q));
actual_tcp_pose_array = cellfun(@double, cell(actual_tcp_pose));

% Define movement positions
sideways_position = [-0.159, 0.118, 0.344, 0.093, -2.29, -2.1];
sideways_position_back = [-0.159, 0.063, 0.344, 0.093, -2.29, -2.1];

% Move above initial position
rtde_c.moveL(sideways_position);

% Loop through different orientations
num_orientations = 60;
step_size = 3;
for i = 1:step_size:num_orientations
    % Open gripper
    writePosition(s, 0);
    pause(4);
    
    % Capture before data
    for j = 0:2
        pause(1);
        while true
            try
                asd = load("arrdata.mat");
                break;
            catch
                disp("Could not load, Python still rewriting file. Trying again...");
            end
        end
        before(i + j, :) = asd.arr;
    end
    
    % Close gripper
    rtde_c.moveL(sideways_position);
    writePosition(s, 1);
    pause(4);
    
    % Capture after data
    for j = 0:2
        pause(1);
        while true
            try
                asd = load("arrdata.mat");
                break;
            catch
                disp("Could not load, Python still rewriting file. Trying again...");
            end
        end
        after(i + j, :) = asd.arr;
    end
    
    % Notify user to rotate the fruit
    disp("Finished current orientation:");
    disp(i);
    disp("--------- ROTATE THE FRUIT ---------");
    
    % Reset gripper before next iteration
    writePosition(s, 0);
    pause(3);
end

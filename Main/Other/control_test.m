clear;
clc;

% Connect to the Arduino and initialise the servo motor
a = arduino('COM7', 'Uno', 'Libraries', 'Servo');
s = servo(a, 'D3');
writePosition(s, 0);  % Ensure servo starts in the open position

% Load Python modules for controlling the robot
import py.rtde_receive.RTDEReceiveInterface;
import py.rtde_control.RTDEControlInterface;

% Establish RTDE connection with the robot
robot_ip = "169.254.189.10";
rtde_r = RTDEReceiveInterface(robot_ip);
rtde_c = RTDEControlInterface(robot_ip);

% Get robot state data
actual_q = rtde_r.getActualQ();
actual_tcp_pose = rtde_r.getActualTCPPose();

% Convert to MATLAB arrays
actual_q_array = cellfun(@double, cell(actual_q));
actual_tcp_pose_array = cellfun(@double, cell(actual_tcp_pose));

% Move robot to initial position
position1 = [-0.3, 0.35, 0.4, -0.001, 3.12, 0.04];
rtde_c.moveL(position1);

% Move robot to next position
position2 = [-0.3, 0.35, 0.5, -0.001, 3.12, 0.04];
rtde_c.moveL(position2);

% Close gripper (infinite loop removed for safety)
writePosition(s, 1);

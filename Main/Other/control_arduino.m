clear all;
clc;

% Test code for controlling a servo motor through Arduino library
a = arduino('COM7', 'Uno', 'Libraries', 'Servo');
s = servo(a, 'D3');

% Open gripper
writePosition(s, 0);
pause(5);

% Close gripper
writePosition(s, 1);
pause(10);

% Open gripper again
writePosition(s, 0);

% Test Python RTDE library integration with MATLAB
import py.rtde_receive.RTDEReceiveInterface;
import py.rtde_control.RTDEControlInterface;

% Connect to UR Robot
robot_ip = "169.254.189.10";
rtde_r = RTDEReceiveInterface(robot_ip);
rtde_c = RTDEControlInterface(robot_ip);

clear all
close all
clc

n = 6005;
t = 7.257079;
gamma = 0.1;
epsilon = 0;
type = 0;
driven = 0;
% n = 6e4;
% t = 8*pi;
% epsilon = [0,1,0];
% gamma = [0.1,0,0];
% driven = [0,1,0];
% type = 23;


% figure
% hold on
% axis equal
% for i = 1:3
% 	[x,y] = oscillator(n,t,gamma(i),epsilon(i),type,driven(i));
% 	plot(x,y)
% end
[x,y] = oscillator(n,t,gamma,epsilon,type,driven);

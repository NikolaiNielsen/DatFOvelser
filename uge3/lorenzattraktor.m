clear all
close all
clc


figure
hold on
[x,y,z] = lorenz(1,1,1,30,0.001,0.001);

for i= 1:length(x)
	plot3(x(i),y(i),z(i),'b.')
	pause(0.001)
end
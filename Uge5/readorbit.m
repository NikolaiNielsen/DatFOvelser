clear all
clc
close all


fil = 'orbit.dat';
pos = read_orbit(fil,0);

v = VideoWriter('my_animation.avi');
open(v)
x = squeeze(pos(1,:,:));
y = squeeze(pos(2,:,:));
z = squeeze(pos(3,:,:));


[dims,nobs,time] = size(pos);
fig = figure
hold on
title('LPK331')
for i = 1:time
	% plot the first object
	plot(x(1,1:i),y(1,1:i),'r')
	
	% plot the second object
	plot(x(2,1:i),y(2,1:i),'b')
	
	% plot the second object
	plot(x(3,1:i),y(3,1:i),'g')
	writeVideo(v,getframe(fig))
	
	
end
hold off
close(v);
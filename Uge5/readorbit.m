clear all
clc
close all


fil = 'orbit.dat';

fileID = fopen(fil);
num_ops = fscanf(fileID,'%e\n',[1 1]);

sizeA = [3,Inf];
A = fscanf(fileID,'%e',sizeA);

fclose(fileID);

num_t = numel(A)/(3*num_ops);
A = reshape(A,[3*num_ops num_t])';

x = zeros(num_t,num_ops);
y = x;
z = x;

pos = zeros(3,num_ops,num_t);


for i = 1:num_ops
% 	start = 3*i-2
% 	stop = start+2
	x(:,i) = A(:,3*i-2);
	y(:,i) = A(:,3*i-1);
	z(:,i) = A(:,3*i);
% 	pos(1,:,i) = A(:,3*i-2);
% 	pos(2,:,i) = A(:,3*i-1);
% 	pos(3,:,i) = A(:,3*i);
	
end
pos(1,:,:) = x';
pos(2,:,:) = y';
pos(3,:,:) = z';

figure
hold on
for i = 1:num_ops
	plot3(x(:,i),y(:,i),z(:,i))
end
xlabel('x')
ylabel('y')

% pos = read_orbit(fil)

% 
% B = zeros(num_t,3*num_objects);
% 
% for i = 1:3
% 	for j = 1:3
% 		start = 3*j-2
% 		stop = start+2
% 	end
% end
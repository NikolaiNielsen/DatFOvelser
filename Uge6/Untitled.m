clear all
clc

v = [1 2 3 4; 0 0 0 0];
for i = 1:4
	v2(:,:,i) = v; 
end

vtemp = v2;
for i = 1:4
	vd(:,:,i) = vtemp(:,i,:);
end
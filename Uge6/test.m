% %% Test af hele script
clear all
clc

profile on
for i = 1:2
	orbit
end
profile off
profile viewer


%% Test af enkelte funktioner
clear all
global G
m = [3 4 5 7 2 5];
m2 = [m;m;m];
v = [1 2 3 4 5 6; 0 0 0 0 0 0; 0 0 0 0 0 0];
%v=[0.5 0.2 0.1 0.4 0.3 0.6; 0.5 0.2 0.1 0.4 0.3 0.6; 0 0 0 0 0 0];
v2(:,:,1) = v;
for i = 2:6
	m2(:,:,i) = m2(:,:,1);
	v2(:,:,i) = v(:,:,1);
end

r=	[1 -2  1  2  0  1;...
	 3 -1 -1  1 -3  0;...
	 0  0  0  0  0  0];     % initial data
G = 1;

s=size(r);
rv=zeros(s(1),s(2),s(2));

for j=1:s(2)
	for k=1:s(2)
		rv(:,j,k)=r(:,j)-r(:,k);
	end
end

rl = rvlen(rv);
rlref = rvlenref(rv);

% profile on
% for i = 1:3000

s = size(rv);

r1 = rl.^-3;
r2 = rl.^-5;
r1(isinf(r1)) = 0;
r2(isinf(r2)) = 0;

vtemp = v2;
vd = v2;
for i = 1:s(2)
	vd(:,:,i) = vtemp(:,i,:);
end

d = zeros(s);
d(1,:,:) = dot(rv,vd);

for i = 2:s(1)
	d(i,:,:) = d(1,:,:);
end

accdot1 = -G*m2.*(vd.*r1 - 3.*rv.*d.*r2);
accdot = sum(accdot1,3);

adotref = aac_fullref(m,rv,rlref,v);


% profile off
% profile viewer
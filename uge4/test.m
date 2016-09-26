%% test af rvec.m og rvlen.m

clear all
close all
clc

r = eye(3); %r(2,2) = 2; r(3,3) = 3;

rv = rvec(r);


rv1(:,:,1) = [1 2 3 4; 5 6 7 8; 0 9 8 1];
rv1(:,:,2) = [0 1 2 3; 4 5 6 7; 8 0 9 8];
rv1(:,:,3) = [1 2 2 4; 5 1 7 2; 0 4 8 1];
rv1(:,:,4) = [5 2 3 4; 5 6 8 8; 0 9 5 1];

rl = rvlen(r);
rl2 = rvlen(rv);
rl3 = rvlen(rv1);


%% Hyggeg hyggepwiojedrfaieurhj med acceleration.
clear all
close all
clc

r = eye(3);% r(2,2) = 2; r(3,3) = 3;

rv = rvec(r);
rl = rvlen(rv);

global G
G = 1;
m = [1 2 3];
acc = accvec(m,rv,rl);
	
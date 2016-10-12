%% test af rvec.m og rvlen.m

clear all
close all
clc

r_test=[1 -2 1 2 0 1; 3 -1 -1 1 -3 0; 0 0 0 0 0 0];%eye(3); %r(2,2) = 2; r(3,3) = 3;
m_test=[3 4 5 7 2 5];
global G
G = 1;

rv_test = rvec(r_test);


% rv1(:,:,1) = [1 2 3 4; 5 6 7 8; 0 9 8 1];
% rv1(:,:,2) = [0 1 2 3; 4 5 6 7; 8 0 9 8];
% rv1(:,:,3) = [1 2 2 4; 5 1 7 2; 0 4 8 1];
% rv1(:,:,4) = [5 2 3 4; 5 6 8 8; 0 9 5 1];

rl_test = rvlen(rv_test);
% rl2 = rvlen(rv);
% rl3 = rvlen(rv1);
acc_test = accvec(m_test,rv_test,rl_test);

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

% onesies = ones(size(rl,2),1);
% rl2d = zeros(size(rv));
% for i = 1:size(rl,2);
% 	rl2d(:,:,i) = (onesies*rl(i,:))';
% end
% 
% for i = 1:length(m)
% 	% Vi starter med et 0
% 	A = zeros(length(m),1);
% 	for j = 1:size(rv,2)
% 		% Hvis vi prøver at finde accelerationen fra den i'te vektor springer vi over
% 		if i == j
% 			continue
% 		end
% 
% 		A = A+(m(j).*rv(:,i,:)./(rl2d(:,i,:).^3));
% 	end
% 	acc(:,i) = -G .* A;
% end

%% Accvec med Klaus' data

clear all
close all
clc

r = [1 2 3 4; 5 6 7 8; 0 9 8 1];
m = [2 3 1 6];
rv = rvec(r);
rl = rvlen(rv);
global G
G = 2;
acc = accvec(m,rv,rl);

% for i = 1:length(m)
% 		% Vi starter med et 0 for A. Dette er en 3x1 søjlevektor (ét element for hvert koordinat)
% 		A = zeros(3,1);
% 		for j = 1:size(rv,2)
% 			% Hvis vi prøver at finde accelerationen fra den i'te vektor springer vi over
% 			if i == j
% 				continue
% 			end
% 		
% 			A = A+(m(j).*rv(:,i,j)./(rl(i,j).^3));
% 		end
% 		acc(:,i) = -G .* A;
% 	end


%% Test af dtval.m

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
adt = circshift(acc,[1,1]);
dt = dtval(acc,adt);

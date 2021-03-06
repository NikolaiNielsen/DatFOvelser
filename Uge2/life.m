clear all; close all; clc

len =8;
n = 9;
T = 0.5;
liv{1} = rand(len,len)>T;
% liv = [ 0 0 0 0 0;
% 		0 0 0 0 0;
% 		0 1 1 1 0;
% 		0 0 0 0 0;
% 		0 0 0 0 0];


subplot(2,5,1);
colormap gray
axis image
imagesc(liv{1})

for i = 2:n+1
tl	= circshift(liv{i-1},[ 1, 1]);
t	= circshift(liv{i-1},[ 1, 0]);
tr	= circshift(liv{i-1},[ 1,-1]);
l	= circshift(liv{i-1},[ 0, 1]);
r	= circshift(liv{i-1},[ 0,-1]);
bl	= circshift(liv{i-1},[-1, 1]);
b	= circshift(liv{i-1},[-1, 0]);
br	= circshift(liv{i-1},[-1,-1]);
buddybuddy = tl+t+tr+l+r+bl+b+br;

die = (((buddybuddy > 3) | (buddybuddy < 2)) & (liv{i-1} ~= 0));
born = (buddybuddy == 3) & (liv{i-1} == 0);
survive = (buddybuddy == 3) | (buddybuddy == 2);

liv{i} = liv{i-1} + born - die;
% x = mod(i,5);
% if x == 0
% 	x = 5;
% end
% y = ceil(i/5);
subplot(2,5,i);
colormap gray
axis image
axis equal
imagesc(liv{i})

end

%% Jellyboy

clear all; close all; clc

% len =8;
n = 15;
% T = 0.5;
% liv{1} = rand(len,len)>T;
% liv = [ 0 0 0 0 0;
% 		0 0 0 0 0;
% 		0 1 1 1 0;
% 		0 0 0 0 0;
% 		0 0 0 0 0];
liv{1} = zeros(10);
jellystart = [	0 1 0 0 1;
				0 1 0 1 0;
				0 0 1 0 0;
				0 0 0 1 1;
				0 0 0 0 0];
liv{1}(6:10,1:5) = jellystart;


subplot(4,4,1);
colormap gray
axis image
imagesc(liv{1})

for i = 2:n+1
tl	= circshift(liv{i-1},[ 1, 1]);
t	= circshift(liv{i-1},[ 1, 0]);
tr	= circshift(liv{i-1},[ 1,-1]);
l	= circshift(liv{i-1},[ 0, 1]);
r	= circshift(liv{i-1},[ 0,-1]);
bl	= circshift(liv{i-1},[-1, 1]);
b	= circshift(liv{i-1},[-1, 0]);
br	= circshift(liv{i-1},[-1,-1]);
buddybuddy = tl+t+tr+l+r+bl+b+br;

die = ((liv{i-1} ~= 0) & ((buddybuddy == 3) | (buddybuddy >= 6) | (buddybuddy <= 1)) );
born = (buddybuddy == 3) & (liv{i-1} == 0);
survive = (buddybuddy == 4) | (buddybuddy == 2) | (buddybuddy == 5);

liv{i} = liv{i-1} + born - die;
liv{i+16} = born+survive;
% x = mod(i,5);
% if x == 0
% 	x = 5;
% end
% y = ceil(i/5);
subplot(4,4,i);
colormap gray
axis image
imagesc(liv{i})

end

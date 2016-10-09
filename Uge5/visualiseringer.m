%% Visualisering i 2d

clear all
close all
clc

subplot
% Skal disse ting plottes? 1 = ja.
Imagesc		=	0;
Surf		=	0;
Surfc		=	0;
Surfl		=	0;
Quiver		=	0;
Streams		=	0; % Plottes kun, hvis Quiver == 1;

x = linspace(0,4*pi);
y = linspace(0,4*pi,50);

xx = x'*ones(1,length(y));
yy = ones(length(x),1)*y;

s = sin(xx).*cos(yy);
vx = sin(yy);
vy = cos(xx);

% Image scaled color
if Imagesc == 1
	figure
	hold on
	title('imagesc')
	imagesc(x,y,s);
	colorbar;
	hold off
end

% surface
if Surf == 1
	figure
	hold on
	axis equal
	title('surf')
	surf(xx,yy,s)
	hold off
end

% surf contour
if Surfc == 1
	figure
	hold on
	axis equal
	title('surfc')
	surfc(xx,yy,s)
	hold off
end

% Surf lighting
if Surfl == 1
	figure
	hold on
	axis equal
	title('surfl')
	surfl(xx,yy,s)
	hold off
end

if Quiver == 1
	figure
	hold on
	title('quiver')
	axis equal
	quiver(xx,yy,vx,vy)
	% Streams fungerer sgu ikke lige
% 	if Streams == 1
% 		title('quiver + streamlines')
% 		streamline(xx,yy,vx,vy,1,2)
% 	end
	hold off
end


%% Visualisering i 3d

% clear all
% clc

StreamLine		=		0;
Quiver3			=		1;
Iso				=		0;

[x2,y2,z2,s2] = flow;
% x = linspace(0,4*pi);
% y = x;
% z = x;
% [xx,yy,zz] = meshgrid(x); 
vx2 = sin(x2);
vy2 = cos(y2);
vz2 = cos(z2);

if StreamLine == 1
	figure
	hold on
	axis equal
	title('streamline')
	sline = 0:0.1:10;
	streamline(x2,y2,z2,vx2,vy2,vz2,sline,sline,sline)
	hold off
end

if Quiver3 == 1
	figure
	hold on
	axis equal
	title('quiver3')
	quiver3(x2,y2,z2,vx2,vy2,vz2)
	hold off
	view(23,25)
	
end

if Iso == 1
	figure
	hold on
	axis equal
	title('isosurface')
	for i = -1:0.5:1
		isosurface(x2,y2,z2,s2,i)
	end
	colorbar
	view(-25,25)
	hold off
end


%% Hent kraniet!

clear all
clc

brain = 0;

if brain == 1
	brain = ones(256,256,20);
	for i = 1:20
		% Genererer filnavnet - der skal bruges padded zeros (3 lang, i alt)
		file = sprintf('dicom_images/brain_%03d',i);
		brain(:,:,i) = dicomread(file);
	end
	figure
	hold on
	title('isosurface brain')
	isosurface(brain,100)
	hold off
end

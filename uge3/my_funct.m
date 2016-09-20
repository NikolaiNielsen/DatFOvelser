function [x2d,y2d] = my_funct(x,y)
	
% 	x1 = ones(size(x));
% 	y1 = ones(size(y));
% 	x2d = x'*y1;
% 	y2d = x1'*y;
if nargin == 1
	% her er y2d = x2d'. og vi kan egentlig bare dublikere x-vektoren 
	% length(x) gange, og transponere om nødvendigt.
	for i = 1:length(x)
		for j = 1:length(x)
			x2d(i,j) = x(i);
			y2d(i,j) = x(j);
		end
	end
elseif nargin == 2
	for i = 1:length(x)
		for j = 1:length(y)
			x2d(i,j) = x(i);
			y2d(i,j) = y(j);
		end
	end
end
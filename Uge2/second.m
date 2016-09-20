clear all; close all; clc
a = [1 1 1 0];
b = [2 1e4 1 1];
c = [1 1 1 1];
format short

a = a(3);
b = b(3);
c = c(3);

disc = sqrt(b.^2-4.*a.*c);
if a == 0	% Først tjekkes det om a er 0, hvilket giver en førstegradsligning
	x1 = -c/b;
	x2 = x1;
else
	rot = [(-b + disc)/(2*a),(-b - disc)/(2*a)];
	if isreal(rot)
		[max,maxi] = max(abs(rot));
		[min,mini] = min(abs(rot));
		rot(mini) = c/(a*rot(maxi));
		x1 = rot(1);
		x2 = rot(2);
	else
		x1 = rot(1);
		x2 = rot(2);
	end
end
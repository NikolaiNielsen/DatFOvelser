% clear all; close all; clc
% a = [1 1 1 0];
% b = [2 1e4 1 1];
% c = [1 1 1 1];
% format short

% a = a(2);
% b = b(2);
% c = c(2);

disc = sqrt(b.^2-4.*a.*c);
% x1 = zeros(length(a),1);
% x2 = x1;

% for i=1:length(a)
if a(i) == 0	% Først tjekkes det om a er 0, hvilket giver NaN
% 	x1(i) = NaN
% 	x2(i) = NaN
	x1 = NaN
	x2 = NaN
else
% elseif isreal(disc(i))
% 	x1(i) = (-b(i) + disc(i))/(2*a(i))
% 	x2(i) = (-b(i) - disc(i))/(2*a(i))
	x1 = (-b(i) + disc(i))/(2*a(i))
	x2 = (-b(i) - disc(i))/(2*a(i))
end
% end
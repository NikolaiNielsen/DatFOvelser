clear all
clc
format long

x = 0:10:10000;

% plot(single(x),eps(single(x)));

clear all
format long
a = single(1);
c = single(1);
b = single(2);
for q = 1:10
	q
	b = b + single(1*10^(-q))
	x = [(-b + sqrt(b^2-4*a*c))/(2*a), (-b - sqrt(b^2-4*a*c))/(2*a)]
end
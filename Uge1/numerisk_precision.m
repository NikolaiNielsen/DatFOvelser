clear all
clc
format long
a = single(1);
c = single(1);
b = single(10);
for q = 1:50
	q
	b = single(1*10^(q))
	x = [(-b + sqrt(b^2-4*a*c))/(2*a), (-b - sqrt(b^2-4*a*c))/(2*a)]
	[m,i] = max(abs(x));
	x1 = c/(a*x(i))
end
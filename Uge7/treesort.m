clear all
clc

% F�rst laves en liste af 1-10 i tilf�ldig r�kkef�lge
%l = 1:10;
%l = l(randperm(length(l)));
l = [6 4 4 7 2 5 1 3 9 8];

s = [];

for i = 1:length(l)
	s = buildtree(s,l(i));
end
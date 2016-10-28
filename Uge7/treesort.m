clear all
clc

% Først laves en liste af 1-10 i tilfældig rækkefølge
l = randi(100,25,1);
l = l(randperm(length(l)));
% l = [6 4 4 7 2 5 1 1 3 9 8];

s = [];

for i = 1:length(l)
	s = buildtree(s,l(i));
end

arr = [];

while length(arr) < length(l)
	arr = readtree(s,arr);

end
%% rvec
function rv=rvec(race)
% calculate the distance between points (assumes r(3,#))
% where # represents the number of different vectors.
s = [size(race) size(race,2)];
rv = zeros(s);
tempdist = zeros(s(1),s(3));
for race1 = 1:s(2)
	tempdist(1,:) = race(1,race1);
	tempdist(2,:) = race(2,race1);
	rv(:,race1,:) = tempdist-race;
end
end
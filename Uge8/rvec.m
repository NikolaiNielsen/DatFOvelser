%% rvec
function rv=rvec(r1,r2)
% calculate the distance between points (assumes r(3,#))
% where # represents the number of different vectors.
s = [size(r1) size(r2,2)];
rv=zeros(s);

rv = zeros(s);
tempdist = zeros(s(1),s(3));
for race1 = 1:s(2)
	tempdist(1,:) = r1(1,race1);
	tempdist(2,:) = r1(2,race1);
	rv(:,race1,:) = tempdist-r2;
end
end
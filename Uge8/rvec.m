%% rvec
function rv=rvec(pos)
	% calculate the distance between points (assumes r(2,#))
	% where # represents the number of different vectors.
	s = [size(pos) size(pos,2)];
	rv = zeros(s);
	tempdist = zeros(s(1),s(3));
	for race1 = 1:s(2)
		tempdist(1,:) = pos(1,race1);
		tempdist(2,:) = pos(2,race1);
		rv(:,race1,:) = tempdist-pos;
	end
end
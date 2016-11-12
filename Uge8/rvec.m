function rv = rvec(pos)
	s = [size(pos) size(pos,2)];
	rv = zeros(s);
	tempdist = zeros(s(1:2));
	for race1 = 1:s(2)
		tempdist(1,:) = pos(1,race1);
		tempdist(2,:) = pos(2,race1);
		rv(:,race1,:) = tempdist-pos;
	end
end
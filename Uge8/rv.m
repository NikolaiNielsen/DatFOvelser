function r = rv(r)
	pos = r.pos;
	s = [size(pos) size(pos,2)];
	r.rv = zeros(s);
	tempdist = zeros(s(1:2));
	for race1 = 1:s(2)
		tempdist(1,:) = pos(1,race1);
		tempdist(2,:) = pos(2,race1);
		r.rv(:,race1,:) = tempdist-pos;
	end

	r.rvlen = squeeze(sqrt(r.rv(1,:,:).^2+r.rv(2,:,:).^2));
end
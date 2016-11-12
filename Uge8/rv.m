function r = rv(r)

	% This function calculates the separation vectors between all cells in the
	% simulation, and outputs it as a (2,n,n) array, along with the length of
	% these vectors as an (n,n) array.

	% We load in the positions and get the correct sizes
	pos = r.pos;
	s = [size(pos) size(pos,2)];

	% Initialize the separation array and a temp array for the calculations
	r.rv = zeros(s);
	tempdist = zeros(s(1:2));
	for race1 = 1:s(2)
		% the tempdist holds the positions of the cells for calculation
		tempdist(1,:) = pos(1,race1);
		tempdist(2,:) = pos(2,race1);
		r.rv(:,race1,:) = tempdist-pos;
	end

	% Oneliner to calculate the magnitude of these vectors.
	% It's a (1,n,n) array so we squeeze the first dimension out.
	r.rvlen = squeeze(sqrt(r.rv(1,:,:).^2+r.rv(2,:,:).^2));
end
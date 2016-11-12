function r = edgecase(r,pos1)

	% This function handles cells going out-of-bounds (oob) by flipping the
	% necessary velocity components (x if it's oob at the sides, y if top or
	% bottom). It also calculates the "new" position of the particle, such
	% that it stays within the world.

	% logical array of which cells are oob.
	oob = r.pos <= 0 | r.pos >= r.side;

	% We only do the calculations if there are any out of bounds cells
	if ~isempty(oob)
		% A matrix of 1's and -1's to indicate which velocity components
		% needs to be flipped is used to update the velocity.
		% r.oob is a logical array, and r.oob*(-2)+1 has -1 for flipped
		% components, and 1 for non-flipped components
		r.vel = r.vel.*(oob*(-2)+1);
		% update the position with new velocity vectors so it gets inside again
		r.pos = pos1 + r.vel*r.dt;
	end

end
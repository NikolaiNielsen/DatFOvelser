function r = edgecase(r,pos1)
	oob = r.pos <= 0 | r.pos >= r.side;

	if ~isempty(oob)
		% A matrix of 1's and -1's to indicate which velocity components
		% needs to be flipped is used to update the velocity.
		% r.oob is a logical array, and r.oob*(-2)+1 has -1 for flipped
		% components, and 1 for non-flipped components
		r.vel = r.vel.*(oob*(-2)+1);
		% update the position with new velocity vectors.
		r.pos = pos1 + r.vel*r.dt;
	end

end
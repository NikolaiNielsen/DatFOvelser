function [vel,pos] = edgecase(r,dt)

	oob = r.pos(:,:,i) <= 0 | r.pos(:,:,i) >= stor(1);
	vel = r.vel;
	pos = r.pos(:,:,i);
	if ~isempty(oob)
		% A matrix of 1's and -1's to indicate which velocity components
		% needs to be flipped is used to update the velocity.
		% r.oob is a logical array, and r.oob*(-2)+1 has -1 for flipped
		% components, and 1 for non-flipped components
		vel = vel.*(oob*(-2)+1);
		% update the position with new velocity vectors.
		pos = r.pos(:,:,i-1) + vel*dt;
	end

end
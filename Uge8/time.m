function r = time(r)

	% This function checks whether or not the time counter should be updated
	% for the cells (if r.t == 0). If this is the case the resetTime for the
	% given race is loaded into the time counter.

	% Iterate over the cells and check if a reset is needed
	for i = 1:length(r.race);
		if r.tally(1,i)

			% If it's r1 panic or secondary panic we revert to r1 base state
			if r.race(i) == 3 || r.race(i) == 4
				r.race(i) = 1;

			% If it's r1 sick or r2 hunting we revert to r2 base state
			elseif r.race(i) == 5 || r.race(i) == 6
				r.race(i) = 2;
			end

			% Also, we reset the time
			r.t(i) = r.resetTime(r.race(i));
		end
	end
end
function r = time(r)

	% This function checks whether or not the time counter should be updated
	% for the cells (if r.t == 0). If this is the case the resetTime for the
	% given race is loaded into the time counter.

	% A vector of the resetTimes for the cells that need updating.
	newtimes = r.tally.*r.resetTime(r.race);
	% We just add it to r.t, as all newtimes == 0 is r.t ~= 0 and vice versa.
	r.t = r.t+newtimes;

	% All panicing cells that need updating. Revert to r1 base state
	newRace1 = r.tally & (r.race == 3 | r.race == 4);
	r.race(newRace1) = 1;

	% Same as above, but for sick r1 and hunting r2. Revert to r2 base.
	newRace2 = r.tally & (r.race == 5 | r.race == 6);
	r.race(newRace2) = 2;

end
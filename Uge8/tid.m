function t = tid(r)
	tally = r.tally(1,:);
	race = r.race;
	resetTime = r.resetTime;
	n = length(race);
	t = r.t;
	for i = 1:n
		if tally(i)
			t(i) = resetTime(race(i));
		end
	end

end
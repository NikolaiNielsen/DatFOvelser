function t = tid(r)
	t = r.t;
	for i = 1:length(r.race);
		if r.tally(1,i)
			t(i) = r.resetTime(r.race(i));
		end
	end

end
function r = tid(r)
	for i = 1:length(r.race);
		if r.tally(1,i)
			if r.race(i) == 3 || r.race(i) == 4
				r.race(i) = 1;
			elseif r.race(i) == 5 || r.race(i) == 6
				r.race(i) = 2;
			end
			r.t(i) = r.resetTime(r.race(i));
		end
	end
end
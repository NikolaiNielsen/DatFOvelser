function [t,race] = tid(r)
	t = r.t;
	race = r.race;
	for i = 1:length(r.race);
		if race(i) == 3 || race(i) == 4
			race(i) = 1;
		elseif race(i) == 5 || race(i) == 6
			race(i) = 2;
		end
		if r.tally(1,i)
			t(i) = r.resetTime(r.race(i));
		end
	end

end
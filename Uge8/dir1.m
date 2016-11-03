function speed = dir1(race,i)
	n = length(race.t);
	speed = zeros(2,n);
	for j = 1:n
		if race.tally(j,end)
			race.dir(j) = rand()*2*pi;
			if race.race(j) == 1
				speed(1,j) = race.v_f1 * cos(race.dir(j));
				speed(2,j) = race.v_f1 * sin(race.dir(j));
			elseif race.race(j) == 2
				speed(1,j) = race.v_f2 * cos(race.dir(j));
				speed(2,j) = race.v_f2 * sin(race.dir(j));
			end

		end
	end
end
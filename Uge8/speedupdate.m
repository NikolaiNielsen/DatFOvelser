function speed = speedupdate(r)
	n = length(r.t);
	speed = r.speed(:,:);
	race = r.race;
	for j = 1:n
		if r.tally(1,j)
			r.dir(j) = rand()*2*pi;
			speed(1,j) = r.Hast(race(j)) * cos(r.dir(j));
			speed(2,j) = r.Hast(race(j)) * sin(r.dir(j));
		end
	end
end
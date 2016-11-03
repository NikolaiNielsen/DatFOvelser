function speed = speedupdate(r)
	speed = r.speed(:,:);
	for j = 1:length(r.t);
		if r.tally(1,j)
			r.dir(j) = rand()*2*pi;
			speed(1,j) = r.Hast(r.race(j)) * cos(r.dir(j));
			speed(2,j) = r.Hast(r.race(j)) * sin(r.dir(j));
		end
	end
end
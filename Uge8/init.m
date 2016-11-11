function r = init(r)


	r.start(1,:) = rand(r.n(1)+r.n(2),1)*r.side;
	r.start(2,:) = rand(r.n(1)+r.n(2),1)*r.side;
	r.race(1:r.n(1)) = 1;
	r.race(r.n(1)+1:r.n(1)+r.n(2)) = 2;
	r.r1 = r.race == 1;
	r.r2 = r.race == 2;

	r.pos(:,:,1) = r.start;
	r.dir = rand(1,r.n(1)+r.n(2))*2*pi;
	r.vel(1,r.r1,1) = r.speed(1) * cos(r.dir(r.r1));
	r.vel(2,r.r1,1) = r.speed(1) * sin(r.dir(r.r1));
	r.vel(1,r.r2,1) = r.speed(2) * cos(r.dir(r.r2));
	r.vel(2,r.r2,1) = r.speed(2) * sin(r.dir(r.r2));
	r.t(r.r1) = r.resetTime(1);
	r.t(r.r2) = r.resetTime(2);
end
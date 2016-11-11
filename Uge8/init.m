function r = init(r,n1,n2,v_f1,v_f2,t_f1,t_f2,side)


	r.start(1,:) = rand(n1+n2,1)*r.side;
	r.start(2,:) = rand(n1+n2,1)*r.side;
	r.race(1:n1) = 1;
	r.race(n1+1:n1+n2) = 2;
	r.racelog(1,:) = r.race;
	r.r1 = r.race == 1;
	r.r2 = r.race == 2;

	r.pos(:,:,1) = r.start;
	r.dir = rand(1,n1+n2)*2*pi;
	r.vel(1,r.r1,1) = v_f1 * cos(r.dir(r.r1));
	r.vel(2,r.r1,1) = v_f1 * sin(r.dir(r.r1));
	r.vel(1,r.r2,1) = v_f2 * cos(r.dir(r.r2));
	r.vel(2,r.r2,1) = v_f2 * sin(r.dir(r.r2));
	r.t(r.r1) = t_f1;
	r.t(r.r2) = t_f2;
end
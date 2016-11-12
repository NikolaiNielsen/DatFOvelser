function r = nextstep(r,lastpos)
	r.pos = lastpos+r.vel*r.dt;

end
function p = plotter(r,del,p)
	if del == 1
		delete(p.r1);
		delete(p.r2);
		delete(p.r3);
	end
	p.r1 = scatter(r.pos(1,r.race == 1),r.pos(2,r.race == 1),r.dot_size,r.col(1),'filled');
	p.r2 = scatter(r.pos(1,r.race == 2),r.pos(2,r.race == 2),r.dot_size,r.col(2),'filled');
	p.r3 = scatter(r.pos(1,r.race == 3),r.pos(2,r.race == 3),r.dot_size,r.col(3),'filled');
	drawnow
end
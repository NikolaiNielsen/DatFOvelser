function p = plotter(r,del,p)
	if del == 1
		delete(p.r1);
		delete(p.r2);
		delete(p.r3);
		delete(p.r4);
		delete(p.r5);
		delete(p.r6);
	end
	p.r1 = scatter(r.pos(1,r.race == 1),r.pos(2,r.race == 1),r.dot_size,r.col(1),'filled');
	p.r2 = scatter(r.pos(1,r.race == 2),r.pos(2,r.race == 2),r.dot_size,r.col(2),'filled');
	p.r3 = scatter(r.pos(1,r.race == 3),r.pos(2,r.race == 3),r.dot_size,r.col(3),'filled');
	p.r4 = scatter(r.pos(1,r.race == 4),r.pos(2,r.race == 4),r.dot_size,r.col(4),'filled');
	p.r5 = scatter(r.pos(1,r.race == 5),r.pos(2,r.race == 5),r.dot_size,r.col(5),'filled');
	p.r6 = scatter(r.pos(1,r.race == 6),r.pos(2,r.race == 6),r.dot_size,r.col(6),'filled');
	drawnow
end
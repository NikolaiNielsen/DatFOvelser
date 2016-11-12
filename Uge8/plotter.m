function p = plotter(r,del,p)

	% This function handles all the plotting (except for figure titles)

	% If i>1 then del == 1, and we delete the last plots from the figure, so it
	% looks like an animation
	if del == 1
		delete(p.r1);
		delete(p.r2);
		delete(p.r3);
		delete(p.r4);
		delete(p.r5);
		delete(p.r6);
	end

	% Next we do the 6 scatter plots. One for each state. put them in the p
	% struct
	p.r1 = scatter(r.pos(1,r.race == 1),r.pos(2,r.race == 1),...
					r.dot_size, r.col(1), 'filled');
	p.r2 = scatter(r.pos(1,r.race == 2),r.pos(2,r.race == 2),...
					r.dot_size, r.col(2), 'filled');
	p.r3 = scatter(r.pos(1,r.race == 3),r.pos(2,r.race == 3),...
					r.dot_size, r.col(3), 'filled');
	p.r4 = scatter(r.pos(1,r.race == 4),r.pos(2,r.race == 4),...
					r.dot_size, r.col(4), 'filled');
	p.r5 = scatter(r.pos(1,r.race == 5),r.pos(2,r.race == 5),...
					r.dot_size, r.col(5), 'filled');
	p.r6 = scatter(r.pos(1,r.race == 6),r.pos(2,r.race == 6),...
					r.dot_size, r.col(6), 'filled');

	% If i == 1 then del ~=1 and it's the first plot. Then we set the axis and
	% add a legend.
	if del ~= 1
		legend('R1 base','R2 base','R1 panic',...
				'R1 panic 2','R1 sick','R2 hunting',...
				'location','eastoutside')
		axis([0 r.side 0 r.side])
	end
	drawnow
end
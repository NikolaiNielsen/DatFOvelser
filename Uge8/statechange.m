function r = statechange(r)
	% The purpose of this function is to calculate the field of vision for the different cells
	% The way this is done is by using the dot product of the separation vector and velocity vector, to calculate the angle between these. This allows us to calculate whether or not a cell should flee, die, get sick, give chase or what have you.
	race = r.race;
% 	r1 = race == 1;
% 	r2 = race == 2;
% 	panic = race == 3;
% 	spanic = race == 4;
% 	sick = race == 5;
% 	hunt = race == 6;
	n = length(race);

	% Slamkoder et forloop
	for in = 1:n
		inRace = race(in);

		% Healthy race 1
		if inRace == 1
			vin = r.vel(:,in);
			for out = 1:n
				outRace = race(out);
				vout = r.vel(:,out);
				% If it's race 2
				if outRace == 2 || outRace == 6
					% cell dies
					if r.rvlen(in,out) <= r.r1rad(3)
						% Calculates the cosine of the angle between v2 and r21, to check whether 1 is in 2's fov.
						cosang = (dot(vout,r.rv(:,in,out)))/(r.rvlen(in,out)*r.Hast(outRace));
						if cosang >= r.vis(outRace)
							newrace = 2;
							r.t(in) = r.resetTime(newrace);
							r.race(in) = newrace;
							break;
						end
					% Cell gets sick
					elseif r.rvlen(in,out) <= r.r1rad(2);
						% Calculates the cosine of the angle between v2 and r21, to check whether 1 is in 2's fov.
						cosang = (dot(vout,r.rv(:,in,out)))/(r.rvlen(in,out)*r.Hast(outRace));
						if cosang >= r.vis(outRace)
							newrace = 5;
							r.vel(:,in) = -r.Hast(newrace)*r.vel(:,in);
							r.t(in) = r.resetTime(newrace);
							r.race(in) = newrace;
							break;
						end
					% Cell panics
					elseif r.rvlen(in,out) <= r.r1rad(1)
						% Calculates the cosine of the angle between v1 and r12, to check whether 2 is in 1's fov.
						cosang = (dot(vin,r.rv(:,out,in)))/(r.rvlen(in,out)*r.Hast(inRace));
						if cosang >= r.vis(inRace)
							newrace = 3;
							r.vel(:,in) = -r.Hast(newrace)*r.vel(:,in);
							r.t(in) = r.resetTime(newrace);
							r.race(in) = newrace;
							break;
						end
					end
				elseif outRace == 3
					if r.rvlen(in,out) <= r.r1rad(4)
						% Calculates the cosine of the angle between v1 and r12, to check whether 2 is in 1's fov.
						cosang = (dot(vin,r.rv(:,out,in)))/(r.rvlen(in,out)*r.Hast(inRace));
						if cosang >= r.vis(inRace)
							newrace = 4;
							r.t(in) = r.resetTime(newrace);
							r.race(in) = newrace;
							r.dir(in) = rand()*2*pi;
							vel(1,in) = r.Hast(newrace) * cos(r.dir(in));
							vel(2,in) = r.Hast(newrace) * sin(r.dir(in));
							break;
						end
					end
				end
			end
		% elseif inRace == 2

		% Race 1 in panic.
		elseif inRace == 3
			for out = 1:n
				outRace = race(out);
				% If it's race 2
				if outRace == 2 || outRace == 6
					% cell dies
					if r.rvlen(in,out) <= r.r1rad(3)
						% Calculates the cosine of the angle between v2 and r21, to check whether 1 is in 2's fov.
						cosang = (dot(vout,r.rv(:,in,out)))/(r.rvlen(in,out)*r.Hast(outRace));
						if cosang >= r.vis(outRace)
							newrace = 2;
							r.t(in) = r.resetTime(newrace);
							r.race(in) = newrace;
							break;
						end

					% Cell gets sick but doesn't turn around
					elseif r.rvlen(in,out) <= r.r1rad(2);
						% Calculates the cosine of the angle between v2 and r21, to check whether 1 is in 2's fov.
						cosang = (dot(vout,r.rv(:,in,out)))/(r.rvlen(in,out)*r.Hast(outRace));
						if cosang >= r.vis(outRace)
							newrace = 5;
							r.vel(:,in) = (r.Hast(newrace)/r.Hast(inRace))*r.vel(:,in);
							r.t(in) = r.resetTime(newrace);
							r.race(in) = newrace;
							break;
						end
					end
				end
			end

		% R1 secondary panic
		elseif inRace == 4
			for out = 1:n
				outRace = race(out);
				% If it's race 2
				if outRace == 2 || outRace == 6
					% cell dies
					if r.rvlen(in,out) <= r.r1rad(3)
						cosang = (dot(vout,r.rv(:,in,out)))/(r.rvlen(in,out)*r.Hast(outRace));
						if cosang >= r.vis(outRace)
							newrace = 2;
							r.t(in) = r.resetTime(newrace);
							r.race(in) = newrace;
							break;
						end
					% Cell gets sick, but doesn't turn around
					elseif r.rvlen(in,out) <= r.r1rad(2);
						cosang = (dot(vout,r.rv(:,in,out)))/(r.rvlen(in,out)*r.Hast(outRace));
						if cosang >= r.vis(outRace)
							newrace = 5;
							r.vel(:,in) = (r.Hast(newrace)/r.Hast(inRace))*r.vel(:,in);
							r.t(in) = r.resetTime(newrace);
							r.race(in) = newrace;
							break;
						end
					end
				end
			end
		end
	end


end
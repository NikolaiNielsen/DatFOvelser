function r = statechange(r)

  % The purpose of this function is to calculate the field of vision for the
  % different cells.
  % The way this is done is by using the dot product of the separation vector
  % and velocity vector, to calculate the angle between these. This allows us
  % to calculate whether or not a cell should flee, die, get sick, give chase
  % or what have you.

  % This file uses 2 spaces as indentation because of the long lines and many
  % indentations.
  race = r.race;
  n = length(race);

  % I'm so, so sorry.
  for in = 1:n
    inRace = race(in);
    vin = r.vel(:,in);

    % Healthy race 1
    if inRace == 1
      for out = 1:n
        outRace = race(out);
        vout = r.vel(:,out);
        % If it's race 2 (normal or hunting) one of them dies
        if outRace == 2 || outRace == 6
          % We check if it's inside the death radius
          if r.rvlen(in,out) <= r.r1rad(3)
            % Calculates the cosine of the angle between v2 and r21, to check
            % whether 1 is in 2's fov.
            cosang = (dot(vout,r.rv(:,in,out)))...
                      /(r.rvlen(in,out)*r.speed(outRace));
            % if 1 is in 2s fov, 1 transforms to a 2. We break after this,
            % because there's no reason to loop over any more
            if cosang >= r.vis(outRace)
              newrace = 2;
              r.t(in) = r.resetTime(newrace);
              r.race(in) = newrace;
              break;

            % If 1 is outside of 2's fov, 2 transforms to a 1. We *don't*
            % break after this, as this doesn't affect r1.
            else
              newrace = 1;
              r.t(out) = r.resetTime(newrace);
              r.race(out) = newrace;
            end

          % We check if it's in the sick radius
          elseif r.rvlen(in,out) <= r.r1rad(2);
            % Calculates the cosine of the angle between v2 and r21, to check
            % whether 1 is in 2's fov.
            cosang = (dot(vout,r.rv(:,in,out)))...
                      /(r.rvlen(in,out)*r.speed(outRace));
            % if r1 is in r2s fov, we get sick and break the loop. Again, no
            % more need to loop
            if cosang >= r.vis(outRace)
              newrace = 5;
              r.vel(:,in) = -r.speed(newrace)*r.vel(:,in);
              r.t(in) = r.resetTime(newrace);
              r.race(in) = newrace;
              break;
            end

          % Panic radius
          elseif r.rvlen(in,out) <= r.r1rad(1)
            % Calculates the cosine of the angle between v1 and r12, to check
            % whether 2 is in 1's fov.
            cosang = (dot(vin,r.rv(:,out,in)))...
                      /(r.rvlen(in,out)*r.speed(inRace));
            % if we panic we break.
            if cosang >= r.vis(inRace)
              newrace = 3;
              r.vel(:,in) = -r.speed(newrace)*r.vel(:,in);
              r.t(in) = r.resetTime(newrace);
              r.race(in) = newrace;
              break;
            end
          end

        % if it's panicing we go into secondary panic. Give new direction too
        elseif outRace == 3
          if r.rvlen(in,out) <= r.r1rad(4)
            % Calculates the cosine of the angle between v1 and r12, to check
            % whether 2 is in 1's fov.
            cosang = (dot(vin,r.rv(:,out,in)))...
                      /(r.rvlen(in,out)*r.speed(inRace));
            if cosang >= r.vis(inRace)
              newrace = 4;
              r.t(in) = r.resetTime(newrace);
              r.race(in) = newrace;
              r.dir(in) = rand()*2*pi;
              vel(1,in) = r.speed(newrace) * cos(r.dir(in));
              vel(2,in) = r.speed(newrace) * sin(r.dir(in));
              break;
            end
          end
        end
      end

    % Race 2 base. This only checks for chases, as death is handled by the
    % other races' checks.
    elseif inRace == 2
      % Logical arrays of all victims that are in rance
      victims = r.race == 1 | r.race == 3 | r.race == 4 | r.race == 5;
      dists = r.rvlen(in,:) <= r.r2rad;
      distvicts = dists & victims;
      num = sum(distvicts);
      contenders = [];
      % If there are any potential victims we calculate the angles to check
      % whether they're in the fov.
      if num ~= 0
        for out = 1:n
          if distvicts(out)
            cosang = (dot(vin,r.rv(:,out,in)))...
                      /(r.rvlen(in,out)*r.speed(inRace));
            if cosang >= r.vis(inRace)
              contenders(1,end+1) = dists(out);
              contenders(2,end+1) = out;
            end
          end
        end
        % If there are any contenders in fov we pick the closest one to chase.
        if ~isempty(contenders)
          [~,outIndex] = min(contenders(1,:));
          r.chase(in) = contenders(2,outIndex);
          r.t(in) = r.resetTime(6);
          r.race(in) = 6;
        end
      end


    % Race 1 in panic.
    elseif inRace == 3
      for out = 1:n
        outRace = race(out);
        vout = r.vel(:,out);
        % If it's race 2
        if outRace == 2 || outRace == 6
          % cell dies
          if r.rvlen(in,out) <= r.r1rad(3)
            % Calculates the cosine of the angle between v2 and r21, to check
            % whether 1 is in 2's fov.
            cosang = (dot(vout,r.rv(:,in,out)))...
                      /(r.rvlen(in,out)*r.speed(outRace));
            if cosang >= r.vis(outRace)
              newrace = 2;
              r.t(in) = r.resetTime(newrace);
              r.race(in) = newrace;
              break;

            % If 1 is outside of 2's fov, 2 dies
            else
              newrace = 1;
              r.t(out) = r.resetTime(newrace);
              r.race(out) = newrace;
            end

          % Cell gets sick but doesn't turn around
          elseif r.rvlen(in,out) <= r.r1rad(2);
            % Calculates the cosine of the angle between v2 and r21, to check
            % whether 1 is in 2's fov.
            cosang = (dot(vout,r.rv(:,in,out)))...
                      /(r.rvlen(in,out)*r.speed(outRace));
            if cosang >= r.vis(outRace)
              newrace = 5;
              r.vel(:,in) = (r.speed(newrace)/r.speed(inRace))*r.vel(:,in);
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
        vout = r.vel(:,out);
        % If it's race 2
        if outRace == 2 || outRace == 6
          % cell transforms to r2
          if r.rvlen(in,out) <= r.r1rad(3)
            cosang = (dot(vout,r.rv(:,in,out)))...
                      /(r.rvlen(in,out)*r.speed(outRace));
            if cosang >= r.vis(outRace)
              newrace = 2;
              r.t(in) = r.resetTime(newrace);
              r.race(in) = newrace;
              break;

            % If 1 is outside of 2's fov, 2 transforms to r1
            else
              newrace = 1;
              r.t(out) = r.resetTime(newrace);
              r.race(out) = newrace;
            end

          % Cell gets sick, but doesn't turn around
          elseif r.rvlen(in,out) <= r.r1rad(2);
            cosang = (dot(vout,r.rv(:,in,out)))...
                      /(r.rvlen(in,out)*r.speed(outRace));
            if cosang >= r.vis(outRace)
              newrace = 5;
              r.vel(:,in) = (r.speed(newrace)/r.speed(inRace))*r.vel(:,in);
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
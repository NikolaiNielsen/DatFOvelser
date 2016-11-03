clear all
close all
clc

% Variable!
dt = 1;				% Tidsskridtet
vis = 90;			% Synsfelt i grader.
stor = [100 100]; 	% Spillebrættets størrelse
ptime = 0.1;		% Pausetid
tend = 50;
dot_size = 10;

% For race 1:
n1 = 25;			% Antal individer af race 1
v_f1 = 0.5;			% Normal hastighed for race 1
t_f1 = 10;			% Antal tidsskridt, som race 1 bevæger sig i en given retning
r_panik = 10;		% Panikafstand for race 1. Skal være mindre end r_f2
t_panik = 15;		% Paniktid for race 1
t_pp = 10;			% Sekundær panik (panik fra at se et andet individ i panik)
r_die1 = 5;			% Afstand mellem r1 og r2, hvor race 1 dør
r1.col = 'g';		% Farven af individer

% For race 2:
n2 = 50;			% Antal individer af race 2
v_f2 = 0.2;			% Normal hastighed for race 2
t_f2 = 3;			% ligeledes for race 2.
r_f2 = 15;			% Spotradius for race 2.
t_fol = 10;			% Tidsskridt race 2 forfølger i.
r_die2 = 5;			% Afstand hvor r2 dør.
r2.col = 'r';		% Farven af individer

%% Lav startposition:
r1.start(1,:) = rand(n1,1)*stor(1);
r1.start(2,:) = rand(n1,1)*stor(2);

r2.start(1,:) = rand(n2,1)*stor(1);
r2.start(2,:) = rand(n2,1)*stor(2);

r1.pos(:,:,1) = r1.start;
r1.dir = rand(n1,1)*2*pi;
r1.speed(1,:) = v_f1 * cos(r1.dir);
r1.speed(2,:) = v_f1 * sin(r1.dir);
r1.t(1:n1) = t_f1;

r2.pos(:,:,1) = r2.start;
r2.dir = rand(n2,1)*2*pi;
r2.speed(1,:) = v_f2 * cos(r2.dir);
r2.speed(2,:) = v_f2 * sin(r2.dir);
r2.t(:,n2) = t_f2;
rv = rvec(r1.pos(:,:,1),r2.pos(:,:,1));

%%


figure
hold on
p1 = scatter(r1.pos(1,:,1),r1.pos(2,:,1),dot_size,r1.col,'filled');
p2 = scatter(r2.pos(1,:,1),r2.pos(2,:,1),dot_size,r2.col,'filled');
axis([0 100 0 100])
pause(ptime)
for i = 2:tend
	rv = rvec(r1.pos(:,:,1),r2.pos(:,:,1));


	% Vi tæller ned i antallet af trin til retningsskift
	r1.t = r1.t-1;
	r2.t = r2.t-1;

	% Tjekker hvilke der er 0
	r1.tally = r1.t == 0;
	r2.tally = r2.t == 0;

	% Finder ny retning for disse, og opdater hastigheden
	for j = 1:n1
		if r1.tally(j)
			r1.dir(j) = rand()*2*pi;
			r1.speed(1,j) = v_f1 * cos(r1.dir(j));
			r1.speed(2,j) = v_f1 * sin(r1.dir(j));
		end
	end
	for j = 1:n2
		if r2.tally(j)
			r2.dir(j) = rand()*2*pi;
			r2.speed(1,j) = v_f2 * cos(r2.dir(j));
			r2.speed(2,j) = v_f2 * sin(r2.dir(j));
		end
	end

	% Genstarter tiden for disse
	r1.t(r1.tally) = t_f1;
	r2.t(r2.tally) = t_f2;

	% Ny position. Simpel Eulerintegration
	r1.pos(:,:,i) = r1.pos(:,:,i-1) + r1.speed*dt;
	r2.pos(:,:,i) = r2.pos(:,:,i-1) + r2.speed*dt;

	% Positionen tjekkes, for om randen nås:
	r1.oob = r1.pos(:,:,i) <= 0 | r1.pos(:,:,i) >= stor(1);
	if ~isempty(r1.oob)
		r1.speed = r1.speed.*(r1.oob*(-2)+1);
		r1.pos(:,:,i) = r1.pos(:,:,i-1) + r1.speed*dt;
	end
	r2.oob = r2.pos(:,:,i) <= 0 | r2.pos(:,:,i) >= stor(1);
	if ~isempty(r2.oob)
		r2.speed = r2.speed.*(r2.oob*(-2)+1);
		r2.pos(:,:,i) = r2.pos(:,:,i-1) + r2.speed*dt;
	end

	delete(p1);
	delete(p2);
	p1 = scatter(r1.pos(1,:,i),r1.pos(2,:,i),dot_size,r1.col,'filled');
	p2 = scatter(r2.pos(1,:,i),r2.pos(2,:,i),dot_size,r2.col,'filled');
	pause(ptime)
end
clear all
close all
clc

% Variable!
dt = 1;				% Tidsskridtet
vis = 90;			% Synsfelt i grader.
stor = [100 100]; 	% Spillebrættets størrelse
ptime = 0.1;		% Pausetid
tend = 100;
dot_size = 15;

% For race 1:
n1 = 25;			% Antal individer af race 1
v_f1 = 0.5;			% Normal hastighed for race 1
t_f1 = 10;			% Antal tidsskridt, som race 1 bevæger sig i en given retning
r_panik = 10;		% Panikafstand for race 1. Skal være mindre end r_f2
t_panik = 15;		% Paniktid for race 1
t_pp = 10;			% Sekundær panik (panik fra at se et andet individ i panik)
r_die1 = 5;			% Afstand mellem r1 og r2, hvor race 1 dør
r.col(1) = 'g';		% Farven af individer

% For race 2:
n2 = 50;			% Antal individer af race 2
v_f2 = 0.2;			% Normal hastighed for race 2
t_f2 = 3;			% ligeledes for race 2.
r_f2 = 15;			% Spotradius for race 2.
t_fol = 10;			% Tidsskridt race 2 forfølger i.
r_die2 = 5;			% Afstand hvor r2 dør.
r.col(2) = 'r';		% Farven af individer

r.resetTime = [t_f1; t_f2];
r.Hast = [v_f1; v_f2];

%% Lav startposition:
r = init(r,n1,n2,v_f1,v_f2,t_f1,t_f2,stor);


figure
hold on
p1 = scatter(r.pos(1,r.r1,1),r.pos(2,r.r1,1),dot_size,r.col(1),'filled');
p2 = scatter(r.pos(1,r.r2,1),r.pos(2,r.r2,1),dot_size,r.col(2),'filled');
axis([0 100 0 100])
pause(ptime)
for i = 2:tend
	rv = rvec(r.pos(:,:,i-1));


	% Vi tæller ned i antallet af trin til retningsskift
	r.t = r.t-1;


	% Tjekker hvilke der er 0
	r.tally(1,:) = r.t == 0;

	% Finder ny retning for disse, og opdater hastigheden
	r.vel(:,:) = velupdate(r);

	% Genstarter tiden for disse
	r.t = tid(r);

	% Ny position. Simpel Eulerintegration
	r.pos(1,r.r1,i) = r.pos(1,r.r1,i-1) + r.vel(1,r.r1)*dt;
	r.pos(2,r.r1,i) = r.pos(2,r.r1,i-1) + r.vel(2,r.r1)*dt;
	r.pos(1,r.r2,i) = r.pos(1,r.r2,i-1) + r.vel(1,r.r2)*dt;
	r.pos(2,r.r2,i) = r.pos(2,r.r2,i-1) + r.vel(2,r.r2)*dt;

	% Positionen tjekkes, for om randen nås:
	r.oob = r.pos(:,:,i) <= 0 | r.pos(:,:,i) >= stor(1);
	if ~isempty(r.oob)
		r.vel = r.vel.*(r.oob*(-2)+1);
		r.pos(:,:,i) = r.pos(:,:,i-1) + r.vel*dt;
	end

	delete(p1);
	delete(p2);
	p1 = scatter(r.pos(1,r.r1,i),r.pos(2,r.r1,i),dot_size,r.col(1),'filled');
	p2 = scatter(r.pos(1,r.r2,i),r.pos(2,r.r2,i),dot_size,r.col(2),'filled');
	pause(ptime)
end
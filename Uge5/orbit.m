function [rt,nextsave] = orbit(r_init, v_init, m, t_end, dt_initial, graph_on_off, n_plot)

	global G

	rnext = @(r,v,a,adt,dt) r+v.*dt+1/2.*a.*dt.^2+1/6.*adt.*dt.^3;
	vnext = @(v,a,adt,dt) v+a.*dt + 1/2.*adt.*dt.^2;


	i = 1;								% tællevariabel
	t = 0;								% tidsvariabel


	% Initialisering af arrays og input af startværdier
	nextsave = n_plot
	dt(1) = dt_initial;
	rv = rvec(r_init);
	rl = rvlen(rv);
	acc(:,:,1) =  accvec(m,rv,rl);
	Adot(:,:,1) = zeros(3,size(r_init,2));
	v(:,:,1) = vnext(v_init,acc(:,:,1),Adot(:,:,1),dt(1));


	r(:,:,1) = rnext(r_init,v(:,:,1),acc(:,:,1),Adot(:,:,1),dt(1));
	rt(:,:,1) = r(:,:,1);

	t = t+dt(end);
	i = i+1;

	while t <= t_end
		rv = rvec(r(:,:,end));
		rl = rvlen(rv);
		acc(:,:,end+1) = accvec(m,rv,rl);
		Adot(:,:,end+1) = (acc(:,:,end)-acc(:,:,end-1))./(dt(end));
		dt(end+1) = dtval(acc(:,:,end),Adot(:,:,end));
		v(:,:,end+1) = vnext(v(:,:,end),acc(:,:,end),Adot(:,:,end),dt(end));

		r(:,:,end+1) = rnext(r(:,:,end),v(:,:,end),acc(:,:,end),Adot(:,:,end),dt(end));



		% Hvis det er tid til at gemme, så gemmes der (sker hvert n_plot tidsskridt)
		if i >= nextsave
			rt(:,:,end+1) = r(:,:,end);
			nextsave = nextsave+n_plot;
		end

		t = t + dt(end);
		i = i+1;
	end

end

function rv = rvec(r)
	% Denne funktion finder koordinatforskellen mellem tre søjlevektorer i en 3x3 matrix r, og giver
	% et 3x3x3 array ud (én dimesion for hver vektor)

	% Der laves først en rækkevektor fuld af ettaller, med samme størrlse som antallet af
	% søjlevektorer i r.
	onesies = ones(1,size(r,2));

	% Dernæst laves der et nxnxn array:
	for j=1:size(r,2)
		% Først dublikeres den i'te søjlevektor af r langs andet indeks:
		% [1;0;0] -> [1 1 1; 0 0 0; 0 0 0]
		rj = r(:,j)*onesies;

		% det j'te array (3. indeks af rv) er r-rj. Dette giver ri-rj vektoriseret
		rv(:,:,j) = r-rj;
	end

end

function rl = rvlen(rv)
	% Udregner modulus af alle rækkevektorer i rv, og outputter dem i række, med
	% rl(1,:) = modulus(rv(:,:,3));

	% Først kvadreres alle elementer i rv, dernæst tages summen (langs 1. dimension) og til sidst
	% tages kvadratroden af hvert element.
	% Dette giver et 1x3x3 array, som vi laver om til et 3x3 array med reshape-funktionen. Så bliver
	% rl(1,:) = rl(1,:,1)
	rl = sqrt(sum(rv.^2));
	rl = squeeze(rl);
end

function acc = accvec(m,rv,rl)

	% Denne funktion udregner accelerationsvektorerne for hvert legeme, i komposanter.
	% Udregningen er A_i = -G * rv/rl^3, hvor A_i er en vektor. Eksempel:

	% A1 = -G * (m2*rv12/rl12^3 + m3*rv13/rl13^3)
	% A(:,1) = -G .* (m(2) .* rv(:,1,2) ./ (rl(1,2)^3) +  m(3) .* rv(:,1,3) ./ (rl(1,3)^3));


	global G
	for i = 1:length(m)
		% Vi starter med et 0 for A. Dette er en 3x1 søjlevektor (ét element for hvert koordinat)
		A = zeros(3,1);
		for j = 1:size(rv,2)
			% Hvis vi prøver at finde accelerationen fra den i'te vektor springer vi over
			if i == j
				continue
			end

			A = A+(m(j).*rv(:,i,j)./(rl(i,j).^3));
		end
		acc(:,i) = -G .* A;
	end
end

function dt = dtval(a,adt)

	% Udregner tidsskridtet dt, der skal bruges til 3-legemeproblemet, ud fra formlen
	% delta_t = eta*3*|A|/|Â|, dt = min(delta_t)
	% Hvor |Â| og |Â| er vektorer med n koordinater, hvor n er antallet af legemer.

	% eta sættes til 1e-3 konstant.
	eta = 1e-3;

	% Finder lige længden af vektorerne i a og adt, med samme formel som fra rvlen.m
% 	al = sqrt(sum(a.^2));
% 	adtl = sqrt(sum(adt.^2));
% 	[~,y,z] = size(al);
% 	al = reshape(al,[y,z]);
% 	adtl = reshape(adtl,[y,z]);

	al = rvlen(a);
	adtl = rvlen(adt);

	% Regner formeludtrykket og tager mindsteværdien
	deltat = eta.*3.*al./adtl;
	dt = min(deltat);

end
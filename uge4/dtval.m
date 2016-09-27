function dt = dtval(a,adt)

	% Udregner tidsskridtet dt, der skal bruges til 3-legemeproblemet, ud fra formlen
	% delta_t = eta*3*|A|/|�|, dt = min(delta_t)
	% Hvor |�| og |�| er vektorer med n koordinater, hvor n er antallet af legemer.
	
	% eta s�ttes til 1e-3 konstant.
	eta = 1e-3;
	
	% Finder lige l�ngden af vektorerne i a og adt, med samme formel som fra rvlen.m
	al = sqrt(sum(a.^2));
	adtl = sqrt(sum(adt.^2));
	[~,y,z] = size(al); 
	al = reshape(al,[y,z]);
	adtl = reshape(adtl,[y,z]);
	
	% Regner formeludtrykket og tager mindstev�rdien
	deltat = eta.*3.*al./adtl;
	dt = min(deltat);
	
end
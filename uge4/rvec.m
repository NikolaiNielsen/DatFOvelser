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
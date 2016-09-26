function rv = rvec(r)
	% Denne funktion finder koordinatforskellen mellem tre s�jlevektorer i en 3x3 matrix r, og giver
	% et 3x3x3 array ud (�n dimesion for hver vektor)
	
	% Der laves f�rst en r�kkevektor fuld af ettaller, med samme st�rrlse som antallet af
	% s�jlevektorer i r.
	onesies = ones(1,size(r,2));
	
	% Dern�st laves der et nxnxn array:
	for j=1:size(r,2)
		% F�rst dublikeres den i'te s�jlevektor af r langs andet indeks:
		% [1;0;0] -> [1 1 1; 0 0 0; 0 0 0]
		rj = r(:,j)*onesies;
		
		% det j'te array (3. indeks af rv) er r-rj. Dette giver ri-rj vektoriseret
		rv(:,:,j) = r-rj;
	end

end
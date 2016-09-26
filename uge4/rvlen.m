function rl = rvlen(rv)
	% Udregner modulus af alle r�kkevektorer i rv, og outputter dem i r�kke, med 
	% rl(1,:) = modulus(rv(:,:,3));
	
	% F�rst kvadreres alle elementer i rv, dern�st tages summen (langs 1. dimension) og til sidst
	% tages kvadratroden af hvert element.
	% Dette giver et 1x3x3 array, som vi laver om til et 3x3 array med reshape-funktionen. S� bliver
	% rl(1,:) = rl(1,:,1)
	rl = sqrt(sum(rv.^2));
	[~,y,z] = size(rv); 
	rl = reshape(rl,[y,z]);
end
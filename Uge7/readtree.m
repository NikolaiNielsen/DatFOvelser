function arr = readtree(s,arr)
	% I denne funktion skal tr�et l�ses. Dette g�res ved, f�rst at tjekke
	% om der er et "smaller"-field. Hvis dette er tilf�ldet, s� kald
	% funktionen igen, med dette field som input-struct. Hvis der er et
	% tomt "smaller"-field, er bunden n�et og vi returnerer


	% F�rst tjekkes det, om value-feltet eksisterer. valuefeltet af et
	% child findes kun hvis parents smaller-felt eksisterer.
	if ~isfield(s,'value')
		return
	end
	
	% Hvis s.smaller IKKE er tom, er der et mindre tal. G� ned til dette
	if ~isempty(s.smaller)
		arr = readtree(s.smaller,arr);
		
	elseif isempty(s.smaller)
		arr(end+1) = s.value;
		s.number = s.number-1;
	end
	

	% Hvis b�de smaller og larger er tomme, kan vi tage v�rdien og slette
	% lortet.
% 	if isempty(s.smaller) && isempty(s.larger)
% 		
% 	end
end
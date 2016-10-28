function arr = readtree(s,arr)
	% I denne funktion skal træet læses. Dette gøres ved, først at tjekke
	% om der er et "smaller"-field. Hvis dette er tilfældet, så kald
	% funktionen igen, med dette field som input-struct. Hvis der er et
	% tomt "smaller"-field, er bunden nået og vi returnerer


	% Først tjekkes det, om value-feltet eksisterer. valuefeltet af et
	% child findes kun hvis parents smaller-felt eksisterer.
	if ~isfield(s,'value')
		return
	end
	
	% Hvis s.smaller IKKE er tom, er der et mindre tal. Gå ned til dette
	if ~isempty(s.smaller)
		arr = readtree(s.smaller,arr);
		
	elseif isempty(s.smaller)
		arr(end+1) = s.value;
		s.number = s.number-1;
	end
	

	% Hvis både smaller og larger er tomme, kan vi tage værdien og slette
	% lortet.
% 	if isempty(s.smaller) && isempty(s.larger)
% 		
% 	end
end
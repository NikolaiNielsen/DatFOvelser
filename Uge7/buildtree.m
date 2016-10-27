function s = buildtree(s,arr)
	% Hvis der ikke er flere elementer i listen, så træder vi ud af funktionen
	if length(arr) == 0
		return
	end

	% Det tjekkes, om valuefeltet findes. Hvis ikke initialiseres dette, samt numberfeltet
	% Det første element i arr slettes også
	if ~isfield(s,'value')
		s.value = arr(1)
		s.number = 1;
		arr(1) = [];
	end
	
	
	% smaller og larger sættes som tomme lister.
	s.smaller = [];
	s.larger = [];

	% Elementet, der skal testes sættes til active
	active = arr(1);

	% Så skal der fandme rekurseres
	% active er *større*
	if active > s.value
		
		s.larger = buildtree(s.larger,arr);
		
	% active er *mindre*
	elseif active < s.value
	
		s.smaller = buildtree(s.smaller,arr);
		
	% active er *lige stort*
	else 					
		s.number = s.number + 1;
		arr(1) = [];
		s = buildtree(s, arr);
	end

end
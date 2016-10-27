function s = buildtree(s,arr)

	% Det tjekkes, om valuefeltet findes. Hvis ikke initialiseres dette, samt numberfeltet
	% Det f�rste element i arr slettes ogs�
	if ~isfield(s,'value')
		s.value = arr;
		s.number = 1;
		% smaller og larger s�ttes som tomme lister.
		s.smaller = [];
		s.larger = [];
		return
	end


	% S� skal der fandme rekurseres
	% active er *st�rre*
	if arr > s.value
		s.larger = buildtree(s.larger,arr);
		
	% active er *mindre*
	elseif arr < s.value
		s.smaller = buildtree(s.smaller,arr);
		
	% active er *lige stort*
	else 					
		s.number = s.number + 1;
	end

end
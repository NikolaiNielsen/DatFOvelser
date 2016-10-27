function arr = readtree(s,arr)
	
	% Først tjekkes det, om value-feltet eksisterer. valuefeltet af et
	% child findes kun hvis parents smaller-felt eksisterer.
	if ~isfield(s,'value')
		return
	end
	
	% Hvis s.smaller er tom er vi nået bunden
	if ~isempty(getfield(s,'smaller')
		return
	end
		

end
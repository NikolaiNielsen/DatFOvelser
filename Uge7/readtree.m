function arr = readtree(s,arr)
	
	% F�rst tjekkes det, om value-feltet eksisterer. valuefeltet af et
	% child findes kun hvis parents smaller-felt eksisterer.
	if ~isfield(s,'value')
		return
	end
	
	% Hvis s.smaller er tom er vi n�et bunden
	if ~isempty(getfield(s,'smaller')
		return
	end
		

end
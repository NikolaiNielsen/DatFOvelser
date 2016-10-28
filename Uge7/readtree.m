function arr = readtree(s,arr)

	% F�rst g�s der helt ned i bunden af treet, til den mindste v�rdi
	if ~isempty(s.smaller)
		arr = readtree(s.smaller,arr);
		% N�r der tr�des ud af dette funktionskald (eksempelvis 1 -> 2)
		% gemmes v�rdien
		arr(end+1:end+s.number) = s.value; 
	end
	% Hvis der ikke er nogen s.smaller gemmes v�rdien
	if isempty(s.smaller)
		arr(end+1:end+s.number) = s.value; 
	end
	% Hvis der *er* en st�rre v�rdi, tr�des der ned i tr�et
	if ~isempty(s.larger)
		arr = readtree(s.larger,arr);
	end
	
	
end
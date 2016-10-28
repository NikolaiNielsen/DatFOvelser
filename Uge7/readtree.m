function arr = readtree(s,arr)

	% Først gås der helt ned i bunden af treet, til den mindste værdi
	if ~isempty(s.smaller)
		arr = readtree(s.smaller,arr);
		% Når der trædes ud af dette funktionskald (eksempelvis 1 -> 2)
		% gemmes værdien
		arr(end+1:end+s.number) = s.value; 
	end
	% Hvis der ikke er nogen s.smaller gemmes værdien
	if isempty(s.smaller)
		arr(end+1:end+s.number) = s.value; 
	end
	% Hvis der *er* en større værdi, trædes der ned i træet
	if ~isempty(s.larger)
		arr = readtree(s.larger,arr);
	end
	
	
end
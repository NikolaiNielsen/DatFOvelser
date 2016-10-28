function arr = readtree(s,arr)
	persistent liste tree;
	if isempty(liste)
		liste = arr;
		tree = s;
	end
	
	% I denne funktion skal tr�et l�ses. Nyt fors�g! Tjek med v�rdierne i
	% arr.
	% Hvis arr(end) < s.value & s.smaller findes : g� ned i s.smaller
	% Hvis arr(end) < s.value & s.smaller IKKE findes: 
	% - tag s.value, minus �n i s.number, return
	% Hvis arr(end) = s.val & s.number > 0: minus �n i s.number, return
	% Hvis arr(end) = s.val & s.number = 0: tr�d ned i s.larger 
	% Hvis arr(end) > 

	% F�rst g�s der helt ned i bunden af treet, til den mindste v�rdi
	if isempty(liste) && ~isempty(tree.smaller)
		arr = readtree(tree.smaller,arr);
		return
	elseif isempty(arr)
		arr(end+1) = tree.value;
		tree.number = tree.number - 1;
		return
	end
	
	% S� k�res hoveddelen
	largest = arr(end);
	if largest < tree.value && ~isempty(tree.smaller)
		arr = readtree(tree.smaller,arr);
		return
	elseif	(largest < tree.value && isempty(tree.smaller)) ||...
			(largest == tree.value && tree.number > 0)
		
		arr(end+1) = tree.value;
		tree.number = tree.number - 1;
		return
		
	elseif largest == tree.value && tree.number == 0
		if isempty(tree.larger)
			disp('something went wrong!')
		else
			arr = readtree(tree.larger,arr);
		end
	end
	
end
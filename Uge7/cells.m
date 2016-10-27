function arr = cells(fil)

	fileID = fopen(fil,'r');
	C = textscan(fileID,'%s %f %s %f');
	arr = cell(6,2);
	arr{1,1} = 'Antal elementer i data:';
	arr{2,1} = 'Sum af 2en s�jle:';
	arr{3,1} = 'Middelv�rdi af 2en s�jle:';
	arr{4,1} = 'Sum af 4re s�jle:';
	arr{5,1} = 'Middelv�rdi af 4re s�jle:';
	arr{6,1} = C{2};
	arr{1,2} = length(C{2});
	arr{2,2} = sum(C{2});
	arr{3,2} = mean(C{2});
	arr{4,2} = sum(C{4});
	arr{5,2} = mean(C{4});
	arr{6,2} = C{4};
end
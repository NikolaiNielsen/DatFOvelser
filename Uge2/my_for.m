sum = 0;					% startværdi for summationsvariablen
for i = 1:numel(data)		% Vi summerer over antallet af elementer i data
	sum = sum+data(i);		% summerer hvert element
end
my_average = sum/numel(data)	% udregner gennemsnittet
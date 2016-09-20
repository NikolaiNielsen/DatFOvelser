% data = random('Normal',0,1,100,2);
sum = 0;						% startværdi for summationsvariablen
tally = 1;
while tally <= numel(data)		% Vi summerer over antallet af elementer i data
	sum = sum+data(tally);		% summerer hvert element
	tally = tally+1;
end
my_average = sum/numel(data)	% udregner gennemsnittet
% mean(mean(data))
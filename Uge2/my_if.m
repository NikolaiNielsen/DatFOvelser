% clear all
% data = rand(100,1)
low = 0;
mean = 0;
top = 0;
for i = 1:numel(data)		% Vi summerer over antallet af elementer i data
	if (data(i) >= 0) && (data(i) < 1/3)
		low = low+1;
	elseif (data(i) >= 1/3) && (data(i) < 2/3)
		mean = mean + 1;
	elseif (data(i) >= 2/3) && (data(i) <= 1)
		top = top + 1;
	end
end
low
mean
top
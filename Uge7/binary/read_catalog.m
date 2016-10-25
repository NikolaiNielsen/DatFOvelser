function [pos,dist,delpos,mag,temp] = read_catalog(fil,liste)

	% A function to read a binary file. The schematics are as follows:
	% 1 block of 8 bytes specifying the number of datasets
	% n blocks of 40 bytes, with the info for each star:
	% - double (8B) Alpha
	% - double (8B) Delta
	% - double (8B) Paralax (note the spelling)
	% - single (4B) my-alpha
	% - single (4B) my-delta
	% - single (4B) V
	% - single (4B) B-V

	n = length(liste);
	fileID = fopen(fil,'r');
	numStars = fread(fileID,[1],'int64');





	for i = 1:n
		% position, in bytes, of the data from starNum, relative to bof.
		if liste(i) > numStars
			fprintf('Der er kun %d stjerner i kataloget, og du prøver at finde %d',numStars,liste(i))
			liste(i) = [];
		end
	end
	n = length(liste);
	pos = zeros(2,n);
	dist = zeros(1,n);
	delpos = zeros(2,n);
	mag = zeros(1,n);
	temp = zeros(1,n);
	for i = 1:n
		position = liste(i)*40;
		fseek(fileID,position,'bof');

		% The data
		pos(1,i) 	= fread(fileID,[1],'double');
		pos(2,i) 	= fread(fileID,[1],'double');
		dist(1,i) 	= fread(fileID,[1],'double');
		delpos(1,i) = fread(fileID,[1],'single');
		delpos(2,i) = fread(fileID,[1],'single');
		mag(1,i)	= fread(fileID,[1],'single');
		temp(1,i)	= fread(fileID,[1],'single');

	end

end
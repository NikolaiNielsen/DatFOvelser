function [s] = read_catalog(fil,liste)

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
	numStars = fread(fileID,[1],'int64')



	stufftodel = [];

	for i = 1:n
		% position, in bytes, of the data from starNum, relative to bof.
		if liste(i) > numStars
			fprintf('Der er kun %d stjerner i kataloget, og du prøver at finde %d.\n',numStars,liste(i))
			stufftodel = [stufftodel i];
		end
	end
	liste(stufftodel) = [];
	n = length(liste);
	s = struct();
	for j = 1:n

		position = liste(j)*40;
		fseek(fileID,position,'bof');

		% The data
		s(j).Number 	= liste(j);
		s(j).Alpha 		= fread(fileID,[1],'double');
		s(j).Delta 		= fread(fileID,[1],'double');
		s(j).Paralax	= fread(fileID,[1],'double');
		s(j).my_alpha 	= fread(fileID,[1],'single');
		s(j).my_delta 	= fread(fileID,[1],'single');
		s(j).V			= fread(fileID,[1],'single');
		s(j).B_V		= fread(fileID,[1],'single');

	end

end
clear all
close all
clc
lines = 4232;
values = 8;
fileID = fopen('catalog.txt','r');
F = fscanf(fileID,'%f %f %f %f %f %f %f %f\n',[values,lines]);
F = F';
% Vi skal kun bruge kolonne 2:8;
data = F(:,2:8);
fclose(fileID);

% Så skal der skrives!
fileID = fopen('catalog.bin','w');

% Først skriver vi antallet af stjerner i datasættet
binlines = fwrite(fileID,lines,'int64');

% Så skriver vi 32 bytes af nuller, så det hele er sjovt
for i = 1:4
	fwrite(fileID,0,'double');
end

% Så skriver vi selve data. 3x8 og 4x4 (40B)
for i = 1:lines
	fwrite(fileID,data(i,1),'double');
	fwrite(fileID,data(i,2),'double');
	fwrite(fileID,data(i,3),'double');
	fwrite(fileID,data(i,4),'single');
	fwrite(fileID,data(i,5),'single');
	fwrite(fileID,data(i,6),'single');
	fwrite(fileID,data(i,7),'single');
end

fclose(fileID);

%% Så skal der læses!!
% clear all

% fileID = fopen('catalog.bin','r')
% binread(fileID,2)
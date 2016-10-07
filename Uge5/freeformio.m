%% Skriver til datatest - for-loop
clear all
close all
clc

x = linspace(0,pi,50);
f1 = sin(x);
f2 = cos(x);


% Skriver de første 2 linjer af x, f1, f2 til "datatest.txt", med 3 forskellige formater.
% %f: float, %e: exponent, %g: mere kompakt %e og %f, uden ekstra 0'er
fileID = fopen('datatest.txt','w');
for i =1:2
	fprintf(fileID,'%f %f %f\n',x(i),f1(i),f2(i));
end
for i =1:2
	fprintf(fileID,'%e %e %e\n',x(i),f1(i),f2(i));
end
for i =1:2
	fprintf(fileID,'%g %g %g\n',x(i),f1(i),f2(i));
end
fclose(fileID);
% '%e' er mest præcis


%% Skriver til datatest - på én gang.
clear all
close all
clc

x = linspace(0,pi,50);
f1 = sin(x);
f2 = cos(x);


% Skriver de første 2 linjer af x, f1, f2 til "datatest.txt", med 3 forskellige formater.
% %f: float, %e: exponent, %g: mere kompakt %e og %f, uden ekstra 0'er
fileID = fopen('datatest.txt','w');

all = [x; f1; f2];
fprintf(fileID,'%f %f %f\n',all);
fclose(fileID);


%% Læs fra datatest - 3 forskellige måder

% Åbner, scanner og lukker filen 3 gange, med forskellige formatspecs.
fileID = fopen('datatest.txt','r');
F = fscanf(fileID,'%f')
fclose(fileID);

fileID = fopen('datatest.txt','r');
E = fscanf(fileID,'%e')
fclose(fileID);

fileID = fopen('datatest.txt','r');
G = fscanf(fileID,'%g')
fclose(fileID);

% Der er ingen forskel!


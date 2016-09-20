clear all
clc
close all

x = 0:.2:4*pi;					% Laver x-array
f = 2*sin(3*x).*cos(2*x);		% Laver f-array
dx = x(2)-x(1);					% definition af dx er 0.1, eller bare afstanden mellem f�rste og 
								% andet element i x-vektoren.

% til df3, der er en tredjeordensapproksimation, skal der bruges indeksene i, i+1, i-1 og i+2.
% Da der er 63 elementer i hver vektor, kan der kun regnes den afledede for element 2 (i-1 = 1, i=2) 
% til 61 (i+2 = 63, i = 61).
% F�rste indeks i alle 'f' findes ved at s�tte i = 2, og s� inds�tte tal. Da bliver f�rste t�ller:
% f(3:?)-f(2:?) og anden t�ller. f(4:?) - f(1:?).
% Andet indeks findes ved at s�tte i+2 = end, da dette er det sidste element der indg�r i
% udregningen (anden t�ller, f�rste led). F�rste t�ller har ledende f(i+1) og f(i), der dermed
% bliver henholdsvis 'end-1' og 'end-2', og anden t�ller har f(i+2) og f(i), der bliver 'end' og 
% 'end-3'. Hele f�rste t�ller ser da s�ledes ud:
% f(3:end-1)-f(2:end-2)
% Og anden t�ller:
% f(4:end)-f(1:end-3)

% x-koordinaten for alle disse, er lig indeks for f�rste t�ller, andet led, der er det i'te
% datapunkt (f(i) = f(2:end-2)

df3 = (f(3:end-1)-f(2:end-2))/(1.125*dx)+(f(4:end)-f(1:end-3))/(24*dx);
x3 = x(2:end-2);

plot(x3,df3,'r-*')
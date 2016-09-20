clear all
clc
close all

x = 0:.2:4*pi;					% Laver x-array
f = 2*sin(3*x).*cos(2*x);		% Laver f-array
dx = x(2)-x(1);					% definition af dx er 0.1, eller bare afstanden mellem første og 
								% andet element i x-vektoren.

% til df3, der er en tredjeordensapproksimation, skal der bruges indeksene i, i+1, i-1 og i+2.
% Da der er 63 elementer i hver vektor, kan der kun regnes den afledede for element 2 (i-1 = 1, i=2) 
% til 61 (i+2 = 63, i = 61).
% Første indeks i alle 'f' findes ved at sætte i = 2, og så indsætte tal. Da bliver første tæller:
% f(3:?)-f(2:?) og anden tæller. f(4:?) - f(1:?).
% Andet indeks findes ved at sætte i+2 = end, da dette er det sidste element der indgår i
% udregningen (anden tæller, første led). Første tæller har ledende f(i+1) og f(i), der dermed
% bliver henholdsvis 'end-1' og 'end-2', og anden tæller har f(i+2) og f(i), der bliver 'end' og 
% 'end-3'. Hele første tæller ser da således ud:
% f(3:end-1)-f(2:end-2)
% Og anden tæller:
% f(4:end)-f(1:end-3)

% x-koordinaten for alle disse, er lig indeks for første tæller, andet led, der er det i'te
% datapunkt (f(i) = f(2:end-2)

df3 = (f(3:end-1)-f(2:end-2))/(1.125*dx)+(f(4:end)-f(1:end-3))/(24*dx);
x3 = x(2:end-2);

plot(x3,df3,'r-*')
%% Første del
clear all
clc
close all

C1 = 3.741e34;			% konstant 1, [W^2]
C2 = 1.439e8;			% konstant 2, [m*k]

L = 100:100:10000;			% bølgelængde, [Ångstrøm], 10^-10 m
T = 3000:3000:15000;	% Temperaturen, [K]
T(3) = 10000;
Colors = {'r','g','b','k','m','c'};

figure(1)
hold on
for i = 1:length(T)
	FT(i,:) = (C1./(pi.*L.^5)).*(1./(exp(C2./(L*T(i)))-1));
	plot(L,FT(i,:),'color',Colors{i})
end
title('Plancks lov')
xlabel('L: bølgelængde, [Å]')
ylabel('Intensitet, ukendt enhed')
legend('T = 3000 K','T = 6000 K','T = 10000 K','T = 12000 K','T = 15000 K')
hold off



%% anden del -- Der er noget galt her! Følg op!
clear all
clc
% close all

C1 = 3.741e34;			% konstant 1, [W^2]
C2 = 1.439e8;			% konstant 2, [m*k]
L = 100:100:10000;		% bølgelængde, [Ångstrøm], 10^-10 m. 100 elementer
T = 3e4:1e4:1e5;		% temperatur, fra 3000K til 10000K, i interval af 1000K
%T = linspace(2e4,1e5,100);	% Temperatur. 100 jævnt fordelte punkter i intervallet 3000K til 10000K
Lones = ones(1,length(L));	% 1D array af 1-taller, med samme længde som L
Tones = ones(1,length(T));	% 1D array, ligeledes med Lones

% Nu skal der laves nogle 2D-arrays. Hvis der skal varieres langs det første indeks, så skal den
% anden faktor være den variable, og hvis der skal varieres langs det andet indeks, skal den første
% faktor være den variable.
T2d = T'*Lones;
L2d = Tones'*L;
FLT = ((C1)./(pi.*L2d.^5)).*(1./(-1+exp(C2./(L2d.*T2d))));
figure(2)
hold on
surf(T,L,FLT)
% surf(FLT,T2d,L2d)
xlabel('Temperatur [K]')
ylabel('bølgelængde [Å]')
zlabel('intensitet')

% figure(3)
% hold on
% % surf(T,L,FLT)
% surf(FLT,T2d',L2d)
% xlabel('Temperatur [K]')
% ylabel('bølgelængde [Å]')
% zlabel('intensitet')

clear all
% Lones = ones(1,length(L));	% 1D array af 1-taller, med samme l�ngde som L
% Tones = ones(1,length(T));	% 1D array, ligeledes med Lones
% T2d = Tones'*T;
% L2d = L'*Lones
C1 = 1;
C2 = 2;
T2d = ones(361,20);
L2d = ones(361,20);
FLT1 = ((C1)./(pi.*L2d.^5));
FLT2 = (1./(exp(C2./(L2d.*T2d))-1));
FLT = FLT1.*FLT2;
Lones = ones(1,length(L));	% 1D array af 1-taller, med samme længde som L
Tones = ones(1,length(T));	% 1D array, ligeledes med Lones
T2d = T'*Lones;
L2d = Tones'*L;
FLT = ((C1)./(pi.*L2d.^5)).*(1./(-1+exp(C2./(L2d.*T2d))));
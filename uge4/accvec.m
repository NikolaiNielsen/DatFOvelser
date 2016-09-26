function acc = accvec(m,rv,rl)
	
	% Denne funktion udregner accelerationsvektorerne for hvert legeme, i komposanter.
	% Udregningen er A_i = -G * rv/rl^3, hvor A_i er en vektor. Eksempel:
	
	% A1 = -G * (m2*rv12/rl12^3 + m3*rv13/rl13^3)
	% A(:,1) = -G .* (m(2) .* rv(:,1,2) ./ (rl(1,2)^3) +  m(3) .* rv(:,1,3) ./ (rl(1,3)^3));
	
	
	global G
	for i = 1:length(m)
		% Vi starter med et 0 for A. Dette er en 3x1 søjlevektor (ét element for hvert koordinat)
		A = zeros(3,1);
		for j = 1:size(rv,2)
			% Hvis vi prøver at finde accelerationen fra den i'te vektor springer vi over
			if i == j
				continue
			end
		
			A = A+(m(j).*rv(:,i,j)./(rl(i,j).^3));
		end
		acc(:,i) = -G .* A;
	end



% 	onesies = ones(size(rl,2),1);
% 	rl2d = zeros(size(rv));
% 	for i = 1:size(rl,2);
% 		rl2d(:,:,i) = (onesies*rl(i,:))';
% 	end
% 	acc = rl2d;
% 	for i = 1:length(m)
% 		% Vi starter med et 0
% 		A = zeros(size(rv,1),1);
% 		for j = 1:size(rv,2)
% 			% Hvis vi prøver at finde accelerationen fra den i'te vektor springer vi over
% 			if i == j
% 				continue
% 			end
% 		
% 			A = A+(m(j).*rv(:,i,:)./(rl(i,:).^3));
% 		end
% 		acc(:,i) = -G .* A;
% 	end
end
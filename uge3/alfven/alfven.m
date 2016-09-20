function [By,Vy,t_snap] = alfven(x,By0,Vy0,t,dt,t_gem)

	dx = x(2)-x(1);		% afstanden mellem hvert x-punkt
	Bx = 1;

	tal = 0;

	nextsave = t_gem;
	% udregning af rumlig differentierede
	% (RK3 metode) - tretrinsraket.
	xs = @(x,dxdt) x + dt/3 .* dxdt;
	xss = @(x,dxsdt) x + dt/2 .* dxsdt;
	xnext = @(x,dxssdt) x + dt.*dxssdt;

	% Først initialiserer vi lige By-arrayet (og vy)
	B(1,:) = By0;
	v(1,:) = Vy0;
	% dvy = dBy/dx*Bx;
	% dBy = dvy*Bx/dx;
	Bsave(1,:) = By0;
	vsave(1,:) = Vy0;

	% Målet er at integrere i rummet. For at gøre dette, bruges Runga-Kutta
	% metoden af 3. orden. Til dette skal de tidsligt differentierede udtryk af
	% en given størrelse bruges, hvilket fås ved de koblede
	% differentialligninger, der omdanner rumligt differentierede størrelser
	% til tidsligt differentierede.

	dBdt(1,:) = rumdiff(v(end,:),dx).*Bx;
	dvdt(1,:) = rumdiff(B(end,:),dx).*Bx;

	% Så kan de forskellige stjerner findes
	Bs(1,:) = xs(B(end,:),dBdt(end,:));
	vs(1,:) = xs(v(end,:),dvdt(end,:));

	% Og tidsafledede af disse
	dBsdt(1,:) = rumdiff(vs(end,:),dx).*Bx;
	dvsdt(1,:) = rumdiff(Bs(end,:),dx).*Bx;

	% Nye stjerner
	Bss(1,:) = xss(B(end,:),dBsdt(end,:));
	vss(1,:) = xss(v(end,:),dvsdt(end,:));

	% Flere tidsafledte
	dBssdt(1,:) = rumdiff(vss(end,:),dx).*Bx;
	dvssdt(1,:) = rumdiff(Bss(end,:),dx).*Bx;

	% Og nyt tidsskridt!
	B(2,:) = xnext(B(end,:),dBssdt(end,:));
	v(2,:) = xnext(v(end,:),dvssdt(end,:));

	tal = tal+dt;

	while tal <= t
		% Først skal den første dBy/dx og dVy/dx findes, så dBy/dt og dVy/dt kan
		% findes:
		dBdt(end+1,:) = rumdiff(v(end,:),dx).*Bx;
		dvdt(end+1,:) = rumdiff(B(end,:),dx).*Bx;

		% Så kan de forskellige stjerner findes
		Bs(end+1,:) = xs(B(end,:),dBdt(end,:));
		vs(end+1,:) = xs(v(end,:),dvdt(end,:));

		% Og tidsafledede af disse
		dBsdt(end+1,:) = rumdiff(vs(end,:),dx).*Bx;
		dvsdt(end+1,:) = rumdiff(Bs(end,:),dx).*Bx;

		% Nye stjerner
		Bss(end+1,:) = xss(B(end,:),dBsdt(end,:));
		vss(end+1,:) = xss(v(end,:),dvsdt(end,:));

		% Flere tidsafledte
		dBssdt(end+1,:) = rumdiff(vss(end,:),dx).*Bx;
		dvssdt(end+1,:) = rumdiff(Bss(end,:),dx).*Bx;

		% Og nyt tidsskridt!
		B(end+1,:) = xnext(B(end,:),dBssdt(end,:));
		v(end+1,:) = xnext(v(end,:),dvssdt(end,:));

		if tal >= nextsave
			Bsave(end+1,:) = B(end,:);
			vsave(end+1,:) = v(end,:);
			nextsave = nextsave+t_gem;
		end

		tal = tal+dt;
	end

	% Laver en vektor med antallet af tidsskridt der er udregnet.
	By = Bsave;
	Vy = vsave;
	t_snap = linspace(0,t,size(Vy,1));

end

function diff = rumdiff(f,dx)
	[size1,size2] = size(f);		% Størrelsen af inputsvektoren
	a = 3./(4.*dx);
	b = -3./(20.*dx);
	c = 1./(60.*dx);

	% circshifter hele skidtet, og tager højde for om det er en række eller
	% søjlevektor.
	% if size1 == 1
		fm1 = circshift(f,[0,1]) ;
		fm2 = circshift(f,[0,2]) ;
		fm3 = circshift(f,[0,3]) ;
		fp1 = circshift(f,[0,-1]);
		fp2 = circshift(f,[0,-2]);
		fp3 = circshift(f,[0,-3]);
	% elseif size2 == 1
		% fm1 = circshift(f,[1,0]) ;
		% fm2 = circshift(f,[2,0]) ;
		% fm3 = circshift(f,[3,0]) ;
		% fp1 = circshift(f,[-1,0]);
		% fp2 = circshift(f,[-2,0]);
		% fp3 = circshift(f,[-3,0]);
	% end
	diff = a*(fm1-fp1)+b*(fm2-fp2)+c*(fm3-fp3);
end
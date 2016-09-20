clear all
close all

nx = 30;			% Antal grid-punkter
A = .1;				% Amplituden af den magnetiske b�lge
dx = 2*pi/nx;		% afstanden mellem hvert x-punkt
x = dx:dx:2*pi;		% alle x-koordinater
k = 1;				% b�lgetallet
B0 = A*sin(k*x);	% Startv�rdien for b�lgens position
v0 = zeros(1,nx);	% Startv�rdien for b�lgens hastighed
dt = dx/3;			% tidslig skridt (der skal bruges 3, da det er en
					% "tre-trins-raket"
Bx = 1;

tal = 0

t = 6
t_gem = dt
nextsave = t_gem

% udregning af rumlig differentierede
% (RK3 metode) - tretrinsraket.
xs = @(x,dxdt) x + dt/3 .* dxdt;
xss = @(x,dxsdt) x + dt/2 .* dxsdt;
xnext = @(x,dxssdt) x + dt.*dxssdt;

% F�rst initialiserer vi lige By-arrayet (og vy)
B(1,:) = B0;
v(1,:) = v0;
% dvy = dBy/dx*Bx;
% dBy = dvy*Bx/dx;


% M�let er at integrere i rummet. For at g�re dette, bruges Runga-Kutta
% metoden af 3. orden. Til dette skal de tidsligt differentierede udtryk af
% en given st�rrelse bruges, hvilket f�s ved de koblede
% differentialligninger, der omdanner rumligt differentierede st�rrelser
% til tidsligt differentierede.

% F�rst skal den f�rste dBy/dx og dVy/dx findes, s� dBy/dt og dVy/dt kan
% findes:
dBdt(1,:) = rumdiff(v(1,:),dx).*Bx;
dvdt(1,:) = rumdiff(B(1,:),dx).*Bx;

% S� kan de forskellige stjerner findes
Bs(1,:) = xs(B(1,:),dBdt(1,:))
vs(1,:) = xs(v(1,:),dvdt(1,:))

% Og tidsafledede af disse
dBsdt(1,:) = rumdiff(vs(1,:),dx).*Bx;
dvsdt(1,:) = rumdiff(Bs(1,:),dx).*Bx;

% Nye stjerner
Bss(1,:) = xss(B(1,:),dBsdt(1,:));
vss(1,:) = xss(v(1,:),dvsdt(1,:));

% Flere tidsafledte
dBssdt(1,:) = rumdiff(vss(1,:),dx).*Bx;
dvssdt(1,:) = rumdiff(Bss(1,:),dx).*Bx;

% Og nyt tidsskridt!
B(2,:) = xnext(B(1,:),dBssdt(1,:));
v(2,:) = xnext(v(1,:),dvssdt(1,:));
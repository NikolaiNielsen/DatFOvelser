%% aac_full
function accdot=aac_full(m, rv, rl, v)

global G

s = size(rv);

r1 = rl.^-3;
r2 = rl.^-5;
r1(isinf(r1)) = 0;
r2(isinf(r2)) = 0;

d = zeros(s);
d(1,:,:) = dot(rv,v);
for i = 2:s(1)
	d(i,:,:) = d(1,:,:);
end

accdot = -G*m.*(v.*r1 - 3.*rv.*d.*r2);
accdot = sum(accdot,3);


end
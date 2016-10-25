function vol = strucvol(A)

	a = [A.a.x A.a.y A.a.z];
	b = [A.b.x A.b.y A.b.z];
	c = [A.c.x A.c.y A.c.z];
	vol = abs(dot(a,cross(b,c)));
end
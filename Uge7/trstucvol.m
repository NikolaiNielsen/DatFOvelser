function vol = tstrucvol(A,B,C)
	a = [A.x A.y A.z];
	b = [B.x B.y B.z];
	c = [C.x C.y C.z];

	vol = dot(a,cross(b,c));
end
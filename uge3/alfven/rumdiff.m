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
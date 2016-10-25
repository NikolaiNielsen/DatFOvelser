%% aac_full
function accdot=aac_fullref(m, rv, rl, v)

global G
% determine the derivative using eq(4) in exercise 3.
n=size(m,2);
accdot=zeros(3,n);
for in=1:n
	for out=1:n
		if in ~= out
			accdot(:,in)=accdot(:,in)-G.*m(out).*(v(:,in)./rl(in,out).^3- ...
			3.*rv(:,in,out).*sum(rv(:,in,out).*v(:,in))./(rl(in,out).^5));
		end
	end
end
end
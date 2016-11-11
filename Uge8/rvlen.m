function rl = rvlen(rv)
	rl = squeeze(sqrt(rv(1,:,:).^2+rv(2,:,:).^2));
end
function rl=rvlen(rv)
% calculate the length of the vectors

s=size(rv);

rl=zeros(s);
rl=squeeze(sqrt(rv(1,:,:).^2+rv(2,:,:).^2));
% rl(2,:,:) = rl(1,:,:);
end
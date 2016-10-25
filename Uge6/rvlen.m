function rl = rvlen(rv)

s=size(rv);
if ndims(rv) == 3 && s(1) == 3
  rl=zeros(s);
  rl(1,:,:)=sqrt(rv(1,:,:).^2+rv(2,:,:).^2+rv(3,:,:).^2);
  rl(2,:,:) = rl(1,:,:);
  rl(3,:,:) = rl(1,:,:);
elseif ndims(rv) == 2 && s(1) == 3
  rl=zeros(1,s(2));
  for j=1:s(1)
    rl(j)=sqrt(rv(1,j).^2+rv(2,j).^2+rv(3,j).^2);
  end
else
    fprintf('The rvlen routine does not support the dimension of rv: (%i %i)\n',s)
    fprintf('has to be of dimension (3,#) or (3,#,#)\n')
    rl=-1;
end
end
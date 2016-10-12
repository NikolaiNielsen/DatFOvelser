r = eye(3);
s=size(r);
rv=zeros(s(1),s(2),s(2));

for i=1:s(1)
   for j=1:s(2)
      for k=1:s(2)
         fprintf('i = %d, j = %d, k = %d\n',i,j,k); 
		 fprintf('r(j,k) = %d, r(i,k) = %d\n', r(j,k),r(i,k));
		  rv(i,j,k)=r(j,k)-r(i,k);
      end
   end
end
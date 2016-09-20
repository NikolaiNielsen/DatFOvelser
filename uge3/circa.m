clear all

f = (1:10);
[size1,size2] = size(f);

if size2 == 1
	fm1 = circshift(f,[1,0]);
	fm2 = circshift(f,[2,0]);
	fm3 = circshift(f,[3,0]);
	fp1 = circshift(f,[-1,0]);
	fp2 = circshift(f,[-2,0]);
	fp3 = circshift(f,[-3,0]);
elseif size1 == 1
	fm1 = circshift(f,[0,1]);
	fm2 = circshift(f,[0,2]);
	fm3 = circshift(f,[0,3]);
	fp1 = circshift(f,[0,-1]);
	fp2 = circshift(f,[0,-2]);
	fp3 = circshift(f,[0,-3]);
end
% fm1 = circshift(f,[1,0]);
% fm2 = circshift(f,[2,0]);
% fm3 = circshift(f,[3,0]);
% fp1 = circshift(f,[-1,0]);
% fp2 = circshift(f,[-2,0]);
% fp3 = circshift(f,[-3,0]);
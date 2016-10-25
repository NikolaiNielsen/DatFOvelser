%% acc
function a=acc(m,rv,rl)

% calculate the acceleration of the object eq(3)

global G
c = rl.^-3;
c(isinf(c)) = 0;
a = -G*m.*rv.*c;
a = sum(a,3);

end
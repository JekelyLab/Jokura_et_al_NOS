function p1=scaled_lhsdesign(npop, npars_est, bounds)
% bounds 2xn matrix with first row lower bounds and second row upper bound.

convert=@(a,b)(a+(b-a)*lhsdesign(npop,1));

for j=npars_est:-1:1
    p1(:,j)=convert(bounds(1,j),bounds(2,j));
end
clear all, close all
    
matsize = [1000 2000 4000 8000];

for i = 1:length(matsize)
    n = matsize(i);
    A = rand(n); % square matrix, size n
    % timing starts here
    tstart = tic;
    inv(A);
    n
    telapsed = toc(tstart)
    invtimes(i) = telapsed;
end

%%

loglog(matsize,invtimes,"-x")
xlabel("Matrix size")
ylabel("Time for Inverse (s)")

%% find the best fit polynomial
logtime = log(invtimes);
logn = log(matsize);
pvals = polyfit(logn,logtime,1); % linear polynomial fit
% log(t) = A + B * log(n); pvals = [B A]
ordern = pvals(1)
clear; clc;

% CPLEX
% CeilofReqRB = []; % Required number of RBs

n = 4; % Number of RRHs
v = 40; % Number of vehicles
% v = length(CeilofReqRB); % Number of vehicles
MRB = 50;
Remain = MRB.*ones(1,v);
y = zeros(v); 

% For Decreasing-Based Algorithms
[CeilofReqRBd1,dec] = sort(-CeilofReqRB); % Sort ReqRBs in decreasing size order
CeilofReqRBd = -CeilofReqRBd1;
[tmp,rec] = sort(dec);

disp('Heuristic Algorithms');
disp('0 - Algorithms are in sequence:');
disp('1 - First Fit');
disp('2 - Best Fit');
disp('3 - First Fit Decreasing');
disp('4 - Best Fit Decreasing');
chos = input('Enter Your Choice: ');
if isempty(chos), chos = 0; 
end

tic
% **********************************************************
if chos == 0 || chos == 1  % First Fit Algorithm
% For each ReqRB i, find the first RRH that has sufficient capacity
% Assign ReqRB i to that RRH and update the RRH's remaining capacity

yff = y; Remainff = Remain;
for i = 1:v
   idx = find(CeilofReqRB(i)*ones(1,v) <= Remainff, 1 );
   yff(i,idx) = 1; 
   Remainff(idx) = Remainff(idx) - CeilofReqRB(i);
end
disp('First Fit Algorithm: ')
disp('The assignments are:')
disp(yff)
capff = CeilofReqRB*yff; 
nRRHff = sum(capff > 0);
disp(['Total # of RRHs used = ' int2str(nRRHff)]); 
disp('The capacity of each RRH is:');
disp(capff(1:nRRHff))

end

toc

tic
% ----------------------------------------------------
if chos == 0 || chos == 2  % Best Fit Algorithm
% For each ReqRB i, find the RRH whose remaining capacity
% best match the ReqRB size, and assign it to that RRH

ybf = y; Remainbf = Remain; 
for i = 1:v 
   idx1 = find(CeilofReqRB(i)*ones(1,v) <= Remainbf); 
   [tmp,idx2] = min(Remainbf(idx1) - CeilofReqRB(i));    
   ybf(i,idx1(idx2)) = 1; Remainbf(idx1(idx2)) = tmp;
end
disp('Best Fit Algotithm: ')
disp('The assignments are:')
disp(ybf)
capbf = CeilofReqRB*ybf; 
nRRHbf = sum(capbf > 0);
disp(['Total # of RRHs used = ' int2str(nRRHbf)]); 
disp('The capacity of each RRH is:');
disp(capbf(1:nRRHbf))

end
toc

tic
% ----------------------------------------------------
if chos == 0 || chos == 3   % First Fit Decreasing Algorithm
% Sort ReqRBs in decreasing order and then apply First Fit Algorithm

yffd = y; Remainffd = Remain; 
for i = 1:v
   idx = find(CeilofReqRBd(i)*ones(1,v)<=Remainffd, 1 );
   yffd(i,idx) = 1; Remainffd(idx) = Remainffd(idx) - CeilofReqRBd(i);
end
yffd = yffd(rec,:); 

disp('First Fit Decreasing Algorithm: ')
disp('The assignments are:')
disp(yffd)
capffd = CeilofReqRB*yffd; 
nRRHffd = sum(capffd > 0);
disp(['Total # of RRHs used = ' int2str(nRRHffd)]); 
disp('The capacity of each RRH is:');
disp(capffd(1:nRRHffd))

end

toc

tic
% ----------------------------------------------------
if chos == 0 || chos == 4  % Best Fit Decreasing Algorithm
% Sort ReqRBs in decreasing order and then apply Best Fit Algorithm

ybfd = y; Remainbfd = Remain; 
for i = 1:v 
   idx1 = find(CeilofReqRBd(i)*ones(1,v) <= Remainbfd); 
   [tmp,idx2] = min(Remainbfd(idx1) - CeilofReqRBd(i));
   ybfd(i,idx1(idx2)) = 1; Remainbfd(idx1(idx2)) = tmp;
end
ybfd = ybfd(rec,:); 

disp('Best Fit Decreasing Algotithm: ')
disp('The assignments are:')
disp(ybfd)
capbfd = CeilofReqRB*ybfd; 
nRRHbfd = sum(capbfd > 0);
disp(['Total # of RRHs used = ' int2str(nRRHbfd)]); 
disp('The capacity of each RRH is:');
disp(capbfd(1:nRRHbfd))

end  
toc

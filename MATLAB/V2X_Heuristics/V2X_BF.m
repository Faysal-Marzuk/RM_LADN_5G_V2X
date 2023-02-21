clear; clc;

ReqRB = []; % Requested RBs by each vehicle
v = length(ReqRB); % Number of vehicles
MRB = 50; % Available RBs for RRH (RRH capacity)
Remain = MRB.*ones(1,v); % Remain capacity of RRH
y = zeros(v); %  Assignments of vehicles

% Best Fit Algorithm
% For each ReqRB i, find the RRH whose remaining capacity
% best match the ReqRB size, and assign it to that RRH

 tic
 ybf = y; 
 Remainbf = Remain; 
 for i = 1:v 
    obj1 = find(ReqRB(i) <= Remainbf); 
%   [tmp,obj2] = min(Remainbf(obj1) - ReqRB(i));    
    ybf(i,obj1(obj2)) = 1; Remainbf(obj1(obj2)) = tmp;
 end
 disp('Best Fit Algotithm')
 disp('The assignments are:')
 disp(ybf)
 capbf = ReqRB*ybf; 
 nRRHbf = sum(capbf > 0);
 disp(['Number of active RRHs is: ' int2str(nRRHbf)]); 
 disp('Capacity of each RRH is:');
 disp(capbf(1:nRRHbf))
 
 toc

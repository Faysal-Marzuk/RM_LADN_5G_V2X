clear; clc;

ReqRB = []; % Requested RBs by each vehicle
v = length(ReqRB); % Number of vehicles
MRB = 50; % Available RBs for RRH (RRH capacity)
Remain = MRB.*ones(1,v); % Remain capacity of RRH
y = zeros(v); %  Assignments of vehicles

% First Fit Algorithm
% For each ReqRB i, find the first RRH that has sufficient capacity
% Assign ReqRB i to that RRH and update the RRH's remaining capacity

tic

yff = y; 
Remainff = Remain;
for i = 1:v
   obj = find(ReqRB(i) <= Remainff, 1);
   yff(i,obj) = 1; 
   Remainff(obj) = Remainff(obj) - ReqRB(i);
end
disp('First Fit Algorithm')
disp('The assignments are:')
disp(yff)
capff = ReqRB*yff; 
nRRHff = sum(capff > 0);
disp(['Number of active RRHs is: ' int2str(nRRHff)]); 
disp('Capacity of each RRH is:');
disp(capff(1:nRRHff))

toc

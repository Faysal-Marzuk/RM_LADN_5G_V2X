clear; clc;

ReqRB = []; % Requested RBs by each vehicle
v = length(ReqRB); % Number of vehicles
MRB = 50; % Available RBs for RRH (RRH capacity)
Remain = MRB.*ones(1,v); % Remain capacity of RRH
y = zeros(v); %  Assignments of vehicles

% First Fit Decreasing Algorithm
% Sort ReqRBs in a descending order and then apply First Fit Algorithm

[ReqRBdesc,desc] = sort(-ReqRB); % Sort ReqRBs in descending order
ReqRBdec = -ReqRBdesc;
[tmp,def] = sort(desc); % Sort ReqRBs back into default order

 tic

yffd = y; 
Remainffd = Remain; 
for i = 1:v
    obj = find(ReqRBdec(i) <= Remainffd, 1);
    yffd(i,obj) = 1; 
    Remainffd(obj) = Remainffd(obj) - ReqRBdec(i);
 end
 yffd = yffd(def,:); 
 
 disp('First Fit Decreasing Algorithm')
 disp('The assignments are:')
 disp(yffd)
 capffd = ReqRB*yffd; 
 nRRHffd = sum(capffd > 0);
 disp(['Number of active RRHs is: ' int2str(nRRHffd)]); 
 disp('Capacity of each RRH is:');
 disp(capffd(1:nRRHffd))
 
 toc

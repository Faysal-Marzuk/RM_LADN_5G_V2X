clear; clc;

ReqRB = []; % Requested RBs by each vehicle
v = length(ReqRB); % Number of vehicles
MRB = 50; % Available RBs for RRH (RRH capacity)
Remain = MRB.*ones(1,v); % Remain capacity of RRH
y = zeros(v); %  Assignments of vehicles

% Best Fit Decreasing Algorithm
% Sort ReqRBs in a descending order and then apply Best Fit Algorithm

[ReqRBdesc,desc] = sort(-ReqRB); % Sort ReqRBs in descending order
ReqRBdec = -ReqRBdesc;
[tmp,def] = sort(desc); % Sort ReqRBs back into default order

tic

ybfd = y; 
Remainbfd = Remain; 
for i = 1:v 
    obj1 = find(ReqRBdec(i) <= Remainbfd); 
    [tmp,obj2] = min(Remainbfd(obj1) - ReqRBdec(i));
    ybfd(i,obj1(obj2)) = 1; 
    Remainbfd(obj1(obj2)) = tmp;
 end
 ybfd = ybfd(def,:); 
 
 disp('Best Fit Decreasing Algotithm')
 disp('The assignments are:')
 disp(ybfd)
 capbfd = ReqRB*ybfd; 
 nRRHbfd = sum(capbfd > 0);
 disp(['Number of active RRHs is: ' int2str(nRRHbfd)]); 
 disp('Capacity of each RRH is:');
 disp(capbfd(1:nRRHbfd))
 
 toc

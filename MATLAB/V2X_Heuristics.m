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

% % Best Fit Algorithm
% % For each ReqRB i, find the RRH whose remaining capacity
% % best match the ReqRB size, and assign it to that RRH
% 
% tic
% ybf = y; 
% Remainbf = Remain; 
% for i = 1:v 
%    obj1 = find(ReqRB(i) <= Remainbf); 
%    [tmp,obj2] = min(Remainbf(obj1) - ReqRB(i));    
%    ybf(i,obj1(obj2)) = 1; Remainbf(obj1(obj2)) = tmp;
% end
% disp('Best Fit Algotithm')
% disp('The assignments are:')
% disp(ybf)
% capbf = ReqRB*ybf; 
% nRRHbf = sum(capbf > 0);
% disp(['Number of active RRHs is: ' int2str(nRRHbf)]); 
% disp('Capacity of each RRH is:');
% disp(capbf(1:nRRHbf))
% 
% toc
% 
% % For Decreasing-based Algorithms
% [ReqRBdesc,desc] = sort(-ReqRB); % Sort ReqRBs in descending order
% ReqRBdec = -ReqRBdesc;
% [tmp,def] = sort(desc); % Sort ReqRBs back in default order
% 
% % First Fit Decreasing Algorithm
% % Sort ReqRBs in decreasing order and then apply First Fit Algorithm
% 
% tic
% 
% yffd = y; 
% Remainffd = Remain; 
% for i = 1:v
%    obj = find(ReqRBdec(i) <= Remainffd, 1 );
%    yffd(i,obj) = 1; 
%    Remainffd(obj) = Remainffd(obj) - ReqRBdec(i);
% end
% yffd = yffd(def,:); 
% 
% disp('First Fit Decreasing Algorithm')
% disp('The assignments are:')
% disp(yffd)
% capffd = ReqRB*yffd; 
% nRRHffd = sum(capffd > 0);
% disp(['Number of active RRHs is: ' int2str(nRRHffd)]); 
% disp('Capacity of each RRH is:');
% disp(capffd(1:nRRHffd))
% 
% toc
% 
% % Best Fit Decreasing Algorithm
% % Sort ReqRBs in decreasing order and then apply Best Fit Algorithm
% 
% tic
% 
% ybfd = y; 
% Remainbfd = Remain; 
% for i = 1:v 
%    obj1 = find(ReqRBdec(i) <= Remainbfd); 
%    [tmp,obj2] = min(Remainbfd(obj1) - ReqRBdec(i));
%    ybfd(i,obj1(obj2)) = 1; 
%    Remainbfd(obj1(obj2)) = tmp;
% end
% ybfd = ybfd(def,:); 
% 
% disp('Best Fit Decreasing Algotithm')
% disp('The assignments are:')
% disp(ybfd)
% capbfd = ReqRB*ybfd; 
% nRRHbfd = sum(capbfd > 0);
% disp(['Number of active RRHs is: ' int2str(nRRHbfd)]); 
% disp('Capacity of each RRH is:');
% disp(capbfd(1:nRRHbfd))
% 
% toc

clear; clc; 

numberOfVehicles = 1000; % 2000; 3000; 4000;
numberOfRRHs = 400;
x1 = rand(1, numberOfRRHs)*10;
y1 = rand(1, numberOfRRHs);
x2 = rand(1, numberOfVehicles)*10;
y2 = rand(1, numberOfVehicles);

% close all;
% figure;
% hold on;
% hNodes = plot(x1, y1, 'rh', x2, y2, 'b.', 'MarkerSize', 15);
% title('Snapshots of Vehicles Positions')
% xlabel('Distance [km]')
% ylabel('Distance [km]')
% legend({'RRH','Vehicle'})
% for i = 1 : numberOfRRHs
%     text(x1(i)+0.02, y1(i)+0.02, num2str(i),'Color','r')
% end
% for j = 1 : numberOfVehicles
%     text(x2(j)+0.02, y2(j)+0.02, num2str(j),'Color','b')
% end

alpha = 3.5;
PtdBm = 23;
Pt = 10^(PtdBm/10);
R = 1;
In = calcIn(alpha,R,Pt);
BW = 10*10^(6);
NOcdBm = -174 + 10*log10(BW);
NOc = 10^(NOcdBm/10);
Distance = zeros;
SINR = zeros;
SINRdB =zeros;
Efficiency = zeros;
DataRate = zeros;
UpLinkDataRate = zeros;
MaxRB = zeros;
ReqRB = zeros;
CeilofReqRB = zeros;

count = 1;
for i = 1 : numberOfRRHs
    for j = 1 : numberOfVehicles
        
    Distance(i,j) = sqrt((x1(i) - x2(j))^2 + (y1(i) - y2(j))^2);
    SINR(i,j) = (Pt*((Distance(i,j)).^-alpha))/((numberOfRRHs)*In + NOc);
    SINRdB(i,j)=10*log10(SINR(i,j));

    if (SINRdB(i,j) <= -9.5)
        Efficiency(i,j) = 0.000001;
    elseif (SINRdB(i,j) > -9.5) && (SINRdB(i,j) <= -6.7)
        Efficiency(i,j) = 0.1523;
    elseif (SINRdB(i,j) > -6.7) && (SINRdB(i,j) <= -4.1)
        Efficiency(i,j) = 0.2344;
    elseif (SINRdB(i,j) > -4.1) && (SINRdB(i,j) <= -1.8)
        Efficiency(i,j) = 0.3770;
    elseif (SINRdB(i,j) > -1.8) && (SINRdB(i,j) <= 0.4)
        Efficiency(i,j) = 0.6016;    
    elseif (SINRdB(i,j) > 0.4) && (SINRdB(i,j) <= 2.5)
        Efficiency(i,j) = 0.8770;
    elseif (SINRdB(i,j) > 2.5) && (SINRdB(i,j) <= 4.5)
        Efficiency(i,j) = 1.1758;    
    elseif (SINRdB(i,j) > 4.5) && (SINRdB(i,j) <= 6.5)
        Efficiency(i,j) = 1.4766;    
    elseif (SINRdB(i,j) > 6.5) && (SINRdB(i,j) <= 8.5)
        Efficiency(i,j) = 1.9141;
    elseif (SINRdB(i,j) > 8.5) && (SINRdB(i,j) <= 10.3)
        Efficiency(i,j) = 2.4063;        
    elseif (SINRdB(i,j) > 10.3) && (SINRdB(i,j) <= 12.3)
        Efficiency(i,j) = 2.7305;    
    elseif (SINRdB(i,j) > 12.3) && (SINRdB(i,j) <= 14.2)
        Efficiency(i,j) = 3.3223;    
    elseif (SINRdB(i,j) > 14.2) && (SINRdB(i,j) <= 15.9)
        Efficiency(i,j) = 3.9023;
    elseif (SINRdB(i,j) > 15.9) && (SINRdB(i,j) <= 17.8)
        Efficiency(i,j) = 4.5234;    
    elseif (SINRdB(i,j) > 17.8) && (SINRdB(i,j) <= 19.8)
        Efficiency(i,j) = 5.1152;    
    elseif (SINRdB(i,j) > 19.8) 
        Efficiency(i,j) = 5.5547;
    end
        
    DataRate(i,j) = 12*14*Efficiency(i,j)*1000;  
    UpLinkDataRate(j) = 1000000;
    MaxRB(i) = 50;
    ReqRB(i,j) = UpLinkDataRate(j)/DataRate(i,j);
    CeilofReqRB(i,j) = ceil(ReqRB(i,j));

    count = count + 1; 
    end
end

disp(SINRdB)
disp(Efficiency)
disp(DataRate)
disp(ReqRB)
disp(CeilofReqRB)

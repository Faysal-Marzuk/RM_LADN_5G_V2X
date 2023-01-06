clear; clc; clf;
x1 = 0; x2 = 2;
y1 = 0; y2 = 2;
x = [x1, x2, x1, x2, x1];
y = [y2, y2, y1, y1, y2];
plot(x, y, 'b-');
hold on;
hConnections = [];
numberOfCars = 50;
numberOfRRHs = 4;

x3 = rand(1, numberOfCars)*2;
y3 = rand(1, numberOfCars)*2;
close all;
figure;
hold on;
hNodes = plot(x, y, 'rh', x3, y3, 'b.');
title('Snapshots of Vehicles Positions')
xlabel('Distance [km]')
ylabel('Distance [km]')
legend({'RRH','Vehicle'})
for i = 1 : numberOfRRHs
    text(x(i)+0.02,y(i)+0.02, num2str(i),'Color','r')
end
for j = 1 : numberOfCars
    text(x3(j)+0.01, y3(j)+0.01, num2str(j),'Color','b')
end
for i = 1 : size(x,1)-1
    for j = i+1 : size(x,1)
        hConnections = [hConnections ; line([x(i);x(j)], [y(i);y(j)])];
    end
end
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
count = 1;
for i = 1 : numberOfRRHs
    for j = 1 : numberOfCars
    Distance(i,j) = sqrt((x(i) - x3(j))^2 + (y(i) - y3(j))^2);
    DistMatrix(count, :) = [x(i) y(i) x3(j) y3(j) Distance(i,j)];
    SINR(i,j) = (Pt*((Distance(i,j)).^-alpha))/((numberOfRRHs)*In + NOc);
    SINRdB(i,j)=10*log10(SINR(i,j));
    SINRdBMatrix(count, :) = [x(i) y(i) x3(j) y3(j) SINRdB(i,j)];
    if (SINRdB(i,j) > -9.5) & (SINRdB(i,j) <= -6.7)
        Efficiency(i,j) = 0.1523;
    elseif (SINRdB(i,j) > -6.7) & (SINRdB(i,j) <= -4.1)
        Efficiency(i,j) = 0.2344;
    elseif (SINRdB(i,j) > -4.1) & (SINRdB(i,j) <= -1.8)
        Efficiency(i,j) = 0.3770;
    elseif (SINRdB(i,j) > -1.8) & (SINRdB(i,j) <= 0.4)
        Efficiency(i,j) = 0.6016;    
    elseif (SINRdB(i,j) > 0.4) & (SINRdB(i,j) <= 2.5)
        Efficiency(i,j) = 0.8770;
    elseif (SINRdB(i,j) > 2.5) & (SINRdB(i,j) <= 4.5)
        Efficiency(i,j) = 1.1758;    
    elseif (SINRdB(i,j) > 4.5) & (SINRdB(i,j) <= 6.5)
        Efficiency(i,j) = 1.4766;    
    elseif (SINRdB(i,j) > 6.5) & (SINRdB(i,j) <= 8.5)
        Efficiency(i,j) = 1.9141;
    elseif (SINRdB(i,j) > 8.5) & (SINRdB(i,j) <= 10.3)
        Efficiency(i,j) = 2.4063;        
    elseif (SINRdB(i,j) > 10.3) & (SINRdB(i,j) <= 12.3)
        Efficiency(i,j) = 2.7305;    
    elseif (SINRdB(i,j) > 12.3) & (SINRdB(i,j) <= 14.2)
        Efficiency(i,j) = 3.3223;    
    elseif (SINRdB(i,j) > 14.2) & (SINRdB(i,j) <= 15.9)
        Efficiency(i,j) = 3.9023;
    elseif (SINRdB(i,j) > 15.9) & (SINRdB(i,j) <= 17.8)
        Efficiency(i,j) = 4.5234;    
    elseif (SINRdB(i,j) > 17.8) & (SINRdB(i,j) <= 19.8)
        Efficiency(i,j) = 5.1152;    
    elseif (SINRdB(i,j) > 19.8) 
        Efficiency(i,j) = 5.5547;
    end
       
    EfficiencyMatrix(count, :) = [x(i) y(i) x3(j) y3(j) Efficiency(i,j)];    
    DataRate(i,j) = 12*7*Efficiency(i,j)*1000/0.5;
    DataRateMatrix(count, :) = [x(i) y(i) x3(j) y3(j) DataRate(i,j)];
    count = count + 1;    
    end
end

DistMatrix = sort(DistMatrix, 5);
SINRdBMatrix = sort(SINRdBMatrix, 5);
EfficiencyMatrix = sort(EfficiencyMatrix, 5);
display(DistMatrix)
display(SINRdBMatrix)
display (EfficiencyMatrix)

figure;
hold on;
subplot(2,2,1)
bar(Distance(1,:),0.4,'b');
title('Vehicles Distances from RRH1')
xlabel('Vehicles')
ylabel('Distance [km]')

subplot(2,2,2)
bar(Distance(2,:),0.4,'r');
title('Vehicles Distances from RRH2')
xlabel('Vehicles')
ylabel('Distance [km]')

subplot(2,2,3)
bar(Distance(3,:),0.4,'g');
title('Vehicles Distances from RRH3')
xlabel('Vehicles')
ylabel('Distance [km]')

subplot(2,2,4)
bar(Distance(4,:),0.4,'m');
title('Vehicles Distances from RRH4')
xlabel('Vehicles')
ylabel('Distance [km]')

figure;
hold on;

subplot(2,2,1)
bar(SINRdB(1,:),0.4,'b');
title('RRH1 & Pt = 23 [dBm]')
xlabel('Vehicles')
ylabel('SINR  [dB]')

subplot(2,2,2)
bar(SINRdB(2,:),0.4,'r');
title('RRH2 & Pt = 23 [dBm]')
xlabel('Vehicles')
ylabel('SINR  [dB]')

subplot(2,2,3)
bar(SINRdB(3,:),0.4,'g');
title('RRH3 & Pt = 23 [dBm]')
xlabel('Vehicles')
ylabel('SINR  [dB]')

subplot(2,2,4)
bar(SINRdB(4,:),0.4,'m');
title('RRH4 & Pt = 23 [dBm]')
xlabel('Vehicles')
ylabel('SINR  [dB]')

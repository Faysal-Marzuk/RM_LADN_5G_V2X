/*********************************************
 * OPL 12.7.1.0 Model
 * Author: Faysal
 * Creation Date: Feb 1, 2021 at 5:26:32 PM
 *********************************************/

 // Indices
 int N = ...; // Number of RRH
 range n = 1..N;
 int V = ...; // Number of Vehicles
 range v = 1..V;
 // Constants
 int I[n];
 execute {
  for (var i in n)  
     I[i] = 1;
 	}
 int II[v];
 execute {
  for (var i in v)  
     II[i] = 1;
 	}
 int III[n][v];
 execute {
  for(var i in n){
  	for (var j in v)  
     I[i][j] = 1;
 	  }
 	} 
 int mRB = ...; 
 int MRB[n1 in n] = mRB*I[n1]; // Number of uplink RBs available for RRH per frame
 float s = ...;
 float S[n1 in n][v1 in v] = s*III[n1][v1]; // Signalling RBs necessary to support communications if vehicle is assigned to RRH
 // float S[n1 in n][v1 in v] = ...;
 float t = ...;
 float T[n1 in n] = t*I[n1]; // Signalling RBs necessary to service RRH when it is switched on
 // float T[n1 in n] = ...;
 float H = ...;
 // int h = ...;
 // int H[n1 in n][v1 in v] = h*III[n1][v1]; // Threshold value for SINR
 
 float ceilofR[n1 in n][v1 in v] = ...;
 float SINR[n1 in n][v1 in v] = ...;
 float ActR[n][v];

// Decision Variables
 dvar boolean x[n]; // Turn on RRH
 dvar boolean y[n][v]; // Associate Vehicle v to RRH n
 // Objective Function
 	
 	 minimize sum(i in n) x[i];
 
 		subject to{ 	
 		 	forall(i in n){
 		 	  // sum(j in v)y[i][j]*ceilofR[i][j] <= MRB[i];
 		 	  sum(j in v)y[i][j]*(ceilofR[i][j]+S[i][j]) + x[i]*T[i] <= MRB[i];
 		 	  sum(j in v)y[i][j]*SINR[i][j] >= H;
 		 	  // sum(j in v)y[i][j]*SINR[i][j] >= H[i][j];
     		}
     		forall(j in v)  
     			sum(i in n)y[i][j] == 1;
     			
     		forall (i in n, j in v){
     			x[i] >= y[i][j];     		
     		}	   		
 }
 
 execute {
 	for (var i in n)
 		for (var j in v)
 			ActR[i][j] = ceilofR[i][j]*y[i][j]; 
 }

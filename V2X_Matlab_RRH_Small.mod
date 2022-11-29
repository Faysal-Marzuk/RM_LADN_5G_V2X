
/*********************************************
 * OPL 12.7.1.0 Model
 * Author: Faysal
 * Creation Date: Apr 15, 2019 at 10:50:35 PM
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
 int mRB = ...; 
 int MRB[n1 in n] = mRB*I[n1]; // Number of uplink RBs available for RRH per frame
 int ceilofR[n1 in n][v1 in v] = ...;
 int ActR[n][v];

// Decision Variables
 dvar int x[n]; // Turn on RRH
 dvar int y[n][v]; // Associate Vehicle v to RRH n
 // Objective Function
 	
 	 minimize sum(i in n) x[i];
 
 		subject to{ 	
 		 	forall(i in n){
 		 	  MRB[i] - sum(j in v)y[i][j]*ceilofR[i][j] >= 0;
 		 	  x[i] <= 1;
     		}
     		forall(j in v)  
     			sum(i in n)y[i][j] == 1;
     		forall (i in n, j in v){
     			y[i][j] >= 0;
     			x[i] >= y[i][j];     		
     		}	   		
 }
 
 execute {
 	for (var i in n)
 		for (var j in v)
 			ActR[i][j] = ceilofR[i][j]*y[i][j]; 
 }
 
 
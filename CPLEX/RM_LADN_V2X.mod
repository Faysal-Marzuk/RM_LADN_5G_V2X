 // Indices
 int N = ...; // Number of RRHs
 range n = 1..N;
 int V = ...; // Number of vehicles
 range v = 1..V;
 
 // Constants
 int I[n];
 execute {
  for (var i in n)  
     I[i] = 1;
 	}
 int mRB = ...; // Number of available uplink RBs at RRH
 int MRB[n1 in n] = mRB*I[n1]; 
 float H = ...; // Threshold value for SINR
 float ceilofR[n1 in n][v1 in v] = ...;
 float SINR[n1 in n][v1 in v] = ...;
 float ActR[n][v];

// Decision Variables
 dvar boolean x[n]; // Turn on RRH
 dvar boolean y[n][v]; // Associate Vehicle to RRH 
 
 // Objective Function 
 	
 	 minimize sum(i in n) x[i]; // Minimize number of turned-on RRH

// Constraints 
 		subject to{ 	
 		 	forall(i in n){
 		 	  // Number of required RBs should not exceed the number of available uplink RBs at RRH
 		 	  sum(j in v)y[i][j]*ceilofR[i][j] <= MRB[i];
 		 	  
 		 	  // Vehicle can be assigned to RRH if SINR value is larger than the threshold H
 		 	  sum(j in v)y[i][j]*SINR[i][j] >= H;   
     		}
     		forall(j in v)  
     			sum(i in n)y[i][j] == 1; // Each vehicle should be associated to one and only one RRH 
     			
     		forall (i in n, j in v)
     			x[i] >= y[i][j]; // Lower and Upper bounds of the binary decision variables    			   		
	 }
 
 execute {
 	for (var i in n)
 		for (var j in v)
 			ActR[i][j] = ceilofR[i][j]*y[i][j]; 
 	}

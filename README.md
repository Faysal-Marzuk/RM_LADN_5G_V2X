/************************************************************************************************************************************\

Please cite the following paper in case if using the code:

R. H. Hwang, F. Marzuk, M. Sikora, P. Chołda, and Y. D. Lin, “Resource Management in LADNs Supporting 5G V2X Communications,”                                           in 2020 IEEE 92nd Vehicular Technology Conference (VTC2020-Fall), 2020, pp. 1–6. DOI: 10.1109/VTC2020Fall49728.2020.9348689.


/************************************************************************************************************************************\

Resource Management in Local Access Data Networks (LADNs) Supporting 5G vehicle to everything (V2X) Communications.

The resource management problem is evaluated under three scenarios of V2X network topology with different sizes:                                                     
1) A small scenario (4 RRHs and 10-50 vehicles).                                                                                                                     
2) A medium-sized scenario (40 RRHs and 100-500 vehicles).                                                                                                          
3) A large scenario (400 RRHs and 1000-5000 vehicles).

 
************
I- MATLAB
************

- The positions of vehicles and the remote radio heads (RRHs) are generated randomly within the V2X network.
- Then the vehicles' SINR values are calculated depending on the distances of the vehicles from each RRH.
- Then the efficiency values are obtained according to SINR ranges from the mapping table specified in 3GPP TS 36.213 V15.7.0, Release 15. 
- Then the resource blocks (RBs) data rates are calculated using the efficiency and the sub-carriers.
- Finally, the number of required RBs is calculated to serve the requested uplink data rate from each vehicle.

************
II- CPLEX

************
- The objective of the optimization task is to minimize the number of turned-on RRHs.
- The objective function is subject to the uplink bandwidth constraints represented by intercell interference (ICI) and SINR.
- The constraints ensure that the number of required RBs should not exceed the number of available uplink RBs at RRH.
- The constraints indicate that the vehicle can be assigned to RRH if its SINR value is larger than the threshold value which guarantee the assigenment.
- The constraints state that each vehicle should be associated to one and only one RRH. 
- The binary decision variables are used to turn on/off the RRHs and to inicate whether a vehicle is associated to a RRH or not.


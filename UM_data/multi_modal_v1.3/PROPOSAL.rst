11-Dec-2015

Goal
----
Test multi-modal data analysis technique using two correlated time-series


Simulation
----------
Dataset for UM containing power consumption and LEU shipped, where SWU is
not constrained and power consumption has gaussian variation (caused by
variaion in U-235 content of tails).  Enrichment level of LEU produced also
varies with a discrete # of levels (3-5%, with steps of 0.3%).
Possibly also vary HEU amplitude.


Dataset
-------
# simulations: 100
# timesteps: 2000
signal guaranteed to be baseline for t< 1000


Signals to UM
--------------
- Power consumption vs time (proxied by SWU consumption)
- LEU shipped from Enrichment vs time


Signals available upon request
------------------------------
- Enrichment level of LEU requested vs time
- HEU received vs time


Cyclus Details
--------------
- variation in power consumption implemented as gaussian on tails enrichment
(feature must be added)
- only one LEU enrichment level requested per timestep
(feature must be added)

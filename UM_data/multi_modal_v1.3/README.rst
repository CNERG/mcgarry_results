Starting Point
--------------
Cyclus Develop: e94a5a3b10131d39c88e77a21dfc36074b0d29d6  (Nov 20 2015)
Cycamore Random_sink1.3 b55005a760ba29702e8b16fc1c9e476840a5f4c2 (Dec 2 2015)
	 --- included merged Cycamore develop (Aug 28 2015)

Final Code Base
----------------
Cyclus Develop: e94a5a3b10131d39c88e77a21dfc36074b0d29d6  (Nov 20 2015)
Cycamore Random_sink1.3 18c57f29105b0b1441a1f8a0e1cad13f3e7c8928  (Dec 9 2015)



Goal
----
Dataset for UM containing power consumption and LEU shipped, where SWU is
not constrained and power consumption has gaussian variation.  Enrichment
level of LEU produced also varies with a discrete # of levels (3-5%).
Possibly also vary HEU amplitude.

Modifications
-------------
1) Create xml with correct facilities to simulate variation in power consumed
due to variation in tails assay.
x    a) variation in LEU Qty requested (gaussian)
x    b) variation in Tails (gaussian)

x 2a) Single sink with discrete varying enrichment levels

[Following was unnecessary:
  2b) Multiple sinks with discrete enrichment levels
   a) RNG assign preference for each facility so that trade goes through
      	  for different enrichment levels each time
   b) For each not-chosen facility, set preference to zero for the timestep
   c) for this case a custom query is needed to provide total shipment table:
      {
         "facflow": "SELECT tl.Time AS Time,TOTAL(sub.qty) AS Quantity FROM timelist as tl LEFT JOIN ( SELECT t.simid AS simid,t.time as time,SUM(c.massfrac*r.quantity) as qty FROM transactions AS t JOIN resources as r ON t.resourceid=r.resourceid AND r.simid=t.simid JOIN agents as send ON t.senderid=send.agentid AND send.simid=t.simid JOIN agents as recv ON t.receiverid=recv.agentid AND recv.simid=t.simid JOIN compositions as c ON c.qualid=r.qualid AND c.simid=r.simid WHERE send.agentid=? AND recv.agentid=? GROUP BY t.time) AS sub ON tl.time=sub.time AND tl.simid=sub.simid GROUP BY tl.Time;"
	}
       ​cyan -db db.sqlite -custom query.json facflow min_FacID# max_FacID#

Retrieving SWUTimeSeries
------------------------
cyan -db=fulltest_HEU_every.sqlite table TimeSeriesEnrichmentSWU >> EF_power.dat


Testing Results
---------------
- Variation in tails from 0.1-0.3% results in a SWU range of 237-396
(test_tails_on2.sqlite)
- Variation in HEU production from 0 to 0.03kg results in SWU range 6-292 SWU
(test_swu_heu.sqlite)
- 5 different enrichments 3,3.5,4,4.5,5% results in SWU range 142-292
(test_recipe_multi5x.sqlite)

Sample to UM:  fulltest_HEU_every.sqlite
-------------
- HEU transfers every 5 timesteps after t=20
- HEU quantity 0.03kg, 90% U235
- Enrichments 3-5%, discrete
- Tails 0.2+/-0.1%, constrained Gaussian
- LEU quantity 33+/-0.5kg, standard Gaussian



#!/bin/bash

echo ' {"facinv": " SELECT tl.Time AS Time,IFNULL(sub.qty, 0) AS Quantity FROM timelist as tl LEFT JOIN ( SELECT tl.Time as time,SUM(inv.Quantity) AS qty FROM inventories as inv JOIN timelist as tl ON UNLIKELY(inv.starttime <= tl.time) AND inv.endtime > tl.time AND tl.simid=inv.simid JOIN agents as a on a.agentid=inv.agentid AND a.simid=inv.simid WHERE a.AgentId=?  GROUP BY tl.Time) AS sub ON sub.time=tl.time ",
"enrichlevels": " SELECT TimeCreated, MassFrac FROM Resources,Compositions WHERE Compositions.QualId = Resources.QualId and Compositions.NucID=922350000 and Compositions.QualId <>1"}' > query.json

for fac_id in 15 16; do
    fname=${fac_id}_${1}.dat
    ~/git/data_analysis/data/cyanb -db $1 -custom query.json facinv $fac_id > $fname
    python -c "from manip_data import ship_freq; intervals,extra=ship_freq(\"$fname\",100,\"SHIP_${fname}\")"
done;

~/git/data_analysis/data/cyanb -db $1 -custom query.json enrichlevels >> EL_${1}.dat

~/git/data_analysis/data/cyanb -db $1 table TimeSeriesEnrichmentSWU >> PWR_${1}.dat

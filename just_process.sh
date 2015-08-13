#!/bin/bash

echo ' {"facinv": " SELECT tl.Time AS Time,IFNULL(sub.qty, 0) AS Quantity FROM timelist as tl LEFT JOIN ( SELECT tl.Time as time,SUM(inv.Quantity) AS qty FROM inventories as inv JOIN timelist as tl ON UNLIKELY(inv.starttime <= tl.time) AND inv.endtime > tl.time AND tl.simid=inv.simid JOIN agents as a on a.agentid=inv.agentid AND a.simid=inv.simid WHERE a.AgentId=?  GROUP BY tl.Time) AS sub ON sub.time=tl.time "}' > query.json

for fac_id in 16 17 18 19 20; do
    fname=${fac_id}_${1}.dat
    ~/git/data_analysis/data/cyanb -db $1 -custom query.json facinv $fac_id > $fname
done;


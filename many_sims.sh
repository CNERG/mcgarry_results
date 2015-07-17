#!/bin/bash

echo ' {"facinv": " SELECT tl.Time AS Time,IFNULL(sub.qty, 0) AS Quantity FROM timelist as tl LEFT JOIN ( SELECT tl.Time as time,SUM(inv.Quantity) AS qty FROM inventories as inv JOIN timelist as tl ON UNLIKELY(inv.starttime <= tl.time) AND inv.endtime > tl.time AND tl.simid=inv.simid JOIN agents as a on a.agentid=inv.agentid AND a.simid=inv.simid WHERE a.AgentId=?  GROUP BY tl.Time) AS sub ON sub.time=tl.time "}' > query.json

for i in $(seq 100); do
    out=run-${i}.sqlite
    cyclus -o $out $1
    cyan -db $out post

    for fac_id in 16 18; do
        fname=run-${i}-fac-${fac_id}.dat
        ../../cyanb -db $out -custom query.json facinv $fac_id > $fname
    done
done;


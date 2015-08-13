#!/bin/bash
X=1000

for i in $(seq $X); do
    out=run-${i}.sqlite
#    CYCLUS_DEBUG_DRE=1 cyclus -o $out $1 -v LEV_DEBUG5 > $i.out
    CYCLUS_DEBUG_DRE=1 cyclus -o $out $1 > $i.out
done;

# Compare results
for i in $(seq $X) ; do
    diff ${i}.out ${i+1}.out >> diff.out
done;


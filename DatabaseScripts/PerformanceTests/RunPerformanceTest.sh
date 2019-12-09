#!/bin/bash

cd DatabaseScripts/PerformanceTests/Queries
echo 'Run first query...'

cat Query1.sql >> PerformanceTestLog.txt
echo "" >> PerformanceTestLog.txt
psql -d "CarReservationsDb" -f Query1.sql >> PerformanceTestLog.txt
echo "" >> PerformanceTestLog.txt

cat Query1JSONB.sql >> PerformanceTestLog.txt
echo "" >> PerformanceTestLog.txt
psql -d "CarReservationsDb" -f Query1JSONB.sql >> PerformanceTestLog.txt
echo "" >> PerformanceTestLog.txt

echo 'Full Log of Performance test:'
cat PerformanceTestLog.txt;
#!/bin/bash

# run queries on schemas
docker exec -it postgres-db bash ./DatabaseScripts/PerformanceTests/RunPerformanceTest.sh

# save performance test results to host machine
docker exec -it postgres-db cat "/DatabaseScripts/PerformanceTestResults/PerformanceTestLog.txt" > ~/PerformanceTestResults/PerformanceTestLog.txt

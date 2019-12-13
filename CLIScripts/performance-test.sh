#!/bin/bash

docker exec -it postgres-db bash ./DatabaseScripts/PerformanceTests/RunPerformanceTest.sh
docker exec -it postgres-db cat "/DatabaseScripts/PerformanceTestResults/PerformanceTestLog.txt" > ~/PerformanceTestResults/PerformanceTestLog.txt
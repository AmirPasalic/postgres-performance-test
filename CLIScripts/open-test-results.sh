#!/bin/bash

#Exit when any command fails
set -e

#Exit script if an unsed variable is used
set -o nounset

# TODO:

# Option to list all file names

# Option to set fileNames

# Open all text files in default text editor
# Quer1.txt, Quer2.txt, Quer3.txt

# example:

# open-test-results -h --help
    # or
# open-test-results -- list existing files
# open-test-results -a
# open-test-results -f Query1FullLog.txt Query2FullLog.txt Query3FullLog.txt
#!/bin/bash

set -exu

git clone https://github.com/adriangranados/dfs-pulse-tester.git src/dfs-pulse-tester

find ./pybombs -type d -name '.git' | xargs rm -rf
find ./pybombs -type d -name 'build' | xargs rm -rf

find ./src -type d -name '.git' | xargs rm -rf
find ./src -type d -name 'build' | xargs rm -rf

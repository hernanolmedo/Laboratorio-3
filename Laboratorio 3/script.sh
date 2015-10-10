#!/bin/bash
cd /home/max/Documents/Laboratorio-3/Laboratorio\ 3
gcc -Wall -O0 -pg main.c -o main
./main -n 0.5
gprof main gmon.out > analysis
git add --all
git commit
git push --all


#!/usr/bin/python
'''
gets original data fielname and probability for each row to be present in 
output.

Used to shrink data to speed-up processing and cut down used memory.
'''


import random
import sys

if __name__ == '__main__':
    filename = sys.argv[1]
    probability = float(sys.argv[2])
    
    f = open(filename, 'r')
    for line in f:
        if random.random() <= probability:
            sys.stdout.write(line + "\n")
    f.close()

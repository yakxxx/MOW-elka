#!/usr/bin/python

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

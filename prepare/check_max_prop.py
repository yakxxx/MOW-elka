#!/usr/bin/python
'''
Check maximum parameter number. It will be number of columns in tabelar data
'''

import sys, os, logging


if __name__ == '__main__':
    max_val = -1
    filename = sys.argv[1]
    f = open(filename, 'r')
    for line in f:
        numbers = [ int(x) for x in line.split() ]
        max_val = max([max_val] + numbers)
    f.close()
    print max_val

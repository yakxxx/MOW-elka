import sys
import os
import logging

COLS = 468

def make_row(line):
    numbers = set(line.split())
    row = ['1' if str(i) in numbers else '0' for i in xrange(1, COLS+1)]
    return row



if __name__ == "__main__":
    filename = sys.argv[1]
    if not os.path.isfile(filename):
        logging.error("Wrong filename")
        sys.exit(1)

    f_in = open(filename, 'r')
    f_out = open('out','w')
    for line in f_in:
        row = make_row(line)
        f_out.write(' '.join(row)+"\n")
    f_in.close()
    f_out.close()


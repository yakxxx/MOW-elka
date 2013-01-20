from random import *
import sys


def create_bg(column_probab, nrow):
    out = []
    for row in xrange(nrow):
        line = []
        for col in xrange(len(column_probab)):
            if random() <= column_probab[col]:
                line.append(1)
            else:
                line.append(0)
        out.append(line)
    return out


def create_cluster(column_probab, nrow, cluster_cols):
    cluster = create_bg(column_probab, nrow)
    for row in xrange(nrow):
        for col in cluster_cols:
            cluster[row][col] = 1
    return cluster


if __name__ == '__main__':
    nrow = 37*40
    ncol = 128
    nclust = 6
    clust_cols_no = 12
    clust_rows_no = 2*37
   
    column_probab = [abs(gauss(0.2, 0.1)) for _ in xrange(ncol)]
    sys.stderr.write(str(column_probab))

    bg = create_bg(column_probab, nrow)
    
    for i in xrange(nclust):
        clust = create_cluster(column_probab, clust_rows_no,
                    sample(range(ncol), clust_cols_no))
        bg = bg + clust

    for line in bg:
        line = [str(i) for i in line]
        print ' '.join(line)




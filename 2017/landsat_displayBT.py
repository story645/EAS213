# this script will do the following:
# 1. read landsat thermal data using landsat_read
# 2. Convert to temperature using the BT function
# 3. display it in greyscale using RGB_display

# import libraries we may use
# import numpy as np
import matplotlib.pyplot as plt
import landsat_sample_functions as lf

folder = '/users/brianvanthull2/documents/outreach/HIRES/python/'
IRdatafile = folder + 'data/landsat_thermrad.txt'
#IRdatafile = folder + 'python/landsat_archive/landsat_thermrad_2015-04-13.txt'

# read landsat data
#from landsat_read import landsat_read
thermrad = lf.landsat_read(IRdatafile)

#Convert to BT 
# from BT import BT
BT = lf.BT(thermrad,10.9,1)

# display
#from grayscale_display import grayscale_display
lf.grayscale_display(BT)

plt.savefig(folder+'python/landsat_NYC_BT.png')

print 'done'

# quit()
# this script will do the following:
# 1. read landsat rgbn data using landsat_read
# 2. trim it down to RGB data
# 3. display it using RGB_display

# import libraries we may use
import numpy as np
import matplotlib.pyplot as plt
import landsat_sample_functions as lf

folder = '/users/brianvanthull2/documents/outreach/HIRES/python/'
#rgbdatafile = folder + 'python/landsat_archive/landsat_reflectances_2014-08-16.txt'
rgbdatafile = folder + 'data/landsat_RGBN.txt'

# read landsat data
#from landsat_read import landsat_read
rgbn = lf.landsat_read(rgbdatafile)

# trim to rgb (and flip in y direction)
dimensions = rgbn.shape
print 'dimensions of rgbn = '
print dimensions

rgb = rgbn[:, :, 0:3]
#rgb = rgb[::-1,:,:]


# display
#from rgb_display import rgb_display
lf.rgb_display(rgb)

plt.savefig(folder+'landsat_NYC_rgb.png')

print 'done'

# quit()
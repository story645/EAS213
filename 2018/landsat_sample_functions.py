# set of functions to work with landsat data formatted for HIRES

import numpy as np
import matplotlib.pyplot as plt

# --------------------------------

def landsat_read(filename):
    """read in the provided landset text file
    """
    with open(filename, 'r') as f:
        #read descriptive lines and throw away
        linetext = f.readline()
        linetext = f.readline()
        linetext = f.readline()
        linetext = f.readline()
        linetext = f.readline()


        #read the dimensions of the file
        dims = np.fromstring(f.readline(), dtype=int, sep=" ")
        rows, cols, nvars = dims
		
	
        #read in the rest of the data
        #data_array = np.fromstring(f.read(), dtype=float, sep=" ")
        #can also be done as np.loadtxt(filename, skiprows=3)
        data_array = np.zeros([rows,cols,nvars],dtype=float)
        for v in range(0,nvars):
            for r in range(0,rows):
                linetext = f.readline()
                datline = np.fromstring(linetext,dtype=float, sep=" ")
                data_array[r,:,v] = datline
		
	
    #reshape the data so it's in the correct order
    #order = Fortran because data was likely written in fortran
    #data_array = data_array.reshape(cols, rows, nvars, order='F')

    # remove single layer dimensions
    data_array = np.squeeze(data_array)

    f.close()
    
    return data_array

#--------------------------

def rgb_display(rgb_array):
    """displayes RGB image x contrast,
        railed off if too high or low
    """
    
    contrast = 1
   
    while contrast:
        rgbc_array = contrast*rgb_array
        maximg = rgbc_array.max()
        
        low = (rgbc_array<0)
        rgbc_array[low] = 0
        
        high = (rgbc_array>1)
        rgbc_array[high] = 1
        
        plt.ion()
        plt.imshow(rgbc_array, interpolation='bilinear', origin='upper')
        plt.show()

        contrast = int(input("Enter Contrast, 0 to exit: "))

    return rgbc_array

#-----------------

def BT(I,wl,e):
	"""calculates brightness temperature from the following:
		Intensity (radiance) in watts/m^2/mictron/steradian
		wavelength in microns
		emissivity
		written so it can take a complete array of I
	"""
								
	A = 1.19e8 ; #watts microns^4/m^2
	B = 1.441e4; #micron-kelvins

	T = B/(wl*np.log(1+(e*A/(I*wl**5))));
	return T

#------------------

def grayscale_display(img_array):
    """ displays 2d image as grayscale
    """

    # first scale image to between 0 and 1
    img_array = (img_array - np.amin(img_array))/(np.amax(img_array) - np.amin(img_array))

    # since only one dimension
    # put same in r, g, b for grayscale
    
    dims = img_array.shape

    gray_array = np.zeros( [dims[0], dims[1] ,3 ], dtype=float)

    for i in [0,1,2]:
        gray_array[ : , : ,i ] = img_array
    

    plt.ion()
    plt.imshow(gray_array,origin='upper')
    plt.show()

    showplot = input("press return to exit plot")

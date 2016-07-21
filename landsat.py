# set of functions to work with landsat data formatted for HIRES

import numpy as np
import matplotlib.pyplot as plt


def landsat_read(filename, skip_rows=5):
    """read in the provided landset text file
    """
    skip_rows += 1
    with open(filename, 'r') as f:
        for _ in range(skip_rows):
            line = f.readline()

    dims = np.fromstring(line, dtype=int, sep=" ")
    rows, cols, nvars = dims

    raw_array = np.loadtxt(filename, skiprows=skip_rows, dtype=float)
    data_array = raw_array.reshape(nvars, rows, cols).transpose([1, 2, 0])

    return data_array


def rgb_display(rgb_array):
    """displayes RGB image x contrast,
        railed off if too high or low
    """

    fig = plt.figure()
    ax = fig.add_subplot(1, 1, 1)
    contrast = 1

    while contrast:
        rgbc_array = contrast * rgb_array

        low = (rgbc_array < 0)
        rgbc_array[low] = 0

        high = (rgbc_array > 1)
        rgbc_array[high] = 1
        ax.imshow(rgbc_array, interpolation='bilinear', origin='upper')
        fig.canvas.draw()

        contrast = int(input("Enter Contrast, 0 to exit: "))

    return rgbc_array


def BT(I, wl, e):
    """calculates brightness temperature from the following:
    Intensity (radiance) in watts/m^2/mictron/steradian
    wavelength in microns
    emissivity
    written so it can take a complete array of I
    """
    A = 1.19e8   # watts microns^4/m^2
    B = 1.441e4  # micron-kelvins
    T = B / (wl * np.log(1 + (e * A / (I * wl**5))))
    return np.squeeze(T)


def grayscale_display(img_array):
    """ displays 2d image as grayscale
    """
    fig = plt.figure()
    ax = fig.add_subplot(1, 1, 1)
    ax.imshow(img_array, cmap="gray")
    return

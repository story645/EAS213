# set of functions to work with landsat data formatted for HIRES

import numpy as np
import scipy.stats as st
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


def rgb_contrast(rgb_array, contrast):
    """returns an RGB image adjusted based
    on contrast level
    """
    rgbc_array = rgb_array * contrast
    low = (rgbc_array < 0)
    rgbc_array[low] = 0

    high = (rgbc_array > 1)
    rgbc_array[high] = 1
    return rgbc_array


def rgb_display(rgb_array):
    """displays RGB image x contrast,
        railed off if too high or low
    """
    contrast = 1
    fig = plt.figure()
    ax = fig.add_subplot(1, 1, 1)
    contrast = 1

    while contrast:
        rgbc_array  = rgb_contrast(rgb_array, contrast)
        ax.imshow(rgbc_array, interpolation='bilinear', origin='upper')
        fig.canvas.draw()

        contrast = int(input("Enter Contrast, 0 to exit: "))

    return rgbc_array

def pdf(data, x=None):
    if x is None:
        x = np.linspace(0, 1, 100)
    kernal = st.gaussian_kde(data.flatten())
    y = kernal(x)
    return y


def RGB_hists(rgb_array, ax=None, label=None):
    x = np.linspace(0, 1, 100)
    colors = ['red', 'green', 'blue']

    if not ax:
        fig = plt.figure()
        ax = fig.add_subplot(1, 1, 1)

    for i, c in enumerate(colors):
        ax.plot(x, pdf(rgb_array[..., i], x), color=c, label=label)

    if label:
        ax.legend()

    return ax


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

def make_classification(rgb_array, rgbn, rv, gv, bv, nirv, tol):
    
    red = rgb_array[...,0]
    green = rgb_array[...,1]
    blue = rgb_array[...,2]
    nir = rgbn[...,3]

    rmask = (rv-tol < red) & (red< rv + tol)
    gmask = (gv-tol < green) & (green< gv + tol)
    bmask = (bv-tol < blue) & (blue < bv+tol)
    nmask = (nirv-tol < nir) & (nir  < nirv+tol)

    mask = np.empty(rgb_array.shape)*np.nan
    for i in range(mask.shape[2]):
        mask[...,i] = (rmask & gmask & bmask & nmask)

    return np.ma.MaskedArray(rgb_array,mask=mask)

def NDVI(nir, red):
    return (nir-red)/(nir+red)
function [T] = BT(I,wl,e)
% calculates brightness temperature from the following:
%  Intensity (radiance) in watts/m^2/mictron/steradian
%  wavelength in microns
%  emissivity
% written so it can take a complete array of I

A = 1.19e8 ;     % watts microns^4/m^2
B = 1.441e4;	 % micron-kelvins

T = B/(wl*log(1+(e*A./(I*wl^5))));

return
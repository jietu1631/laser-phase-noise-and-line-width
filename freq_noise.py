import numpy as np

freq_samp = 10**9 # sampling rate: 1 GHz, editable
lw = 5000 # linewidth, editable
number = 2**22 # FFT size, editable
linewidth_fmin = 2e6 # calculate linewidth lower freq, editable
linewidth_fmax = 30e6 # calculate linewidth upper freq, editable
tstep = 1/freq_samp # sampling period

# Wiener process delta follows WN Gaussian dist. This term is standard deviation. 
sigma = np.sqrt(2*np.pi*lw*tstep) 
phi_delta = np.random.normal(0,sigma,number) # phase delta between two sampling points
freq_inst = 1/(2*np.pi*tstep)*phi_delta # instantaneous freq

# Calculate PSD
# From Wiener–Khinchin_theorem, autocorrelation <> power spectral density Fourier pari
# Applied on wide-sense-stationary random process 
fspo_dsb = (tstep/number)*abs(np.fft.fft(freq_inst))**2
fspo_ssb = 2*fspo_dsb  # convert double side-band to single side-band

# calculate linewidth
freq = (1.0/(tstep*number))*np.arange(0,number)
flag = np.where((freq>=linewidth_fmin)&(freq<=linewidth_fmax))[0]

# caculate average value in the range [linewidth_fmin, linewidth_fmax]
fspo_ssb_mean = np.mean(fspo_ssb[flag])
linewidth = fspo_ssb_mean*np.pi/1000
print(f'Measured linewidth: {linewidth: .1f} kHz')
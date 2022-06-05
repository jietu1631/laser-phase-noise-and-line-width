## laser-phase-noise-and-line-width
simulate the relation between laser phase frequency noise and line width. But the simulation is wrong. the results are as follows: 
1、the result dose not conform to the fact that Sf(f)*pi=LW.
2、High frequency noise is high。

仿真激光相频噪声和线宽的关系，仿真结果不正确：频率功率谱密度和线宽不满足Sf(f)*pi=LW；并且频率功率谱密度噪声在高频处抖动很大。


## Please refer to the python version calculation

### Some differences I noticed:

- In [Line 29](https://github.com/jietu1631/laser-phase-noise-and-line-width/blob/19dd3e963be2056571b46f52f4a8fd7b31df709f/freq_noise_4_2.m#L29) you multiply the sampling rate but should rather divide the sampling rate. Same for [Line 20](https://github.com/jietu1631/laser-phase-noise-and-line-width/blob/19dd3e963be2056571b46f52f4a8fd7b31df709f/freq_noise_4_2.m#L20).

### About smoothing

I did not include smoothing in my code. It only makes sense physically when we have a certain length of fiber to de-correlate the laser. 

Example:
```python
fiber_length= 20e3 # 20 km fiber
group_index = 1.46
c = 2.998e8 # speed of light in m/s
Npts = int(1/(fiber_length*group_index/c)/(freq[2]-freq[1]))
```
In case of 20 km fiber used for de-correlation, number of points for moving average smoothing is around $N_{pts} = 1/(t_{fiber}*df) = 1/(L_{fiber}*n_g*df/c) \approx 43 $.

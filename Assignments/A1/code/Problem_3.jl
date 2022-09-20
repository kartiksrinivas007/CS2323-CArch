d = 18e-2
a_d = 11e-3 * 12e-3 
defect_rate = 0.04*1e4
cost = 200
a_w = π * (d^2)/4 
n_d = floor(a_w/(a_d))
yield = 1/((1 + ((defect_rate*a_d)/2)))^2
cost_per_die = cost/(n_d * yield)
using LinearAlgebra
cpi = [1, 3, 4]
function calc_time(IC, CPI, time)
    return IC * CPI * time
end
c1 = [0.7 , 0.1, 0.2]  ; c2 = [0.5 , 0.3, 0.2]
av_1 = dot(c1, cpi)
av_2 = dot(c2, cpi)
println("average cpi of first = ", av_1)
println("average cpi of second = ", av_2)
IC_2 = 1e7
factor = 1.2
IC_1 = IC_2 * factor
freq = 2e9
t1  = calc_time(IC_1, av_1, 1/freq)
println("Time taken by CPU_1 = ", t1)

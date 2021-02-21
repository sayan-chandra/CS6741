using Plots
using Random
Random.seed!(6)
mn=-10000
mx=10000

lst1=[]
lst2=[]
ad=0
for N in 1:100000
    push!(lst1,N)
    global ad+=rand(mn:mx)
    push!(lst2,ad/N)
end
myfig=plot(lst1,lst2,label=false, title="Demonstrating \nLAW OF LARGE NUMBERS", line=2, color=:black, xlabel="Number of samples taken",ylabel="Mean of samples")
display(myfig)
#savefig(myfig, "A1P1.png")
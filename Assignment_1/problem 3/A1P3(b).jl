using Random
using Plots
Random.seed!(7)
function experiment2()
    cards=[]
    for i in 1:52
        push!(cards,i)
    end
    howmany=0
    for _ in 1:5
        pick=rand(cards)
        if pick<5
            howmany+=1
        end
        ## filter!(x->x!=pick, cards)
    end
    return howmany
end

ans0,ans1,ans2,ans3,ans4,ans5=0,0,0,0,0,0
for _ in 1:10000
    local ans=experiment2()
    if ans==0
        global ans0+=1
    end
    if ans==1
        global ans1+=1
    end
    if ans==2
        global ans2+=1
    end
    if ans==3
        global ans3+=1
    end
    if ans==4
        global ans4+=1
    end
    if ans==5
        global ans5+=1
    end
end

lst=[ans0, ans1, ans2, ans3, ans4, ans5]
lstpr=[0.0,0.0,0.0,0.0,0.0,0.0]
for i in 1:6
    lstpr[i]=lst[i]/10000
end
println(lstpr)
plot(0:5, lstpr, label="graph_experimental", line=6, color=:red)



nChoosek(n,k)=binomial(n,k)
withRplce=[]
for i in  0:5
   push!(withRplce,(i, nChoosek(5,i)*(4/52)^i*(48/52)^(5-i)))
end
println([i[2] for i in withRplce])
ppp=plot!(0:5, [i[2] for i in withRplce],title="Q-3(with Replacement)",label="graph_analytical", line=2, color=:black, ylabel="probability calculated", xlabel="number of jacks in 5 draws")
display(ppp)
#savefig(ppp,"A1P3(b).png")
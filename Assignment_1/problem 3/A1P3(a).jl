using Random
using Plots
using ColorSchemes
Random.seed!(5)
function experiment1()
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
        filter!(x->x!=pick, cards)
    end
    return howmany
end

ans0,ans1,ans2,ans3,ans4=0,0,0,0,0
for _ in 1:10000
    local ans=experiment1()
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
end

lst=[ans0, ans1, ans2, ans3, ans4]
lstpr=[0.0,0.0,0.0,0.0,0.0]
for i in 1:5
    lstpr[i]=lst[i]/10000
end
println(lstpr)
plot(0:4, lstpr, label="graph_experimental", line=6, color=:red)



nChoosek(n,k)=binomial(n,k)
withoutRplce=[]
for i in  0:4
    push!(withoutRplce,(i, (nChoosek(4,i)*nChoosek(48,5-i))/nChoosek(52,5)))
end
println([i[2] for i in withoutRplce])
pppp=plot!(0:4, [i[2] for i in withoutRplce], title="Q-3(without Replacement)",label="graph_analytical", line=2, color=:black, ylabel="probability calculated", xlabel="number of jacks in 5 draws")
display(pppp)
#savefig(pppp, "A1P3(a).png")
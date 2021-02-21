using Random
using Plots
Random.seed!(30)
function withReplacement()
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
for _ in 1:1000000
    local ans=withReplacement()
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
    lstpr[i]=lst[i]/1000000
end
print("Probability of getting 0, 1, 2, 3, 4, 5 jacks respectively when draws are done with replacement ",lstpr)
plot2=bar(0:5, lstpr, title="With Replacement",label=false, line=1, xlabel="Number of jacks in 5 draws", ylabel="Corresponding probability")
display(plot2)
#savefig(plot2, "A1P2(b).png")
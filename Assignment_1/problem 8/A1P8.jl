using Random
using Plots
Random.seed!(1)
function Perform_Game(pr) #pr= probability of winning
    lst=1:10
    set_money=10
    bankrupt=0
    _greaterEq10=0
    check=0
    for i in 1:20
        play=rand(lst)
        if pr>=play
            set_money+=1
        else 
            set_money-=1
            if set_money==0 && check==0 
                check=1
            end
        end
    end
    if check==1
        bankrupt+=1
    elseif set_money>=10
        _greaterEq10+=1
    end
    return (bankrupt, _greaterEq10)
end

lstt1, lstt2, NN=[], [], 1000000
for pr in 1:10
    ## probability of winning = pr*0.1
    ## lstt1=probability of losing
    push!(lstt1, (10-pr)/10)
    bankrupt=0
    _greaterEq10=0
    for _ in 1:NN
        xx, yy = Perform_Game(pr)
        bankrupt+=xx
        _greaterEq10+=yy
    end
    push!(lstt2, _greaterEq10/(NN-bankrupt))
    println("\nIf probability of losing Re 1 is "*string((10-pr)/10)*"\nthen the is the probability that you end up with Rs. 10 or more at the end of 20 days, given that I knew that I do not go bankrupt even once,  is ",_greaterEq10/(NN-bankrupt))
end
reverse!(lstt2)
reverse!(lstt1)
println(lstt2)
pplt=plot(lstt1,lstt2, line=2, color=:blue, title="Q-8", label=false, xlabel="probability of losing = p", ylabel="Conditional probability")
display(pplt)
#savefig(pplt, "A1P8.png")
using Random, Plots
Random.seed!(3)
function Perform_Game(pr) ## pr=probability of losing
    lst=1:10
    set_money=10
    for i in 1:20
        play=rand(lst)
        if play>pr
            set_money+=1
        else set_money-=1
        end
    end
    return set_money>=10
end

lst=[]
for pr in 10:-1:0
    ## probability of losing Re 1 = pr*0.1
    howmany=sum(Perform_Game(pr) for _ in 1:300000)
    push!(lst, howmany/300000)
    println("\nIf probability of losing Re 1 is "*string(pr/10)*"\nthen probability of having at least 10 rupees at the end of 20th day is ", howmany/300000)
end
print(reverse(lst))
sktch=plot(0:0.1:1, reverse(lst), line=2, color=:blue, title="Q-6", label=false, xlabel="probability of losing = p", ylabel="probability of having at\nleast 10 rupees at last")
display(sktch)
#savefig(sktch, "A1P6.png")
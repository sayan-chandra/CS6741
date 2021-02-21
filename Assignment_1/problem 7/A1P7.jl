using Random, Plots
Random.seed!(3)
function Perform_Game(pr)
    lst=1:10
    set_money=10
    for i in 1:20
        play=rand(lst)
        if pr<play
            set_money+=1
        else 
            set_money-=1
            if (set_money==0)
                return 1
            end
        end
    end
    return 0
end

lst=[]
for pr in 10:-1:0
    ## probability of loosing Re 1 = pr*0.1
    howmany=sum(Perform_Game(pr) for _ in 1:900000)
    push!(lst, howmany/900000)
    println("\nIf probability of loosing Re 1 is "*string(pr/10)*"\nthen probability of going bankrupt\nat least once ", howmany/900000)
end
print(reverse(lst))
draw= plot(0:0.1:1, reverse(lst), line=2, color=:blue, title="Q-7", label=false, xlabel="probability of loosing = p", ylabel="probability of going bankrupt\nat least once")
display(draw)
#savefig(draw, "A1P7.png")
using Random, Plots
Random.seed!(2)
setOfChar=join('a':'z')*join('A':'Z')*raw"~!@#$%^&*()_+=-`"
for i in 0:9
   global setOfChar*=string(i)
end
orgPass=""
for i in 1:8
    global orgPass*=rand(setOfChar)
end
two, NN=0, 3000000
for ii in 1:NN
    guess=""
    ###############
    for i in 1:8
        guess*=rand(setOfChar)
    end
    ###############
    matched=0
    for i in 1:8
        if guess[i]==orgPass[i] 
            matched+=1
        end
    end
    if matched>=2
        global two+=1
    end
end
println("Experimental result ",two/NN)
print("Analytical result ", 1-(8/78)*(77/78)^7-(77/78)^8)
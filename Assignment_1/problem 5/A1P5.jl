using Random, Plots
Random.seed!(40)
setOfChar=join('a':'z')*join('A':'Z')*raw"~!@#$%^&*()_+=-`"*join([string(i) for i in 0:9])
orgPass=rand(setOfChar, 8)
for c in 2:5
    count=0
    for ii in 1:1000000 ## one million=10 lakh
        guess=rand(setOfChar, 8)
        matched=sum([guess[i]==orgPass[i] for i in 1:8])
        count+=(matched>=c)
    end
    if count<=1000
        println("Now with matching of at least "*string(c)*" letters we will store the password")
        println("And now the probability of password getting stored is  ", count/1000000, "\nAnd when a million random password attempts are made by the hacker then number of passwords at at average will be saved is 124(<1000).")

        break
    end
end
 

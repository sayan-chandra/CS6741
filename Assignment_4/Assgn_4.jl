### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ 33a9ce20-b00a-11eb-16b4-df2680663a86
begin
    using Random
	Random.seed!(84)
end

# ╔═╡ ffa66d20-af7a-11eb-2329-1bb02c5a2a07
begin
	using Plots
	using StatsBase
	using StatsPlots
	using Distributions
	using PlutoUI
	using DataFrames
	using QuadGK
	
end

# ╔═╡ 729afc10-af7b-11eb-1de2-c93935619677
md"# Question-1
**=solution==>**"

# ╔═╡ a72db1c0-af7b-11eb-24cb-1f03503eebab
begin
	Random.seed!(84)
    function Toss50Times()
        return sum([rand([0,1]) for _ in 1:50])
    end
    
    function  monteCarloToss(trials)
        count=0
        for i in 1:trials
            heads=Toss50Times()
            if heads >=30 
                count+=1
            end
        end
        return count
    end
    
    trials=300000
    ANSWER="Using Empirical method => "*string(monteCarloToss(trials)/trials)
end    
    
   

# ╔═╡ adf25730-aff9-11eb-3d60-57768e6d4035
 
begin  

    nChoosek(n,k)=binomial(n,k)
    function binomialToss()
        return sum([nChoosek(50, y)*(0.5)^50 for y in 30:50])
    end
    answer="Using Analytical method => "*string(binomialToss())
end   
    


# ╔═╡ b7a2a820-aff9-11eb-3489-31f0b2d4c9d2
begin  
    function CLTtoss()
		global μ, σ=0,0
        DU=DiscreteUniform(0,1)
        μ, σ = mean(DU), std(DU)
        return 1-cdf(Normal(μ*50, σ*sqrt(50)), 29.5)    
    end
    ans= "Using CLT => "*string(CLTtoss())

end

# ╔═╡ b4ba0fb0-b010-11eb-3123-41ee60fa9503
begin
	μ, σ
end

# ╔═╡ 567f1200-b007-11eb-3820-dd19eb370077
begin
	plot(f->f, f->pdf(Normal(μ*50, σ*sqrt(50)),f), 0, 50, label="Normal(μ, σ)", xlabel="No. Of Heads in 50 tosses", ylabel="PDF", title="PDF approximation using CLT")
	plot!(x->pdf(Normal(μ*50, σ*sqrt(50)), x), 29.5, 50, fill=(0, :red), fillalpha=2, label="area_normal")
end

# ╔═╡ ebb3b280-af7c-11eb-1f9a-3901c6b6d4bb
md"# Question-2
**=solution==>**"

# ╔═╡ f26409e0-af7c-11eb-2dc9-d319cd78f1aa
begin
	Random.seed!(84)
    function CLTtoss2(pr)
		global Norm
        DU=DiscreteUniform(0,1)
        μ = pr/100; σ = 0.5*sum([(i-μ)^2 for i in [0,1]])
		Norm=Normal(μ*50, σ*sqrt(50))
        return 1-cdf(Norm, 29.5)    
    end
	prob, ans2=0.0, ""
    for i in 50:0.01:100
        if CLTtoss2(i)>=0.5 
            global prob=i/100
            global ans2 = "If chance of going ahead is "*string(CLTtoss2(i))*" then probabiliity_of_head is "*string(prob)*" using CLT"
            break;
        end
    end
	ans2
end

# ╔═╡ 5e77f2ae-b07a-11eb-354d-217456033d18
begin
	plot(f->f, f->pdf(Norm,f), 0, 50, label="Normal(μ, σ)", xlabel="No. Of Heads in 50 tosses", ylabel="PDF", title="PDF approximation using CLT")
	plot!(x->pdf(Norm, x), 29.5, 50, fill=(0, :red), fillalpha=2, label="area_normal")
end

# ╔═╡ f6f77a30-b078-11eb-1646-6f5328efeeed
 
   
begin  
	Random.seed!(84)
    function Toss50Times2()
        return count(x->(x<=59), [rand([i for i in 1:100]) for _ in 1:50])
    end
    
    function  monteCarloToss2(trials)
        count=0
        for i in 1:trials2
            heads=Toss50Times2()
            if heads >=30
                count+=1
            end
        end
        return count
    end
    
    trials2=500000
    anss = "Using probabiliity_of_head "*string(prob)*" probability_of_going_ahead by experiments is "*string(monteCarloToss2(trials2)/trials2)
end


# ╔═╡ 7e7c5160-b079-11eb-0d0d-9117aae3176c

begin   
	Random.seed!(84)
    nChoosek2(n,k)=binomial(n,k)
    function binomialToss2()
        return sum([nChoosek2(50, y)*(0.59)^y*(1-0.59)^(50-y) for y in 30:50])
    end
    ansss= "Using probabiliity_of_head "*string(prob)*" probability_of_going_ahead by experiments is "*string(binomialToss2())

end

# ╔═╡ 38fffce0-af7f-11eb-1b2c-67451d8f5ae2
md"# Question-3
**=solution==>**"

# ╔═╡ 3f14fea0-af7f-11eb-032f-b7440b842a23
begin
	glob3=[]; I=0
    N_N(N)=Normal(100*N, 30*sqrt(N))
    global i=20
    while(true)
        push!(glob3, "Probability of lasting 3000 days is "*string(1-cdf(N_N(i), 3000))*" if number of space-suits taken is "*string(i))
        if 1-cdf(N_N(i), 3000) >= 0.95
			global I=i
            break
        end
        global i+=1
    end
	with_terminal() do 
      for i in glob3
          println(i)
      end
    end
end

# ╔═╡ 94ab34d0-b081-11eb-07b9-03e5efc8d93a
sqrt(I)

# ╔═╡ 49e9a210-b081-11eb-0e92-3795b219b1d5
begin
	plot(f->f, f->pdf(N_N(I),f), 3300-700, 3300+700, label="Normal(3300, 5.744)", xlabel="No. of days 33 spacesuits will last", ylabel="PDF", title="PDF approximation using CLT")
	plot!(x->pdf(N_N(I), x), 3000, 4000, fill=(0, :red), fillalpha=2, label="area_normal")
end

# ╔═╡ edf2c5b0-af7f-11eb-2393-7d53cd2ca6c6
md"# Question-4
**=solution==>**"

# ╔═╡ f371f010-af7f-11eb-3588-939988b73d87
begin
	glob4=[]
	plot4=[]
	Random.seed!(179)
    dists=[Uniform(0,1), Binomial(300, 0.01), Binomial(300, 0.5), Chisq(3)]
    for dist in dists
        local k=1; flag=true
        while flag
            list=[]
            for trial in 1:50000
                k_samples=(rand(dist, k).-mean(dist))./std(dist)
                push!(list, sum(k_samples)./sqrt(k))
            end
            list=convert(Array{Float64,1}, list)
            mu, var, skew, kurt = mean(list), std(list)^2, skewness(list), kurtosis(list)
            # we know for Normal(0,1) mean=0, var=1, skewness=0, kurtosis=0 
            if abs(skew)<0.1 && abs(kurt)<0.1
				push!(plot4, list)
                push!(glob4, "Distribution is "*string(dist)* ",  Number of samples taken "*string(k)* "\nmean= "*string(mu)* ",  variance= "*string( var)* ",  skewness= "*string( skew)* ",  kurtosis= "*string( kurt)*"\n")
                flag=false
            end
            k+=1
            if k==400
                break
            end
        end
    end
	with_terminal() do 
      for i in glob4
          println(i)
      end
    end
end



# ╔═╡ 09e919f0-aff2-11eb-1877-496093b6f9d2
begin
	density(plot4[1], line=3, color=:red, label=string(dists[1])[15:length(string(dists[1]))], title="Approximation using CLT", xlabel="x -->", ylabel="uniform pdf", legend=:topleft)
	plot!(x->x, x->pdf(Normal(0,1),x),-3, 4, line=2, color=:green,label="Normal(0,1)")
end

# ╔═╡ 872557d0-aff2-11eb-10ba-0d5fcc73733f
begin
	density(plot4[2], line=3, color=:red, label=string(dists[2])[15:length(string(dists[2]))], title="Approximation using CLT", xlabel="x -->", ylabel="binomial pdf")
	plot!(x->x, x->pdf(Normal(0,1),x),-6, 7, line=2, color=:green,label="Normal(0,1)")
end

# ╔═╡ f62a3600-aff2-11eb-37c8-a11d4e2609a4
begin
	density(plot4[3], line=3, color=:red, label=string(dists[3])[15:length(string(dists[3]))], title="Approximation using CLT", xlabel="x -->", ylabel="binomial pdf")
	plot!(x->x, x->pdf(Normal(0,1),x),-4, 5, line=2, color=:green, label="Normal(0,1)")
end

# ╔═╡ fb68ade2-aff2-11eb-1197-997c24017021
begin
	density(plot4[4], line=3, color=:red, label=string(dists[4])[15:1+length(string(dists[4]))], title="Approximation using CLT", xlabel="x -->", ylabel="chi-square pdf")
	plot!(x->x, x->pdf(Normal(0,1),x),-4, 5, line=2, color=:green, label="Normal(0,1)")
end

# ╔═╡ 26ff2730-af81-11eb-2e0e-93dbb89f1a49
md"# Question-5
**=solution==>**"

# ╔═╡ 0891a710-af80-11eb-395d-3b2569ee0a66
begin
	glob5=[]; pr=0.0
    min, max, val =1.1, 10.1, 0
	biasedVar=5
	unbiasedVar=biasedVar*100/99
    while true
        var=(min+max)/2

        pr=1-cdf(Chisq(99), 99*unbiasedVar/var)
        if 0.1-pr<0.0000000001 && 0.1-pr>0 
			val=99*unbiasedVar/var
            push!(glob5, "if population variance is "*string(var)* " then Pr(variance_of_tea-box > 5) is "*string( pr))
            break

        elseif pr<0.1
            min=var

        elseif pr>0.1
            max=var
        end
    end
	with_terminal() do
	  println("If X~Chisq(99), then Pr(X>"*string(val)*") = "*string(pr)*" i.e. < 0.1\n")
	  println("Here "*string(var)*" = "*string(unbiasedVar)*"*99/"*string(val))
      for i in glob5
          println("\nSo "*i)
      end
    end
end

# ╔═╡ 206fdcf0-b0a0-11eb-354d-d53b1f7e7a5c
val

# ╔═╡ 5bd7f3a0-b09f-11eb-1b28-35ece45ab20f
begin
	plot(f->f, f->pdf(Chisq(99), f), 0, 190, label="Chisq(99)", xlabel="x-->", ylabel="PDF", title="PDF approximation using chi-square")
	plot!(x->pdf(Chisq(99), x), val, 150, fill=(0, :red), fillalpha=2, label="area_chi-square")
end

# ╔═╡ Cell order:
# ╠═33a9ce20-b00a-11eb-16b4-df2680663a86
# ╠═ffa66d20-af7a-11eb-2329-1bb02c5a2a07
# ╟─729afc10-af7b-11eb-1de2-c93935619677
# ╠═a72db1c0-af7b-11eb-24cb-1f03503eebab
# ╠═adf25730-aff9-11eb-3d60-57768e6d4035
# ╠═b7a2a820-aff9-11eb-3489-31f0b2d4c9d2
# ╠═b4ba0fb0-b010-11eb-3123-41ee60fa9503
# ╠═567f1200-b007-11eb-3820-dd19eb370077
# ╟─ebb3b280-af7c-11eb-1f9a-3901c6b6d4bb
# ╠═f26409e0-af7c-11eb-2dc9-d319cd78f1aa
# ╠═5e77f2ae-b07a-11eb-354d-217456033d18
# ╠═f6f77a30-b078-11eb-1646-6f5328efeeed
# ╠═7e7c5160-b079-11eb-0d0d-9117aae3176c
# ╟─38fffce0-af7f-11eb-1b2c-67451d8f5ae2
# ╠═3f14fea0-af7f-11eb-032f-b7440b842a23
# ╠═94ab34d0-b081-11eb-07b9-03e5efc8d93a
# ╠═49e9a210-b081-11eb-0e92-3795b219b1d5
# ╟─edf2c5b0-af7f-11eb-2393-7d53cd2ca6c6
# ╠═f371f010-af7f-11eb-3588-939988b73d87
# ╠═09e919f0-aff2-11eb-1877-496093b6f9d2
# ╠═872557d0-aff2-11eb-10ba-0d5fcc73733f
# ╠═f62a3600-aff2-11eb-37c8-a11d4e2609a4
# ╠═fb68ade2-aff2-11eb-1197-997c24017021
# ╟─26ff2730-af81-11eb-2e0e-93dbb89f1a49
# ╠═0891a710-af80-11eb-395d-3b2569ee0a66
# ╠═206fdcf0-b0a0-11eb-354d-d53b1f7e7a5c
# ╠═5bd7f3a0-b09f-11eb-1b28-35ece45ab20f

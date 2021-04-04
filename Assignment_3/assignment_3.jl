### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ 75e133c0-91ea-11eb-010b-f3064c8b91c1
begin 
	using QuadGK
	using Plots
	using StatsBase
	using StatsPlots
	using Distributions
	using PlutoUI
	using FreqTables
	using RDatasets
	using DataFrames
	using CSV, Query, Dates
	using Random
end

# ╔═╡ ca2a3500-92e2-11eb-2c7c-fb71ca81a19f
md"# Question-1
**=solution==>**"

# ╔═╡ e42bca80-931a-11eb-3f1b-5f15ab9c5e9a
function KLDivergence(d1, d2)
	return quadgk(x->pdf(d1,x)*log2(pdf(d1,x)/pdf(d2,x)),(-37:37)...)[1]
end

# ╔═╡ d6652870-92e2-11eb-0e3b-25cdca7f0576
begin
	pyplot()
	ans1=DataFrame(
	    degFreedom=1:5,
		KLDiv=[KLDivergence(TDist(i), Normal(0, 1)) for i in 1:5]
		)
end

# ╔═╡ 2d96abe0-92e4-11eb-32a9-27aaadcd6e13
md"# Question-2
**=solution==>**"

# ╔═╡ 01fc4f80-92e9-11eb-093a-077c607d4e25
md"# Question-3
**=solution==>**"

# ╔═╡ 07f787b0-92e9-11eb-040d-0fb846ab85f3
begin
	pyplot()
	ans=vcat( [0 for i in 1:950],[1 for i in 1:1150],[2 for i in 1:1300], [3 for i in 1:1350], 
	    [4 for i in 1:1450], [5 for i in 1:1490],[6 for i in 1:600],[6.5 for i in 1:400], [7 for i in 1:250], [8 for i in 1:250],
	    [9 for i in 1:150], [10 for i in 1:150], [11 for i in 1:120], [12 for i in 1:90], [13 for i in 1:50], [14 for i in 1:30], [15 for i in 1:15])
	aa=histogram(ans, color=:green, label="synthetic data histogram")
	m1, m2, m3, v=mean(ans), median(ans), mode(ans), var(ans)
	s=v^0.5
	plot!(xlabel="values", ylabel="frequency")
	plot!([m1 for _ in 1:1490],1:1490, line = (4), label = "Mean", color=:red)
	plot!([m2 for _ in 1:1490],1:1490, line = (4), label = "Median", color=:black)
	plot!([m3 for _ in 1:1490],1:1490, line = (4), label = "Mode", color=:cyan)
	sqeww=sum((xi-m1)^3 for xi in ans)/(length(ans)*(s^3))
    ("mean=>",m1," median=>", m2," mode=>", m3, " sqewness=>", sqeww)
end

# ╔═╡ 30f4d8c0-92e9-11eb-133a-47ada886a08b
aa

# ╔═╡ bf078b30-92e9-11eb-3e9e-9b9991ae9d7c
md"# Question-4
**=solution==>**"

# ╔═╡ c59629c2-92e9-11eb-1d2a-8df50a43c842
begin
	_10000x30 = rand(Uniform(0,1), 10000, 30)
	
	_10000_ranges = [maximum(_10000x30[k, 1:30])-minimum(_10000x30[k, 1:30]) for k in 1:10000]
	sorted=sort(_10000_ranges)	
	
	start, ii, count, numberOfBins, val= 0,1,0, 100, []
	while start<1 && ii<=10000
	    if sorted[ii]<=start+(1/numberOfBins)
	        count+=1
			push!(val, (start+start+1/numberOfBins)/2)
	    else
	        start+=(1/numberOfBins)
	        count=0
	    end
	    ii+=1
	end
	
	ques4=[histogram(val, nbins=100, xlabel = "range(max-min)", ylabel = "frequency of range", title = "Histogram-plot")]
	push!(ques4, plot!([mean(val)], seriestype="vline", label="mean(μ)", line=2.5, color=:red))
	push!(ques4, plot!([median(val)], seriestype="vline", label="median(η)", line=2.5, color=:green))
	push!(ques4, plot!([mode(val)], seriestype="vline", label="mode(Mo)", line=2.5, color=:pink))
	ques4[1]
end

# ╔═╡ d9145702-92ef-11eb-2a6c-c763f6a55d83
md"# Question-5
**=solution==>**"

# ╔═╡ defca36e-92ef-11eb-02ca-655cac483e6d
"PICTURE OF HANDWRITTEN ANSWER GIVEN IN GOOGLE DOCUMENT THAT IS TURNED IN."

# ╔═╡ 9fa22bc0-8a0f-11eb-1bf4-c173c62681f9
md"# Question-6
**=solution==>**"

# ╔═╡ f3011060-9234-11eb-24d9-05f1d1039835
begin
	d1= CSV.read("D:\\Opera_downloads\\states.csv", DataFrame)
	d1 = d1 |> @filter(_.State != "India") |> DataFrame
	select!(d1, [:Date, :State, :Confirmed])
	for col in eachcol(d1)
       replace!(col,missing => 0)
    end
	grpByState=groupby(d1, :State)
	nGrps=length(grpByState)
	for i in 1:nGrps
		ConfirmedPerDay=[grpByState[i][1,:].Confirmed]
		nRows=size(grpByState[i])[1]
		for j in reverse(2:nRows)
			grpByState[i][j,:].Confirmed = grpByState[i][j,:].Confirmed - grpByState[i][j-1,:].Confirmed
		end
		
	end
end

# ╔═╡ a54bf440-9241-11eb-0340-e9594f28ed66
function weekening(gg)
	week=grpByState[1][1,:].Date+Dates.Day(6)
	newdf=DataFrame(week = String[], State = String[], Confirmed=Int[])
	count=0
	run=1
	i=1
	statename=gg[1,:].State
	sz=size(gg)[1]
	while(i<=sz)
		if gg[i,:].Date <= week
			count+=gg[i,:].Confirmed
		else
			push!(newdf, ("week-"*string(run), statename, count))
			count=0
			run+=1
			week+=Dates.Day(7)
		end
		i+=1
	end
	return newdf
end

# ╔═╡ fb965cf2-924b-11eb-3527-5fd62f80c9fb
begin
	keepall=[]
	for i in 1:nGrps
		push!(keepall, unstack(weekening(grpByState[i]), :State, :Confirmed))
	end
	splice!(keepall, 36)
	finaldf=DataFrame(
		week=keepall[1].week
	)
	for i in 1:length(keepall)
	    insertcols!(finaldf, 1+i, names(keepall[i])[2]=>keepall[i][:,names(keepall[i])[2]])
	end
	finaldf
end

# ╔═╡ 6987fcc0-9254-11eb-3f24-bb8989e662fa
begin
	states=names(finaldf)[2:length(keepall)+1]
	r=c=length(states)
	covv = rand(r,c)
	corr = rand(r,c)
	spearman = rand(r,c)
	findpos(arr) = [indexin(arr[i], sort(arr))[1] for i in 1:length(arr)]
	for i in 1:r
		for j in 1:c
			a=[jj for jj in finaldf[:,states[i]]]
			b=[jj for jj in finaldf[:,states[j]]]
			covv[i,j]=cov(vec(a), vec(b))
			corr[i,j]=cor(vec(a), vec(b))
			spearman[i,j]=cor(vec(findpos(a)), vec(findpos(b)))
		end
	end
end

# ╔═╡ 9ec892c0-9261-11eb-24c0-730c3a9257a4
begin
	gr()
	heatmap(states,
	    states, covv,
	    c=cgrad([:cyan, :yellow, :green, :red]),
	    title="heatmap_covariance")
end

# ╔═╡ 55705e8e-9262-11eb-21a0-1b5428e6a8c4
begin
	gr()
	heatmap(states,
	    states, corr,
	    c=cgrad([:cyan, :yellow, :green, :red]),
	    title="heatmap_pearson's coeff. of correlation")
end

# ╔═╡ 5884fc20-9263-11eb-1e43-0fc5f21205b1
begin
	gr()
	heatmap(states,
	    states, spearman,
	    c=cgrad([:cyan, :yellow, :green, :red]),
	    title="heatmap_spearman")
end

# ╔═╡ 3a020ae0-92f4-11eb-1ef9-b3ed9720da28
md"# Question-7
**=solution==>**"

# ╔═╡ 3ec7d050-92f4-11eb-3c44-93411e96f4df
begin
	percentileOf(num, dist)=quadgk(x->pdf(dist,x), (-Inf, num)...)[1]
	interval=[i for i in -100:0.01:100]
	
	function OneSidedTail(ptile, d)
	    ptile=100-ptile
	    error=0.0001
	    for i in interval
	        if(percentileOf(i, d)>=ptile/100)
	            return i
	        end
	    end
	    return
	end
	
	x=95
	valnorm=OneSidedTail(x, Normal(0,1))
	print(valnorm, " ", percentileOf(valnorm, Normal(0,1))*100)
	valtdist=OneSidedTail(x, TDist(10))
	print("\n",valtdist, " ", percentileOf(valtdist, TDist(10))*100)
	range=1:99
	arrnorm=[]
	arrtdist=[]
	for x in range
	    aaa = OneSidedTail(x, Normal(0,1))
	    bbb = OneSidedTail(x, TDist(10))
	    push!(arrnorm, aaa)
	    push!(arrtdist, bbb)
	end
end

# ╔═╡ 3747c01e-92e4-11eb-2d30-096ca5f402db
begin
	plotss=[]
	plt=[]
	gr()
	function Question2(N)
		empty!(plotss)
		empty!(plt)
		function KLDiv(array, mu, sigma)
			normalDiscrete=[pdf(Normal(mu, sigma),x) for x in range]
			summ=0
			for i in 1:length(range)
			   if array[i]>0
				 summ+=array[i]*log2(array[i]/ normalDiscrete[i])
			   end
			end
			return summ/num
		end
		
		function fitData(distArr, kp)
			μ=sum([i*kp[i] for i in range])/(num-1)
			σ=sqrt(sum([i^2*kp[i] for i in range])/(num-1) - μ^2)
			push!(KLD, KLDiv(distArr, μ, σ))
			push!(plotss, plot!(x->x, x->pdf(Normal(μ, σ), x), range, label=false))
		end
		
		uf=Uniform(0,1)
		step=0.005
		num=1/step + 1
		range=-5:step:10
		keep=Dict()
		KLD=[]
		
		
		initt=[pdf(uf,k) for k in range]
		initdict=Dict([(k, pdf(uf,k)) for k in range])
		push!(plotss, plot(range, initt, label=false))
		fitData(initt,initdict)
		
		idx=1:length(range)
		conv(x) = sum([pdf(uf,x-k)*pdf(uf,k) for k in range])
		arr=conv.(range)/num
		for go in idx
		    keep[range[go]]=arr[go]
		end
		push!(plotss, plot!(range, arr, label=false))
		fitData(arr,keep)
		
		
		
		arr1=[]
		keep1=keep
		conv1(x) = sum([keep1[k]*pdf(uf,x-k) for k in range])
		for j in 2:N
		  arr1=conv1.(range)/num
		  for go in idx
		    keep1[range[go]]=arr1[go]
		  end	
		  push!(plotss, plot!(range, arr1, label=false))
		  fitData(arr1,keep1)
		end
		
		push!(plt, plot(2:N, KLD[2:N], title="kl-divergence plot",label=false, line=2, color=:black, ylabel="KL-divergence values", xlabel="number of disbritutions convoluted"))
		print(KLD)
	end
end

# ╔═╡ d82ee490-92e5-11eb-20e6-a3a4300ccb2c
Question2(10)

# ╔═╡ 1c65f770-92e6-11eb-084d-5f3c033644dd
plotss[1]

# ╔═╡ 2e0f7370-92e6-11eb-39bb-4d4b8aa82fef
plt[1]

# ╔═╡ ccbaecd0-92f4-11eb-238f-b97a17cf7496
begin
	    plotly()
	    plot(xlabel="percentile values:                                       p --->", ylabel="OneSidedTail (p)                                     ---->")
		plot!(range, arrnorm, label="OneSidedTail for Normal", color=:red)
		plot!([95 for i in -2.5:0.01:-1], -2.5:0.01:-1, line=3, label="vertical line showing values", color=:green)
end

# ╔═╡ 30fe7e70-9325-11eb-2f85-692b6c2bff90
begin
	    plotly()
	    plot(xlabel="percentile values:                                       p --->", ylabel="OneSidedTail (p)                                     ---->")
		plot!(range, arrtdist, label="OneSidedTail for TDist", color=:blue)
		plot!([95 for i in -2.5:0.01:-1], -2.5:0.01:-1, line=3, label="vertical line showing values", color=:green)
end

# ╔═╡ 51194090-92fe-11eb-1232-f79a45219246
begin
	plot(x->pdf(Normal(0,1), x), -5, 5, line=2.4, label="normal(0,1)", xlabel="x range", ylabel="pdf values")
	plot!(x->pdf(Normal(0,1), x), -5, valnorm, fill=(0, :red), fillalpha=2, label="area_normal")
	plot!(x->pdf(TDist(10), x), -5, 5, line=2.4, label="TDist(10)")
	plot!(x->pdf(TDist(10), x), -5, valtdist, fill=(0, :green), fillalpha=0.6, label="area_TDist")
end

# ╔═╡ Cell order:
# ╠═75e133c0-91ea-11eb-010b-f3064c8b91c1
# ╟─ca2a3500-92e2-11eb-2c7c-fb71ca81a19f
# ╠═e42bca80-931a-11eb-3f1b-5f15ab9c5e9a
# ╠═d6652870-92e2-11eb-0e3b-25cdca7f0576
# ╟─2d96abe0-92e4-11eb-32a9-27aaadcd6e13
# ╠═3747c01e-92e4-11eb-2d30-096ca5f402db
# ╠═d82ee490-92e5-11eb-20e6-a3a4300ccb2c
# ╠═1c65f770-92e6-11eb-084d-5f3c033644dd
# ╠═2e0f7370-92e6-11eb-39bb-4d4b8aa82fef
# ╟─01fc4f80-92e9-11eb-093a-077c607d4e25
# ╠═07f787b0-92e9-11eb-040d-0fb846ab85f3
# ╠═30f4d8c0-92e9-11eb-133a-47ada886a08b
# ╟─bf078b30-92e9-11eb-3e9e-9b9991ae9d7c
# ╠═c59629c2-92e9-11eb-1d2a-8df50a43c842
# ╟─d9145702-92ef-11eb-2a6c-c763f6a55d83
# ╠═defca36e-92ef-11eb-02ca-655cac483e6d
# ╟─9fa22bc0-8a0f-11eb-1bf4-c173c62681f9
# ╠═f3011060-9234-11eb-24d9-05f1d1039835
# ╠═a54bf440-9241-11eb-0340-e9594f28ed66
# ╠═fb965cf2-924b-11eb-3527-5fd62f80c9fb
# ╠═6987fcc0-9254-11eb-3f24-bb8989e662fa
# ╠═9ec892c0-9261-11eb-24c0-730c3a9257a4
# ╠═55705e8e-9262-11eb-21a0-1b5428e6a8c4
# ╠═5884fc20-9263-11eb-1e43-0fc5f21205b1
# ╟─3a020ae0-92f4-11eb-1ef9-b3ed9720da28
# ╠═3ec7d050-92f4-11eb-3c44-93411e96f4df
# ╠═ccbaecd0-92f4-11eb-238f-b97a17cf7496
# ╠═30fe7e70-9325-11eb-2f85-692b6c2bff90
# ╠═51194090-92fe-11eb-1232-f79a45219246

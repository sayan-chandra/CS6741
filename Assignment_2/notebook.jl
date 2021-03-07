### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ b9ad64ee-7bf3-11eb-235b-e73aac0c1a36
begin
	using DataFrames
	DF=DataFrames
end

# ╔═╡ a163f950-7cc4-11eb-24a4-a754d275690e
begin
	using HTTP
	using JSON
	using Statistics, Plots
	plotly()
end

# ╔═╡ 2cbc5de0-7bed-11eb-2ef3-23a145ed8b9c
md"# Assignment 2: _Dataframes in Julia_

**CS6741: Statistical Foundations of Data Science**

"

# ╔═╡ 5fe14400-7bf3-11eb-3399-1faf7f3c934d
md"# QUESTION_1 => __(solution)__"

# ╔═╡ be359910-7e4c-11eb-3aa5-0b846b09cdb6
md"# Untidy data"

# ╔═╡ 09235e60-7bfc-11eb-2686-57344cfa83ac
begin
	df = DataFrame(
		xid=1:10,
		x0=["Agnostic","Atheist", "Buddhist", "Catholic", "Don't know/refused", "Evangelical Prot", "Hindu", "Historically Black Prot", "Jehovah's Witness", "Jewish"] ,
		x1 = [27, 12, 27, 418, 15, 575, 1, 228, 20, 19],
		x2 = [34, 27, 21, 617, 14, 869, 9, 244, 27, 19],
		x3 = [60, 37, 30, 731, 15, 1064, 7, 236, 24, 25],
		x4 = [81, 52, 34, 670, 11, 982, 9, 238, 24, 25], 
		x5 = [76, 35, 33, 638, 10, 881, 11, 197, 21, 30],
		x6 = [137, 70, 58, 1116, 35, 1486, 34, 223, 30, 95],
		x7 = [304, 67, 21, 617, 14, 869, 9, 244, 27, 19],
		x8 = [6, 377, 307, 71, 5, 164, 97, 236, 24, 205],
		x9 = [801, 52, 347, 670, 11, 92, 19, 28, 214, 25], 
	)
	DF.rename!(df, [Symbol("<\$"*"$i"*"k") for i in ["xx","religion","10","10-20","20-30","30-40","40-50","50-75", "75-100", "100-150", "150"]])
	DF.rename!(df, "<\$religionk" => :religion, "<\$xxk" => :Index, "<\$150k" => Symbol(">\$150k"))
end

# ╔═╡ 9ff0d270-7e52-11eb-133e-e9b9fde1d398
md"# Tidy Data"

# ╔═╡ fa1df490-7e51-11eb-2c77-65d3cf8fd9d3
begin
	
	df_new = DF.stack(df,3:11, :religion)
	sort(DF.rename!(df_new, :variable=> :income, :value=> :freq))
	tidy_data1=df_new[df_new.religion.=="Agnostic",:]
	
end

# ╔═╡ a2f2c7d2-7e52-11eb-167d-5dac1de22660
md"# Tidy Data"

# ╔═╡ 0f670580-7e52-11eb-0348-6dd1b6690afa
tidy_data2=df_new[df_new.religion.=="Atheist",:]

# ╔═╡ b8f8b920-7c2e-11eb-04ce-5f33b90d8f42
md"# QUESTION_2 => __(solution)__"

# ╔═╡ c15b0640-7c2e-11eb-184c-dd7df90a26c5
begin
	untidy_data=DataFrame(
	id=vcat(["MX17004" for _ in 1:4],["DE66090" for _ in 1:4],["AW99007" for _ in 1:2]),
	year=vcat([2010, 2010, 2011, 2011, 2013, 2013, 2011, 2011, 2010, 2010]),
    month=collect(Iterators.flatten([[i,i] for i in 1:5])),
	element=collect(Iterators.flatten([["tmax","tmin"] for i in 1:5])),
	d1=[20.4,14.7,missing,missing,missing,missing,missing,missing,missing,missing],
	d2=[missing,missing,30.9,21.1,missing,missing,missing,missing,missing,missing],
	d3=[missing,missing,missing,missing,29.7,24.7,32,5,missing,missing],
    d4=[missing,missing,missing,missing,missing,missing,missing,missing,28,06],
	d5=[39,missing,missing,missing,missing,missing,48.2,25.7,missing,missing],
	d6=[missing,missing,missing,missing,26,18,missing,missing,missing,missing],
	d7=[missing,missing,50.8,39.9,missing,missing,missing,missing,missing,missing],
	d8=[missing,missing,missing,missing,missing,missing,missing,missing,missing,missing],
	d9=[missing,missing,56,18,missing,missing,missing,missing,missing,missing],
	d10=[missing,missing,missing,missing,19,12,missing,missing,missing,missing],
	d11=[missing,missing,missing,missing,missing,missing,18,9,missing,missing],
    d12=[missing,missing,missing,missing,missing,missing,missing,missing,23,12],
	d13=[31,14,missing,missing,missing,missing,missing,missing,26.5,23],
	d14=[missing,missing,missing,missing,missing,missing,missing,missing,missing,missing],
	d15=[29,missing,missing,missing,missing,18.8,missing,missing,missing,missing],
	d16=[missing,missing,missing,missing,missing,missing,missing,missing,missing,missing],
	d17=[missing,missing,38,19,missing,missing,missing,missing,missing,missing],
	d18=[missing,missing,missing,missing,missing,missing,missing,missing,missing,missing],
	d19=[missing,missing,missing,missing,40,3,missing,missing,missing,missing],
	d20=[missing,missing,missing,missing,missing,missing,missing,missing,missing,missing],
	d21=[missing,missing,missing,missing,missing,missing,23,11.5,missing,missing],
	d22=[missing,missing,missing,missing,missing,missing,missing,missing,27,18.5],
	d23=[missing,missing,missing,missing,missing,missing,missing,missing,missing,missing],
    d24=[missing,missing,missing,missing,missing,missing,missing,missing,missing,missing],
	d25=[missing,missing,missing,missing,12,6,missing,missing,missing,8],
	d26=[missing,missing,missing,missing,missing,missing,missing,missing,missing,10],
	d27=[missing,missing,missing,missing,missing,missing,missing,missing,missing,missing],
	d28=[missing,missing,missing,missing,missing,missing,missing,missing,missing,missing],
	d29=[missing,missing,missing,missing,missing,missing,missing,missing,missing,missing],
	d30=[missing,missing,28,20,missing,missing,missing,missing,29,missing],
)
end

# ╔═╡ 42640e1e-7c30-11eb-264e-3d7c96c48aec
year_month=[join(Array(row),"-") for row in eachrow(select(untidy_data, [:year, :month]))]

# ╔═╡ 6e3ebbf0-7c38-11eb-3dec-07212597312d
insertcols!(select!(untidy_data, Not([:year, :month])), 2, :date=>year_month)

# ╔═╡ f6b6d080-7cab-11eb-1e0d-2ba8108db370
trnsfrm=dropmissing(DF.stack(untidy_data, 4:33))

# ╔═╡ 304e0ce0-7cad-11eb-35ed-dde31e4b1dbf
begin
	trnsfrm2=select(trnsfrm, :id, [:date, :variable]=>ByRow((part1, part2)->part1*"-"*chop(part2, head=1, tail=0))=>"date", :element, :value)
	DF.rename!(trnsfrm2, :element=> :maxORmin, :value=> :temp)
end

# ╔═╡ 47f6e400-7e53-11eb-007f-0fb1665e0c65
md"# Tidy Data"

# ╔═╡ 9fbe3a90-7cae-11eb-03bd-f1b7b102cc85
sort(unstack(trnsfrm2, :maxORmin, :temp))

# ╔═╡ bf2af050-7cb1-11eb-196d-d7b085cee6b4
md"# QUESTION_3 => __(solution)__"

# ╔═╡ 26e2c1f0-7cb2-11eb-0fb2-e5d9cd5d3a82
untidy_data3=DataFrame(
	
	year=[2000 for _ in 1:15],
	
	artist=vcat(["2 Pac" for _ in 1:7],["2Gether" for _ in 1:3], ["3 Doors Down" for _ in 1:5]),
	
	time=vcat(["4:22" for _ in 1:7],["3:15" for _ in 1:3], ["3:53" for _ in 1:5]),
	
	track=vcat(["Baby Don't Cry" for _ in 1:7],["The Hardest Part Of Breaking Up" for _ in 1:3],["Kryptonite" for _ in 1:5]),
	
    date=["2000$i" for i in ["-02-26","-03-04","-03-11","-03-18","-03-25","-04-21","-04-08","-09-02","-09-09","-09-16","-04-08","-04-15","-04-22","-04-29","-05-06"]],
	
	week=vcat(1:7,1:3,1:5),
	
	rank=[87,82,72,77,87,94,99,91,87,92,81,70,68,67,66]
)


# ╔═╡ 1e129b00-7cb6-11eb-0a9c-172db2648492
begin
	push!(untidy_data3, [2000, "Adams, Yolanda", "5:30" ,"Open My Heart", "2000-08-26", 1, 76])
	push!(untidy_data3, [2000, "Adams, Yolanda", "5:30" ,"Open My Heart", "2000-09-2", 1, 76])
	push!(untidy_data3, [2000, "Adams, Yolanda", "5:30" ,"Open My Heart", "2000-09-9", 1, 74])
	select!(untidy_data3, Not([:week]))
end

# ╔═╡ 5af6fc00-7cb6-11eb-04c9-b702388de0f7
begin
	tidy_data3_1=unique!(select(untidy_data3,[:artist, :track]))
	len=size(tidy_data3_1)[1]
	insertcols!(tidy_data3_1, 1, :id=>[k for k in 1:len])
	tidy_data3_1
end

# ╔═╡ ddfd8c20-7cb8-11eb-25b0-c962d4bb4e33
tidy_data3_2=select!(leftjoin(untidy_data3, tidy_data3_1, on = :artist,  makeunique=true), [:id, :date, :rank])

# ╔═╡ 9bbb26e0-7cc4-11eb-361f-21bfecc88041
md"# QUESTION_4 => __(solution)__"

# ╔═╡ 18ab788e-7cce-11eb-18ae-cdcd9475ea66
function getJSONfromURL(urlSTRING)
	toParse=String(HTTP.get( urlSTRING).body)
	parsed = JSON.parse(toParse)["cases_time_series"]
	jsonDF=DataFrame(parsed[1])
	lendata=size(parsed)[1]	
	[push!(jsonDF, parsed[j]) for j in 2:lendata]
	return jsonDF
	
end

# ╔═╡ 06815ae0-7cce-11eb-0eb2-3f78c4b7b8c4
jsonDF=getJSONfromURL("https://api.covid19india.org/data.json")

# ╔═╡ 5eb9e9e0-7cd6-11eb-1f23-914ad9359f37
begin
	picked=select(jsonDF, [:date, :dateymd, :dailyconfirmed, :dailydeceased, :dailyrecovered])
	yyy=picked.date
	siz=[sizeof(xx)[1] for xx in yyy]
end

# ╔═╡ 340b7b82-7cd8-11eb-0769-5fdffc5cce00
begin
	picked.date=[yyy[i][3:siz[i]] for i in 1:size(siz)[1]]
	picked
end

# ╔═╡ 75664870-7ce3-11eb-28ed-21f98ef82894
begin
	trnsfrm3=select(picked,  [:date, :dateymd]=>ByRow((part1, part2)->chop(part1, head=1,tail=1)*"-"*chop(part2, head=0, tail=6))=>"year and month", :dailyconfirmed, :dailydeceased, :dailyrecovered)
end

# ╔═╡ d9c6ad80-7cea-11eb-05f8-8fb6059477ae
grp = groupby(trnsfrm3, "year and month")

# ╔═╡ a9aaebde-7ce8-11eb-1c13-371cc79c8fed
uniqueYearMonth=unique(trnsfrm3."year and month")

# ╔═╡ ac474c30-7ce9-11eb-148e-cb33ca12f070
begin
	finalDF=DataFrame(MM_YY=String[], totalconfirmed_In_MONTH=Int[], totaldeceased_In_MONTH=Int[], totalrecovered_In_MONTH=Int[])
	for go in 1:size(uniqueYearMonth)[1]
		curSubDF=DataFrame(grp[go])
		ints1=sum([parse(Int64,i) for i in curSubDF.dailyconfirmed])
		ints2=sum([parse(Int64,i) for i in curSubDF.dailydeceased])
		ints3=sum([parse(Int64,i) for i in curSubDF.dailyrecovered])
		push!(finalDF,(uniqueYearMonth[go], ints1, ints2, ints3))
	end
	finalDF
		
end

# ╔═╡ 19364092-7e88-11eb-2a90-01cbb8c8d924
md"# QUESTION - 5 (solution)"

# ╔═╡ 2a81a6e0-7cef-11eb-1d3e-a54be8fac15d
begin
	
		ints1=[parse(Int64,i) for i in trnsfrm3.dailyconfirmed]
		ints2=[parse(Int64,i) for i in trnsfrm3.dailydeceased]
		ints3=[parse(Int64,i) for i in trnsfrm3.dailyrecovered]
end

# ╔═╡ 1e8d0710-7cf6-11eb-2874-dbd518375c5a
begin
	arrints1=vcat([0,0,0,0,0,0],ints1)
	movingAVG1=0
	idx1=1
	answerARR1=[0.0,0.0,0.0,0.0,0.0,0.0]
	for i in arrints1[7:404]
		movingAVG1=(movingAVG1*7-arrints1[idx1]+i)/7
		push!(answerARR1, movingAVG1)
		idx1+=1
	end
	plot(1:(size(ints1)[1]+6),vcat([0,0,0,0,0,0],ints1), xlabel="Number of Days", ylabel="DailyConfirmed", title="Per day\n vs  Moving average", label="PerDay", legend=:bottomleft, line=1.2)
	plot!(1:size(answerARR1)[1],answerARR1, line=3, label="MovingAverage")
end

# ╔═╡ 8b4c7730-7cf8-11eb-0f53-55874786f090
begin
	arrints2=vcat([0,0,0,0,0,0],ints2)
	movingAVG2=0
	idx2=1
	answerARR2=[0.0,0.0,0.0,0.0,0.0,0.0]
	for i in arrints2[7:404]
		movingAVG2=(movingAVG2*7-arrints2[idx2]+i)/7
		push!(answerARR2, movingAVG2)
		idx2+=1
	end
	plot(1:(size(ints2)[1]+6),vcat([0,0,0,0,0,0],ints2), xlabel="Number of Days", ylabel="DailyDeceased", title="Per day\n vs  Moving average", label="PerDay", legend=:outertopleft , line=1.2)
	plot!(1:size(answerARR2)[1],answerARR2, line=2.5, label="MovingAverage")
end

# ╔═╡ e7f922d0-7cf8-11eb-266b-1b4239939cda
begin
	arrints3=vcat([0,0,0,0,0,0],ints3)
	movingAVG3=0
	idx3=1
	answerARR3=[0.0,0.0,0.0,0.0,0.0,0.0]
	for i in arrints3[7:404]
		movingAVG3=(movingAVG3*7-arrints3[idx3]+i)/7
		push!(answerARR3, movingAVG3)
		idx3+=1
	end
	plot(1:(size(ints3)[1]+6),vcat([0,0,0,0,0,0],ints3), xlabel="Number of Days", ylabel="DailyRecovered", title="Per day\n vs  Moving average", label="PerDay", legend=:bottomleft, line=1.2)
	plot!(1:size(answerARR3)[1],answerARR3, line=2.34567, label="MovingAverage")
	
end

# ╔═╡ 1619d560-7cc7-11eb-2083-07c2b1814bde


# ╔═╡ 77ec19b0-7cc7-11eb-2b18-950fc0fdf8dc


# ╔═╡ Cell order:
# ╟─2cbc5de0-7bed-11eb-2ef3-23a145ed8b9c
# ╠═5fe14400-7bf3-11eb-3399-1faf7f3c934d
# ╟─b9ad64ee-7bf3-11eb-235b-e73aac0c1a36
# ╠═be359910-7e4c-11eb-3aa5-0b846b09cdb6
# ╠═09235e60-7bfc-11eb-2686-57344cfa83ac
# ╠═9ff0d270-7e52-11eb-133e-e9b9fde1d398
# ╠═fa1df490-7e51-11eb-2c77-65d3cf8fd9d3
# ╠═a2f2c7d2-7e52-11eb-167d-5dac1de22660
# ╠═0f670580-7e52-11eb-0348-6dd1b6690afa
# ╟─b8f8b920-7c2e-11eb-04ce-5f33b90d8f42
# ╠═c15b0640-7c2e-11eb-184c-dd7df90a26c5
# ╠═42640e1e-7c30-11eb-264e-3d7c96c48aec
# ╠═6e3ebbf0-7c38-11eb-3dec-07212597312d
# ╠═f6b6d080-7cab-11eb-1e0d-2ba8108db370
# ╠═304e0ce0-7cad-11eb-35ed-dde31e4b1dbf
# ╠═47f6e400-7e53-11eb-007f-0fb1665e0c65
# ╠═9fbe3a90-7cae-11eb-03bd-f1b7b102cc85
# ╟─bf2af050-7cb1-11eb-196d-d7b085cee6b4
# ╠═26e2c1f0-7cb2-11eb-0fb2-e5d9cd5d3a82
# ╠═1e129b00-7cb6-11eb-0a9c-172db2648492
# ╠═5af6fc00-7cb6-11eb-04c9-b702388de0f7
# ╠═ddfd8c20-7cb8-11eb-25b0-c962d4bb4e33
# ╟─9bbb26e0-7cc4-11eb-361f-21bfecc88041
# ╠═a163f950-7cc4-11eb-24a4-a754d275690e
# ╠═18ab788e-7cce-11eb-18ae-cdcd9475ea66
# ╠═06815ae0-7cce-11eb-0eb2-3f78c4b7b8c4
# ╠═5eb9e9e0-7cd6-11eb-1f23-914ad9359f37
# ╠═340b7b82-7cd8-11eb-0769-5fdffc5cce00
# ╠═75664870-7ce3-11eb-28ed-21f98ef82894
# ╠═d9c6ad80-7cea-11eb-05f8-8fb6059477ae
# ╠═a9aaebde-7ce8-11eb-1c13-371cc79c8fed
# ╠═ac474c30-7ce9-11eb-148e-cb33ca12f070
# ╠═19364092-7e88-11eb-2a90-01cbb8c8d924
# ╠═2a81a6e0-7cef-11eb-1d3e-a54be8fac15d
# ╠═1e8d0710-7cf6-11eb-2874-dbd518375c5a
# ╠═8b4c7730-7cf8-11eb-0f53-55874786f090
# ╠═e7f922d0-7cf8-11eb-266b-1b4239939cda
# ╟─1619d560-7cc7-11eb-2083-07c2b1814bde
# ╟─77ec19b0-7cc7-11eb-2b18-950fc0fdf8dc

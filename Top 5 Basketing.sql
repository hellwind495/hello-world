use mydb

select
	cus_num,make,model,NewOrUsed,ModelYear
into
	#temp
from
	mytable

select
	PMake=t.make,PModel=t.model,PNewOrUsed=t.NewOrUsed,PModelYear=t.ModelYear,
	t2.make,t2.model,t2.NewOrUsed,t2.ModelYear,
	NumberOfMatches=count(*)
into
	#matching
from
	#temp t
	inner join #temp t2 on t2.cus_num=t.cus_num
group by
	t.make,t.model,t.NewOrUsed,t.ModelYear,
	t2.make,t2.model,t2.NewOrUsed,t2.ModelYear,

select
	top 5 *
from
	#matching
where
	PMake=@make and PModel=@model and PNewOrUsed='N' and PModelYear=2015
order by
	NumberOfMatches desc

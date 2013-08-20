@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::lib::Squeeze

public list[&T] squeeze(list[&T] a)
{
	set[&T] visited = {};
	list[&T] res = [];
	for (&T e <- a)
	{
		if (e notin visited)
		{
			visited += e;
			res += e;
		}
	}
	return res;
}

list[int] e = [];

test bool sq0() = squeeze(e) == e;
test bool sq1() = squeeze([1]) == [1];
test bool sq2() = squeeze([1,2]) == [1,2];
test bool sq3() = squeeze([1,2,2]) == [1,2];
test bool sq4() = squeeze(["one","two","one"]) == ["one","two"];
test bool sq5() = squeeze([1,2,2,3,1,2,3,3,2,1,3]) == [1,2,3];
@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::lib::Squeeze

// import IO;
// 
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
// 
// public void main(list[str] args)
// {
// 	println(squeeze([1,2,3,2,3,4,2,5,4]));
// }
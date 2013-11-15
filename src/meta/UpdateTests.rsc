@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module meta::UpdateTests

import meta::sync::DifferTests;
import meta::sync::XBGFTests;
import meta::sync::SLEIRTests;

public void updall()
{
	meta::sync::DifferTests::main();
	meta::sync::XBGFTests::main();
	meta::sync::SLEIRTests::main();
}
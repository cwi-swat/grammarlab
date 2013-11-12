@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module meta::UpdateTests

import meta::UpdateDifferTests;
import meta::UpdateXBGFTests;
import meta::UpdateSLEIRTests;

public void updall()
{
	meta::UpdateDifferTests::main();
	meta::UpdateXBGFTests::main();
	meta::UpdateSLEIRTests::main();
}
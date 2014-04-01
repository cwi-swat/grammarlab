@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module grammarlab::lib::Profiler

import DateTime;
import String;
import List;

public datetime startTheClock() = now();

public str formatDuration(datetime s)
{
	I = createDuration(s,now());
	ms = "<I.milliseconds>";
	while (size(ms)<3) ms = "0<ms>";
	list[str] rest = [];
	if (I.hours>0) rest += fitin2(I.hours);
	if (I.minutes>0) rest += fitin2(I.minutes);
	if (I.seconds>0) rest += fitin2(I.seconds);
	return intercalate(":",rest)+"."+ms;
}

str fitin2(int x) = (x<10) ? "0<x>" : "<x>";
@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::export::XScope

import  grammarlab::language::XScope;

str pps(globally())                       = "globally";
str pps(nowhere())                        = "nowhere";
str pps(inlabel(str x))                   = "in [<x>]";
str pps(notinlabel(str x))                = "not in [<x>]";
str pps(inmark(str x))                    = "in \<<x>\>";
str pps(notinmark(str x))                 = "not in \<<x>\>";
str pps(innt(str x))                      = "in <x>";
str pps(notinnt(str x))                   = "not in <x>";
str pps(comboscope(XScope w1, XScope w2)) = "in both <pps(w1)> and <pps(w2)>";

@contributor{Super Awesome Automated XBGF Test Suite Synchroniser}
@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module tests::transform::XBGF

import IO;
import grammarlab::language::Grammar;
import grammarlab::export::Grammar;
import grammarlab::compare::Differ;
import grammarlab::language::GlueScript;
import grammarlab::language::glue::Interpreter;
import grammarlab::io::GLUE;
import grammarlab::lib::ebnf::Glue;

bool run_case(str casen, bool debug)
{
	GGrammar uit = execute(EmptyGrammar,loadGlue(|project://grammarlab/src/tests/transform/set/<casen>|));
	bool res = false;
	if (debug) res = gdtv(uit,EmptyGrammar);
	else res = gdts(uit,EmptyGrammar);
	if (!res) println("[FAIL] |project://grammarlab/src/tests/transform/set/<casen>|");		
	if (!res && debug) println("Remaining grammar: <ppx(uit,GlueEBNF)>");
	return res;
}

// abridge.glue
test bool test_abridge() = run_case("abridge.glue",false);
void show_abridge() {run_case("abridge.glue",true);}

// abstractize.glue
test bool test_abstractize() = run_case("abstractize.glue",false);
void show_abstractize() {run_case("abstractize.glue",true);}

// add_horizontal.glue
test bool test_add_horizontal() = run_case("add_horizontal.glue",false);
void show_add_horizontal() {run_case("add_horizontal.glue",true);}

// add_inside.glue
test bool test_add_inside() = run_case("add_inside.glue",false);
void show_add_inside() {run_case("add_inside.glue",true);}

// add_vertical.glue
test bool test_add_vertical() = run_case("add_vertical.glue",false);
void show_add_vertical() {run_case("add_vertical.glue",true);}

// add_vertical_middle.glue
test bool test_add_vertical_middle() = run_case("add_vertical_middle.glue",false);
void show_add_vertical_middle() {run_case("add_vertical_middle.glue",true);}

// add_vertical_scattered.glue
test bool test_add_vertical_scattered() = run_case("add_vertical_scattered.glue",false);
void show_add_vertical_scattered() {run_case("add_vertical_scattered.glue",true);}

// anonymize_multiple.glue
test bool test_anonymize_multiple() = run_case("anonymize_multiple.glue",false);
void show_anonymize_multiple() {run_case("anonymize_multiple.glue",true);}

// anonymize_single.glue
test bool test_anonymize_single() = run_case("anonymize_single.glue",false);
void show_anonymize_single() {run_case("anonymize_single.glue",true);}

// appear_q.glue
test bool test_appear_q() = run_case("appear_q.glue",false);
void show_appear_q() {run_case("appear_q.glue",true);}

// appear_s.glue
test bool test_appear_s() = run_case("appear_s.glue",false);
void show_appear_s() {run_case("appear_s.glue",true);}

// bypass.glue
test bool test_bypass() = run_case("bypass.glue",false);
void show_bypass() {run_case("bypass.glue",true);}

// chain_l.glue
test bool test_chain_l() = run_case("chain_l.glue",false);
void show_chain_l() {run_case("chain_l.glue",true);}

// chain_n.glue
test bool test_chain_n() = run_case("chain_n.glue",false);
void show_chain_n() {run_case("chain_n.glue",true);}

// concretize.glue
test bool test_concretize() = run_case("concretize.glue",false);
void show_concretize() {run_case("concretize.glue",true);}

// deanonymize_multiple.glue
test bool test_deanonymize_multiple() = run_case("deanonymize_multiple.glue",false);
void show_deanonymize_multiple() {run_case("deanonymize_multiple.glue",true);}

// deanonymize_single.glue
test bool test_deanonymize_single() = run_case("deanonymize_single.glue",false);
void show_deanonymize_single() {run_case("deanonymize_single.glue",true);}

// define.glue
test bool test_define() = run_case("define.glue",false);
void show_define() {run_case("define.glue",true);}

// designate.glue
test bool test_designate() = run_case("designate.glue",false);
void show_designate() {run_case("designate.glue",true);}

// detour.glue
test bool test_detour() = run_case("detour.glue",false);
void show_detour() {run_case("detour.glue",true);}

// deyaccify_eps.glue
test bool test_deyaccify_eps() = run_case("deyaccify_eps.glue",false);
void show_deyaccify_eps() {run_case("deyaccify_eps.glue",true);}

// deyaccify_left.glue
test bool test_deyaccify_left() = run_case("deyaccify_left.glue",false);
void show_deyaccify_left() {run_case("deyaccify_left.glue",true);}

// deyaccify_left_plus.glue
test bool test_deyaccify_left_plus() = run_case("deyaccify_left_plus.glue",false);
void show_deyaccify_left_plus() {run_case("deyaccify_left_plus.glue",true);}

// deyaccify_right.glue
test bool test_deyaccify_right() = run_case("deyaccify_right.glue",false);
void show_deyaccify_right() {run_case("deyaccify_right.glue",true);}

// deyaccify_right_plus.glue
test bool test_deyaccify_right_plus() = run_case("deyaccify_right_plus.glue",false);
void show_deyaccify_right_plus() {run_case("deyaccify_right_plus.glue",true);}

// disappear_q.glue
test bool test_disappear_q() = run_case("disappear_q.glue",false);
void show_disappear_q() {run_case("disappear_q.glue",true);}

// disappear_s.glue
test bool test_disappear_s() = run_case("disappear_s.glue",false);
void show_disappear_s() {run_case("disappear_s.glue",true);}

// distribute_l.glue
test bool test_distribute_l() = run_case("distribute_l.glue",false);
void show_distribute_l() {run_case("distribute_l.glue",true);}

// distribute_nt.glue
test bool test_distribute_nt() = run_case("distribute_nt.glue",false);
void show_distribute_nt() {run_case("distribute_nt.glue",true);}

// downgrade.glue
test bool test_downgrade() = run_case("downgrade.glue",false);
void show_downgrade() {run_case("downgrade.glue",true);}

// eliminate.glue
test bool test_eliminate() = run_case("eliminate.glue",false);
void show_eliminate() {run_case("eliminate.glue",true);}

// equate1.glue
test bool test_equate1() = run_case("equate1.glue",false);
void show_equate1() {run_case("equate1.glue",true);}

// equate2.glue
test bool test_equate2() = run_case("equate2.glue",false);
void show_equate2() {run_case("equate2.glue",true);}

// equate3.glue
test bool test_equate3() = run_case("equate3.glue",false);
void show_equate3() {run_case("equate3.glue",true);}

// equate4.glue
test bool test_equate4() = run_case("equate4.glue",false);
void show_equate4() {run_case("equate4.glue",true);}

// extract_l.glue
test bool test_extract_l() = run_case("extract_l.glue",false);
void show_extract_l() {run_case("extract_l.glue",true);}

// extract_nt.glue
test bool test_extract_nt() = run_case("extract_nt.glue",false);
void show_extract_nt() {run_case("extract_nt.glue",true);}

// extract_subch.glue
test bool test_extract_subch() = run_case("extract_subch.glue",false);
void show_extract_subch() {run_case("extract_subch.glue",true);}

// extract_subseq_multiple.glue
test bool test_extract_subseq_multiple() = run_case("extract_subseq_multiple.glue",false);
void show_extract_subseq_multiple() {run_case("extract_subseq_multiple.glue",true);}

// extract_subseq_single.glue
test bool test_extract_subseq_single() = run_case("extract_subseq_single.glue",false);
void show_extract_subseq_single() {run_case("extract_subseq_single.glue",true);}

// factor_eps.glue
test bool test_factor_eps() = run_case("factor_eps.glue",false);
void show_factor_eps() {run_case("factor_eps.glue",true);}

// factor_global.glue
test bool test_factor_global() = run_case("factor_global.glue",false);
void show_factor_global() {run_case("factor_global.glue",true);}

// factor_local.glue
test bool test_factor_local() = run_case("factor_local.glue",false);
void show_factor_local() {run_case("factor_local.glue",true);}

// factor_nt.glue
test bool test_factor_nt() = run_case("factor_nt.glue",false);
void show_factor_nt() {run_case("factor_nt.glue",true);}

// fold.glue
test bool test_fold() = run_case("fold.glue",false);
void show_fold() {run_case("fold.glue",true);}

// fold_l.glue
test bool test_fold_l() = run_case("fold_l.glue",false);
void show_fold_l() {run_case("fold_l.glue",true);}

// fold_nt.glue
test bool test_fold_nt() = run_case("fold_nt.glue",false);
void show_fold_nt() {run_case("fold_nt.glue",true);}

// horizontal_l.glue
test bool test_horizontal_l() = run_case("horizontal_l.glue",false);
void show_horizontal_l() {run_case("horizontal_l.glue",true);}

// horizontal_n.glue
test bool test_horizontal_n() = run_case("horizontal_n.glue",false);
void show_horizontal_n() {run_case("horizontal_n.glue",true);}

// import.glue
test bool test_import() = run_case("import.glue",false);
void show_import() {run_case("import.glue",true);}

// inject.glue
test bool test_inject() = run_case("inject.glue",false);
void show_inject() {run_case("inject.glue",true);}

// inline.glue
test bool test_inline() = run_case("inline.glue",false);
void show_inline() {run_case("inline.glue",true);}

// introduce.glue
test bool test_introduce() = run_case("introduce.glue",false);
void show_introduce() {run_case("introduce.glue",true);}

// iterate_l.glue
test bool test_iterate_l() = run_case("iterate_l.glue",false);
void show_iterate_l() {run_case("iterate_l.glue",true);}

// iterate_p.glue
test bool test_iterate_p() = run_case("iterate_p.glue",false);
void show_iterate_p() {run_case("iterate_p.glue",true);}

// iterate_r.glue
test bool test_iterate_r() = run_case("iterate_r.glue",false);
void show_iterate_r() {run_case("iterate_r.glue",true);}

// lassoc_l.glue
test bool test_lassoc_l() = run_case("lassoc_l.glue",false);
void show_lassoc_l() {run_case("lassoc_l.glue",true);}

// lassoc_p.glue
test bool test_lassoc_p() = run_case("lassoc_p.glue",false);
void show_lassoc_p() {run_case("lassoc_p.glue",true);}

// lassoc_r.glue
test bool test_lassoc_r() = run_case("lassoc_r.glue",false);
void show_lassoc_r() {run_case("lassoc_r.glue",true);}

// massage_assoc_p.glue
test bool test_massage_assoc_p() = run_case("massage_assoc_p.glue",false);
void show_massage_assoc_p() {run_case("massage_assoc_p.glue",true);}

// massage_assoc_q.glue
test bool test_massage_assoc_q() = run_case("massage_assoc_q.glue",false);
void show_massage_assoc_q() {run_case("massage_assoc_q.glue",true);}

// massage_assoc_s.glue
test bool test_massage_assoc_s() = run_case("massage_assoc_s.glue",false);
void show_massage_assoc_s() {run_case("massage_assoc_s.glue",true);}

// massage_ch_ep.glue
test bool test_massage_ch_ep() = run_case("massage_ch_ep.glue",false);
void show_massage_ch_ep() {run_case("massage_ch_ep.glue",true);}

// massage_ch_eq.glue
test bool test_massage_ch_eq() = run_case("massage_ch_eq.glue",false);
void show_massage_ch_eq() {run_case("massage_ch_eq.glue",true);}

// massage_ch_es.glue
test bool test_massage_ch_es() = run_case("massage_ch_es.glue",false);
void show_massage_ch_es() {run_case("massage_ch_es.glue",true);}

// massage_ch_ex.glue
test bool test_massage_ch_ex() = run_case("massage_ch_ex.glue",false);
void show_massage_ch_ex() {run_case("massage_ch_ex.glue",true);}

// massage_ch_ps.glue
test bool test_massage_ch_ps() = run_case("massage_ch_ps.glue",false);
void show_massage_ch_ps() {run_case("massage_ch_ps.glue",true);}

// massage_ch_qp.glue
test bool test_massage_ch_qp() = run_case("massage_ch_qp.glue",false);
void show_massage_ch_qp() {run_case("massage_ch_qp.glue",true);}

// massage_ch_qs.glue
test bool test_massage_ch_qs() = run_case("massage_ch_qs.glue",false);
void show_massage_ch_qs() {run_case("massage_ch_qs.glue",true);}

// massage_ch_xp.glue
test bool test_massage_ch_xp() = run_case("massage_ch_xp.glue",false);
void show_massage_ch_xp() {run_case("massage_ch_xp.glue",true);}

// massage_ch_xq.glue
test bool test_massage_ch_xq() = run_case("massage_ch_xq.glue",false);
void show_massage_ch_xq() {run_case("massage_ch_xq.glue",true);}

// massage_ch_xs.glue
test bool test_massage_ch_xs() = run_case("massage_ch_xs.glue",false);
void show_massage_ch_xs() {run_case("massage_ch_xs.glue",true);}

// massage_ch_xx1.glue
test bool test_massage_ch_xx1() = run_case("massage_ch_xx1.glue",false);
void show_massage_ch_xx1() {run_case("massage_ch_xx1.glue",true);}

// massage_ch_xx2.glue
test bool test_massage_ch_xx2() = run_case("massage_ch_xx2.glue",false);
void show_massage_ch_xx2() {run_case("massage_ch_xx2.glue",true);}

// massage_ch_xx3.glue
test bool test_massage_ch_xx3() = run_case("massage_ch_xx3.glue",false);
void show_massage_ch_xx3() {run_case("massage_ch_xx3.glue",true);}

// massage_comp_pp.glue
test bool test_massage_comp_pp() = run_case("massage_comp_pp.glue",false);
void show_massage_comp_pp() {run_case("massage_comp_pp.glue",true);}

// massage_comp_pq.glue
test bool test_massage_comp_pq() = run_case("massage_comp_pq.glue",false);
void show_massage_comp_pq() {run_case("massage_comp_pq.glue",true);}

// massage_comp_ps.glue
test bool test_massage_comp_ps() = run_case("massage_comp_ps.glue",false);
void show_massage_comp_ps() {run_case("massage_comp_ps.glue",true);}

// massage_comp_qp.glue
test bool test_massage_comp_qp() = run_case("massage_comp_qp.glue",false);
void show_massage_comp_qp() {run_case("massage_comp_qp.glue",true);}

// massage_comp_qq.glue
test bool test_massage_comp_qq() = run_case("massage_comp_qq.glue",false);
void show_massage_comp_qq() {run_case("massage_comp_qq.glue",true);}

// massage_comp_qs.glue
test bool test_massage_comp_qs() = run_case("massage_comp_qs.glue",false);
void show_massage_comp_qs() {run_case("massage_comp_qs.glue",true);}

// massage_comp_sp.glue
test bool test_massage_comp_sp() = run_case("massage_comp_sp.glue",false);
void show_massage_comp_sp() {run_case("massage_comp_sp.glue",true);}

// massage_comp_sq.glue
test bool test_massage_comp_sq() = run_case("massage_comp_sq.glue",false);
void show_massage_comp_sq() {run_case("massage_comp_sq.glue",true);}

// massage_comp_ss.glue
test bool test_massage_comp_ss() = run_case("massage_comp_ss.glue",false);
void show_massage_comp_ss() {run_case("massage_comp_ss.glue",true);}

// massage_complex.glue
test bool test_massage_complex() = run_case("massage_complex.glue",false);
void show_massage_complex() {run_case("massage_complex.glue",true);}

// massage_distr_ch.glue
test bool test_massage_distr_ch() = run_case("massage_distr_ch.glue",false);
void show_massage_distr_ch() {run_case("massage_distr_ch.glue",true);}

// massage_morgan1.glue
test bool test_massage_morgan1() = run_case("massage_morgan1.glue",false);
void show_massage_morgan1() {run_case("massage_morgan1.glue",true);}

// massage_morgan2.glue
test bool test_massage_morgan2() = run_case("massage_morgan2.glue",false);
void show_massage_morgan2() {run_case("massage_morgan2.glue",true);}

// massage_morgan3.glue
test bool test_massage_morgan3() = run_case("massage_morgan3.glue",false);
void show_massage_morgan3() {run_case("massage_morgan3.glue",true);}

// massage_morgan4.glue
test bool test_massage_morgan4() = run_case("massage_morgan4.glue",false);
void show_massage_morgan4() {run_case("massage_morgan4.glue",true);}

// massage_nn.glue
test bool test_massage_nn() = run_case("massage_nn.glue",false);
void show_massage_nn() {run_case("massage_nn.glue",true);}

// massage_sel_s.glue
test bool test_massage_sel_s() = run_case("massage_sel_s.glue",false);
void show_massage_sel_s() {run_case("massage_sel_s.glue",true);}

// massage_seq_pq.glue
test bool test_massage_seq_pq() = run_case("massage_seq_pq.glue",false);
void show_massage_seq_pq() {run_case("massage_seq_pq.glue",true);}

// massage_seq_ps.glue
test bool test_massage_seq_ps() = run_case("massage_seq_ps.glue",false);
void show_massage_seq_ps() {run_case("massage_seq_ps.glue",true);}

// massage_seq_sq.glue
test bool test_massage_seq_sq() = run_case("massage_seq_sq.glue",false);
void show_massage_seq_sq() {run_case("massage_seq_sq.glue",true);}

// massage_seq_ss.glue
test bool test_massage_seq_ss() = run_case("massage_seq_ss.glue",false);
void show_massage_seq_ss() {run_case("massage_seq_ss.glue",true);}

// massage_seq_xs.glue
test bool test_massage_seq_xs() = run_case("massage_seq_xs.glue",false);
void show_massage_seq_xs() {run_case("massage_seq_xs.glue",true);}

// narrow_global.glue
test bool test_narrow_global() = run_case("narrow_global.glue",false);
void show_narrow_global() {run_case("narrow_global.glue",true);}

// narrow_l.glue
test bool test_narrow_l() = run_case("narrow_l.glue",false);
void show_narrow_l() {run_case("narrow_l.glue",true);}

// narrow_nt.glue
test bool test_narrow_nt() = run_case("narrow_nt.glue",false);
void show_narrow_nt() {run_case("narrow_nt.glue",true);}

// permute.glue
test bool test_permute() = run_case("permute.glue",false);
void show_permute() {run_case("permute.glue",true);}

// project.glue
test bool test_project() = run_case("project.glue",false);
void show_project() {run_case("project.glue",true);}

// rassoc_p.glue
test bool test_rassoc_p() = run_case("rassoc_p.glue",false);
void show_rassoc_p() {run_case("rassoc_p.glue",true);}

// rassoc_s.glue
test bool test_rassoc_s() = run_case("rassoc_s.glue",false);
void show_rassoc_s() {run_case("rassoc_s.glue",true);}

// redefine.glue
test bool test_redefine() = run_case("redefine.glue",false);
void show_redefine() {run_case("redefine.glue",true);}

// remove_horizontal.glue
test bool test_remove_horizontal() = run_case("remove_horizontal.glue",false);
void show_remove_horizontal() {run_case("remove_horizontal.glue",true);}

// remove_inside.glue
test bool test_remove_inside() = run_case("remove_inside.glue",false);
void show_remove_inside() {run_case("remove_inside.glue",true);}

// remove_vertical.glue
test bool test_remove_vertical() = run_case("remove_vertical.glue",false);
void show_remove_vertical() {run_case("remove_vertical.glue",true);}

// rename4.glue
test bool test_rename4() = run_case("rename4.glue",false);
void show_rename4() {run_case("rename4.glue",true);}

// renameL.glue
test bool test_renameL() = run_case("renameL.glue",false);
void show_renameL() {run_case("renameL.glue",true);}

// renameN.glue
test bool test_renameN() = run_case("renameN.glue",false);
void show_renameN() {run_case("renameN.glue",true);}

// renameS.glue
test bool test_renameS() = run_case("renameS.glue",false);
void show_renameS() {run_case("renameS.glue",true);}

// renameT.glue
test bool test_renameT() = run_case("renameT.glue",false);
void show_renameT() {run_case("renameT.glue",true);}

// replace_choice.glue
test bool test_replace_choice() = run_case("replace_choice.glue",false);
void show_replace_choice() {run_case("replace_choice.glue",true);}

// replace_choice_part.glue
test bool test_replace_choice_part() = run_case("replace_choice_part.glue",false);
void show_replace_choice_part() {run_case("replace_choice_part.glue",true);}

// replace_global.glue
test bool test_replace_global() = run_case("replace_global.glue",false);
void show_replace_global() {run_case("replace_global.glue",true);}

// replace_l.glue
test bool test_replace_l() = run_case("replace_l.glue",false);
void show_replace_l() {run_case("replace_l.glue",true);}

// replace_nt.glue
test bool test_replace_nt() = run_case("replace_nt.glue",false);
void show_replace_nt() {run_case("replace_nt.glue",true);}

// replace_seq.glue
test bool test_replace_seq() = run_case("replace_seq.glue",false);
void show_replace_seq() {run_case("replace_seq.glue",true);}

// reroot.glue
test bool test_reroot() = run_case("reroot.glue",false);
void show_reroot() {run_case("reroot.glue",true);}

// splitN1.glue
test bool test_splitN1() = run_case("splitN1.glue",false);
void show_splitN1() {run_case("splitN1.glue",true);}

// splitN2.glue
test bool test_splitN2() = run_case("splitN2.glue",false);
void show_splitN2() {run_case("splitN2.glue",true);}

// splitN3.glue
test bool test_splitN3() = run_case("splitN3.glue",false);
void show_splitN3() {run_case("splitN3.glue",true);}

// splitN4.glue
test bool test_splitN4() = run_case("splitN4.glue",false);
void show_splitN4() {run_case("splitN4.glue",true);}

// splitT1.glue
test bool test_splitT1() = run_case("splitT1.glue",false);
void show_splitT1() {run_case("splitT1.glue",true);}

// splitT2.glue
test bool test_splitT2() = run_case("splitT2.glue",false);
void show_splitT2() {run_case("splitT2.glue",true);}

// splitT3.glue
test bool test_splitT3() = run_case("splitT3.glue",false);
void show_splitT3() {run_case("splitT3.glue",true);}

// splitT4.glue
test bool test_splitT4() = run_case("splitT4.glue",false);
void show_splitT4() {run_case("splitT4.glue",true);}

// unchain_l.glue
test bool test_unchain_l() = run_case("unchain_l.glue",false);
void show_unchain_l() {run_case("unchain_l.glue",true);}

// unchain_n.glue
test bool test_unchain_n() = run_case("unchain_n.glue",false);
void show_unchain_n() {run_case("unchain_n.glue",true);}

// undefine1.glue
test bool test_undefine1() = run_case("undefine1.glue",false);
void show_undefine1() {run_case("undefine1.glue",true);}

// undefine2.glue
test bool test_undefine2() = run_case("undefine2.glue",false);
void show_undefine2() {run_case("undefine2.glue",true);}

// unfold.glue
test bool test_unfold() = run_case("unfold.glue",false);
void show_unfold() {run_case("unfold.glue",true);}

// unfold_l.glue
test bool test_unfold_l() = run_case("unfold_l.glue",false);
void show_unfold_l() {run_case("unfold_l.glue",true);}

// unfold_normalize.glue
test bool test_unfold_normalize() = run_case("unfold_normalize.glue",false);
void show_unfold_normalize() {run_case("unfold_normalize.glue",true);}

// unfold_nt.glue
test bool test_unfold_nt() = run_case("unfold_nt.glue",false);
void show_unfold_nt() {run_case("unfold_nt.glue",true);}

// unite_eq.glue
test bool test_unite_eq() = run_case("unite_eq.glue",false);
void show_unite_eq() {run_case("unite_eq.glue",true);}

// unite_normal.glue
test bool test_unite_normal() = run_case("unite_normal.glue",false);
void show_unite_normal() {run_case("unite_normal.glue",true);}

// unlabel.glue
test bool test_unlabel() = run_case("unlabel.glue",false);
void show_unlabel() {run_case("unlabel.glue",true);}

// upgrade.glue
test bool test_upgrade() = run_case("upgrade.glue",false);
void show_upgrade() {run_case("upgrade.glue",true);}

// vertical_l.glue
test bool test_vertical_l() = run_case("vertical_l.glue",false);
void show_vertical_l() {run_case("vertical_l.glue",true);}

// vertical_s.glue
test bool test_vertical_s() = run_case("vertical_s.glue",false);
void show_vertical_s() {run_case("vertical_s.glue",true);}

// widen_global.glue
test bool test_widen_global() = run_case("widen_global.glue",false);
void show_widen_global() {run_case("widen_global.glue",true);}

// widen_l.glue
test bool test_widen_l() = run_case("widen_l.glue",false);
void show_widen_l() {run_case("widen_l.glue",true);}

// widen_nt.glue
test bool test_widen_nt() = run_case("widen_nt.glue",false);
void show_widen_nt() {run_case("widen_nt.glue",true);}

// widen_sub.glue
test bool test_widen_sub() = run_case("widen_sub.glue",false);
void show_widen_sub() {run_case("widen_sub.glue",true);}

// yaccify_eps.glue
test bool test_yaccify_eps() = run_case("yaccify_eps.glue",false);
void show_yaccify_eps() {run_case("yaccify_eps.glue",true);}

// yaccify_left.glue
test bool test_yaccify_left() = run_case("yaccify_left.glue",false);
void show_yaccify_left() {run_case("yaccify_left.glue",true);}

// yaccify_left_plus.glue
test bool test_yaccify_left_plus() = run_case("yaccify_left_plus.glue",false);
void show_yaccify_left_plus() {run_case("yaccify_left_plus.glue",true);}

// yaccify_right.glue
test bool test_yaccify_right() = run_case("yaccify_right.glue",false);
void show_yaccify_right() {run_case("yaccify_right.glue",true);}

// yaccify_right_plus.glue
test bool test_yaccify_right_plus() = run_case("yaccify_right_plus.glue",false);
void show_yaccify_right_plus() {run_case("yaccify_right_plus.glue",true);}

(**************************************************************************)
(*       ___                                                              *)
(*      ||M||                                                             *)
(*      ||A||       A project by Andrea Asperti                           *)
(*      ||T||                                                             *)
(*      ||I||       Developers:                                           *)
(*      ||T||         The HELM team.                                      *)
(*      ||A||         http://helm.cs.unibo.it                             *)
(*      \   /                                                             *)
(*       \ /        This file is distributed under the terms of the       *)
(*        v         GNU General Public License Version 2                  *)
(*                                                                        *)
(**************************************************************************)

include "basic_2/rt_computation/cpxs_tdeq.ma".
include "basic_2/rt_computation/fpbs_cpxs.ma".
include "basic_2/rt_computation/fpbg_fpbs.ma".

(* PROPER PARALLEL RST-COMPUTATION FOR CLOSURES *****************************)

(* Properties with unbound context-sensitive parallel rt-computation ********)

(* Basic_2A1: was: cpxs_fpbg *)
lemma cpxs_tdneq_fpbg (h) (o): ∀G,L,T1,T2. ⦃G, L⦄ ⊢ T1 ⬈*[h] T2 →
                               (T1 ≛[h, o] T2 → ⊥) → ⦃G, L, T1⦄ >[h, o] ⦃G, L, T2⦄.
#h #o #G #L #T1 #T2 #H #H0
elim (cpxs_tdneq_fwd_step_sn … H … H0) -H -H0
/4 width=5 by cpxs_tdeq_fpbs, fpb_cpx, ex2_3_intro/
qed.

lemma cpxs_fpbg_trans (h) (o): ∀G1,L1,T1,T. ⦃G1, L1⦄ ⊢ T1 ⬈*[h] T →
                               ∀G2,L2,T2. ⦃G1, L1, T⦄ >[h, o] ⦃G2, L2, T2⦄ → ⦃G1, L1, T1⦄ >[h, o] ⦃G2, L2, T2⦄.
/3 width=5 by fpbs_fpbg_trans, cpxs_fpbs/ qed-.

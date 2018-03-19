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

include "basic_2/static/ffdeq_fqup.ma".
include "basic_2/static/ffdeq_ffdeq.ma".
include "basic_2/rt_transition/fpbq_fpb.ma".
include "basic_2/rt_computation/fpbg.ma".

(* PROPER PARALLEL RST-COMPUTATION FOR CLOSURES *****************************)

(* Advanced forward lemmas **************************************************)

lemma fpbg_fwd_fpbs: ∀h,o,G1,G2,L1,L2,T1,T2.
                     ⦃G1, L1, T1⦄ >[h,o] ⦃G2, L2, T2⦄ → ⦃G1, L1, T1⦄ ≥[h, o] ⦃G2, L2, T2⦄.
#h #o #G1 #G2 #L1 #L2 #T1 #T2 *
/3 width=5 by fpbs_strap2, fpb_fpbq/
qed-.

(* Advanced properties with degree-based equivalence on closures ************)

(* Basic_2A1: uses: fleq_fpbg_trans *)
lemma ffdeq_fpbg_trans: ∀h,o,G,G2,L,L2,T,T2. ⦃G, L, T⦄ >[h, o] ⦃G2, L2, T2⦄ →
                        ∀G1,L1,T1. ⦃G1, L1, T1⦄ ≛[h, o] ⦃G, L, T⦄ → ⦃G1, L1, T1⦄ >[h, o] ⦃G2, L2, T2⦄.
#h #o #G #G2 #L #L2 #T #T2 * #G0 #L0 #T0 #H0 #H02 #G1 #L1 #T1 #H1
elim (ffdeq_fpb_trans …  H1 … H0) -G -L -T
/4 width=9 by fpbs_strap2, fpbq_ffdeq, ex2_3_intro/
qed-.

(* Properties with parallel proper rst-reduction on closures ****************)

lemma fpb_fpbg_trans: ∀h,o,G1,G,G2,L1,L,L2,T1,T,T2.
                      ⦃G1, L1, T1⦄ ≻[h, o] ⦃G, L, T⦄ → ⦃G, L, T⦄ >[h, o] ⦃G2, L2, T2⦄ →
                      ⦃G1, L1, T1⦄ >[h, o] ⦃G2, L2, T2⦄.
/3 width=5 by fpbg_fwd_fpbs, ex2_3_intro/ qed-.

(* Properties with parallel rst-reduction on closures ***********************)

lemma fpbq_fpbg_trans: ∀h,o,G1,G,G2,L1,L,L2,T1,T,T2.
                       ⦃G1, L1, T1⦄ ≽[h, o] ⦃G, L, T⦄ → ⦃G, L, T⦄ >[h, o] ⦃G2, L2, T2⦄ →
                       ⦃G1, L1, T1⦄ >[h, o] ⦃G2, L2, T2⦄.
#h #o #G1 #G #G2 #L1 #L #L2 #T1 #T #T2 #H1 #H2
elim (fpbq_inv_fpb … H1) -H1
/2 width=5 by ffdeq_fpbg_trans, fpb_fpbg_trans/
qed-.

(* Properties with parallel rst-compuutation on closures ********************)

lemma fpbs_fpbg_trans: ∀h,o,G1,G,L1,L,T1,T. ⦃G1, L1, T1⦄ ≥[h, o] ⦃G, L, T⦄ →
                       ∀G2,L2,T2. ⦃G, L, T⦄ >[h, o] ⦃G2, L2, T2⦄ → ⦃G1, L1, T1⦄ >[h, o] ⦃G2, L2, T2⦄.
#h #o #G1 #G #L1 #L #T1 #T #H @(fpbs_ind … H) -G -L -T /3 width=5 by fpbq_fpbg_trans/
qed-.

(* Advanced inversion lemmas of parallel rst-computation on closures ********)

(* Basic_2A1: was: fpbs_fpbg *)
lemma fpbs_inv_fpbg: ∀h,o,G1,G2,L1,L2,T1,T2. ⦃G1, L1, T1⦄ ≥[h, o] ⦃G2, L2, T2⦄ →
                     ∨∨ ⦃G1, L1, T1⦄ ≛[h, o] ⦃G2, L2, T2⦄
                      | ⦃G1, L1, T1⦄ >[h, o] ⦃G2, L2, T2⦄.
#h #o #G1 #G2 #L1 #L2 #T1 #T2 #H @(fpbs_ind … H) -G2 -L2 -T2
[ /2 width=1 by or_introl/
| #G #G2 #L #L2 #T #T2 #_ #H2 * #H1
  elim (fpbq_inv_fpb … H2) -H2 #H2
  [ /3 width=5 by ffdeq_trans, or_introl/
  | elim (ffdeq_fpb_trans … H1 … H2) -G -L -T
    /4 width=5 by ex2_3_intro, or_intror, ffdeq_fpbs/
  | /3 width=5 by fpbg_ffdeq_trans, or_intror/
  | /4 width=5 by fpbg_fpbq_trans, fpb_fpbq, or_intror/
  ]
]
qed-.

(* Advanced properties of parallel rst-computation on closures **************)

lemma fpbs_fpb_trans: ∀h,o,F1,F2,K1,K2,T1,T2. ⦃F1, K1, T1⦄ ≥[h, o] ⦃F2, K2, T2⦄ →
                      ∀G2,L2,U2. ⦃F2, K2, T2⦄ ≻[h, o] ⦃G2, L2, U2⦄ →
                      ∃∃G1,L1,U1. ⦃F1, K1, T1⦄ ≻[h, o] ⦃G1, L1, U1⦄ & ⦃G1, L1, U1⦄ ≥[h, o] ⦃G2, L2, U2⦄.
#h #o #F1 #F2 #K1 #K2 #T1 #T2 #H elim (fpbs_inv_fpbg … H) -H
[ #H12 #G2 #L2 #U2 #H2 elim (ffdeq_fpb_trans … H12 … H2) -F2 -K2 -T2
  /3 width=5 by ffdeq_fpbs, ex2_3_intro/
| * #H1 #H2 #H3 #H4 #H5 #H6 #H7 #H8 #H9
  @(ex2_3_intro … H4) -H4 /3 width=5 by fpbs_strap1, fpb_fpbq/
]
qed-.

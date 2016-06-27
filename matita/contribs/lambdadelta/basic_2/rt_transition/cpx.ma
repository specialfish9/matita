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

include "basic_2/notation/relations/predty_5.ma".
include "basic_2/rt_transition/cpg.ma".

(* UNCOUNTED CONTEXT-SENSITIVE PARALLEL RT-TRANSITION FOR TERMS *************)

definition cpx (h): relation4 genv lenv term term ≝
                    λG,L,T1,T2. ∃c. ⦃G, L⦄ ⊢ T1 ⬈[c, h] T2.

interpretation
   "uncounted context-sensitive parallel rt-transition (term)"
   'PRedTy h G L T1 T2 = (cpx h G L T1 T2).

(* Basic properties *********************************************************)

lemma cpx_atom: ∀h,I,G,L. ⦃G, L⦄ ⊢ ⓪{I} ⬈[h] ⓪{I}.
/2 width=2 by cpg_atom, ex_intro/ qed.

(* Basic_2A1: was: cpx_st *)
lemma cpx_ess: ∀h,G,L,s. ⦃G, L⦄ ⊢ ⋆s ⬈[h] ⋆(next h s).
/2 width=2 by cpg_ess, ex_intro/ qed.

lemma cpx_delta: ∀h,I,G,K,V1,V2,W2. ⦃G, K⦄ ⊢ V1 ⬈[h] V2 →
                 ⬆*[1] V2 ≡ W2 → ⦃G, K.ⓑ{I}V1⦄ ⊢ #0 ⬈[h] W2.
#h * #G #K #V1 #V2 #W2 *
/3 width=4 by cpg_delta, cpg_ell, ex_intro/
qed.

lemma cpx_lref: ∀h,I,G,K,V,T,U,i. ⦃G, K⦄ ⊢ #i ⬈[h] T →
                ⬆*[1] T ≡ U → ⦃G, K.ⓑ{I}V⦄ ⊢ #⫯i ⬈[h] U.
#h #I #G #K #V #T #U #i *
/3 width=4 by cpg_lref, ex_intro/
qed.

lemma cpx_bind: ∀h,p,I,G,L,V1,V2,T1,T2.
                ⦃G, L⦄ ⊢ V1 ⬈[h] V2 → ⦃G, L.ⓑ{I}V1⦄ ⊢ T1 ⬈[h] T2 →
                ⦃G, L⦄ ⊢ ⓑ{p,I}V1.T1 ⬈[h] ⓑ{p,I}V2.T2.
#h #p #I #G #L #V1 #V2 #T1 #T2 * #cV #HV12 *
/3 width=2 by cpg_bind, ex_intro/
qed.

lemma cpx_flat: ∀h,I,G,L,V1,V2,T1,T2.
                ⦃G, L⦄ ⊢ V1 ⬈[h] V2 → ⦃G, L⦄ ⊢ T1 ⬈[h] T2 →
                ⦃G, L⦄ ⊢ ⓕ{I}V1.T1 ⬈[h] ⓕ{I}V2.T2.
#h #I #G #L #V1 #V2 #T1 #T2 * #cV #HV12 *
/3 width=2 by cpg_flat, ex_intro/
qed.

lemma cpx_zeta: ∀h,G,L,V,T1,T,T2. ⦃G, L.ⓓV⦄ ⊢ T1 ⬈[h] T →
                ⬆*[1] T2 ≡ T → ⦃G, L⦄ ⊢ +ⓓV.T1 ⬈[h] T2.
#h #G #L #V #T1 #T #T2 *
/3 width=4 by cpg_zeta, ex_intro/
qed.

lemma cpx_eps: ∀h,G,L,V,T1,T2. ⦃G, L⦄ ⊢ T1 ⬈[h] T2 → ⦃G, L⦄ ⊢ ⓝV.T1 ⬈[h] T2.
#h #G #L #V #T1 #T2 *
/3 width=2 by cpg_eps, ex_intro/
qed.

(* Basic_2A1: was: cpx_ct *)
lemma cpx_ee: ∀h,G,L,V1,V2,T. ⦃G, L⦄ ⊢ V1 ⬈[h] V2 → ⦃G, L⦄ ⊢ ⓝV1.T ⬈[h] V2.
#h #G #L #V1 #V2 #T *
/3 width=2 by cpg_ee, ex_intro/
qed.

lemma cpx_beta: ∀h,p,G,L,V1,V2,W1,W2,T1,T2.
                ⦃G, L⦄ ⊢ V1 ⬈[h] V2 → ⦃G, L⦄ ⊢ W1 ⬈[h] W2 → ⦃G, L.ⓛW1⦄ ⊢ T1 ⬈[h] T2 →
                ⦃G, L⦄ ⊢ ⓐV1.ⓛ{p}W1.T1 ⬈[h] ⓓ{p}ⓝW2.V2.T2.
#h #p #G #L #V1 #V2 #W1 #W2 #T1 #T2 * #cV #HV12 * #cW #HW12 * 
/3 width=2 by cpg_beta, ex_intro/
qed.

lemma cpx_theta: ∀h,p,G,L,V1,V,V2,W1,W2,T1,T2.
                 ⦃G, L⦄ ⊢ V1 ⬈[h] V → ⬆*[1] V ≡ V2 → ⦃G, L⦄ ⊢ W1 ⬈[h] W2 →
                 ⦃G, L.ⓓW1⦄ ⊢ T1 ⬈[h] T2 →
                 ⦃G, L⦄ ⊢ ⓐV1.ⓓ{p}W1.T1 ⬈[h] ⓓ{p}W2.ⓐV2.T2.
#h #p #G #L #V1 #V #V2 #W1 #W2 #T1 #T2 * #cV #HV1 #HV2 * #cW #HW12 * 
/3 width=4 by cpg_theta, ex_intro/
qed.

lemma cpx_refl: ∀h,G,L. reflexive … (cpx h G L).
/2 width=2 by ex_intro/ qed.

lemma cpx_pair_sn: ∀h,I,G,L,V1,V2. ⦃G, L⦄ ⊢ V1 ⬈[h] V2 →
                   ∀T. ⦃G, L⦄ ⊢ ②{I}V1.T ⬈[h] ②{I}V2.T.
#h #I #G #L #V1 #V2 *
/3 width=2 by cpg_pair_sn, ex_intro/
qed.

(* Basic inversion lemmas ***************************************************)

lemma cpx_inv_atom1: ∀h,J,G,L,T2. ⦃G, L⦄ ⊢ ⓪{J} ⬈[h] T2 →
                     ∨∨ T2 = ⓪{J}
                      | ∃∃s. T2 = ⋆(next h s) & J = Sort s
                      | ∃∃I,K,V1,V2. ⦃G, K⦄ ⊢ V1 ⬈[h] V2 & ⬆*[1] V2 ≡ T2 &
                                     L = K.ⓑ{I}V1 & J = LRef 0
                      | ∃∃I,K,V,T,i. ⦃G, K⦄ ⊢ #i ⬈[h] T & ⬆*[1] T ≡ T2 &
                                     L = K.ⓑ{I}V & J = LRef (⫯i).
#h #J #G #L #T2 * #c #H elim (cpg_inv_atom1 … H) -H *
/4 width=9 by or4_intro0, or4_intro1, or4_intro2, or4_intro3, ex4_5_intro, ex4_4_intro, ex2_intro, ex_intro/
qed-.

lemma cpx_inv_sort1: ∀h,G,L,T2,s. ⦃G, L⦄ ⊢ ⋆s ⬈[h] T2 →
                     T2 = ⋆s ∨ T2 = ⋆(next h s).
#h #G #L #T2 #s * #c #H elim (cpg_inv_sort1 … H) -H *
/2 width=1 by or_introl, or_intror/
qed-.

lemma cpx_inv_zero1: ∀h,G,L,T2. ⦃G, L⦄ ⊢ #0 ⬈[h] T2 →
                     T2 = #0 ∨
                     ∃∃I,K,V1,V2. ⦃G, K⦄ ⊢ V1 ⬈[h] V2 & ⬆*[1] V2 ≡ T2 &
                                  L = K.ⓑ{I}V1.
#h #G #L #T2 * #c #H elim (cpg_inv_zero1 … H) -H *
/4 width=7 by ex3_4_intro, ex_intro, or_introl, or_intror/
qed-.

lemma cpx_inv_lref1: ∀h,G,L,T2,i. ⦃G, L⦄ ⊢ #⫯i ⬈[h] T2 →
                     T2 = #(⫯i) ∨
                     ∃∃I,K,V,T. ⦃G, K⦄ ⊢ #i ⬈[h] T & ⬆*[1] T ≡ T2 & L = K.ⓑ{I}V.
#h #G #L #T2 #i * #c #H elim (cpg_inv_lref1 … H) -H *
/4 width=7 by ex3_4_intro, ex_intro, or_introl, or_intror/
qed-.

lemma cpx_inv_gref1: ∀h,G,L,T2,l. ⦃G, L⦄ ⊢ §l ⬈[h] T2 → T2 = §l.
#h #G #L #T2 #l * #c #H elim (cpg_inv_gref1 … H) -H //
qed-.

lemma cpx_inv_bind1: ∀h,p,I,G,L,V1,T1,U2. ⦃G, L⦄ ⊢ ⓑ{p,I}V1.T1 ⬈[h] U2 → (
                     ∃∃V2,T2. ⦃G, L⦄ ⊢ V1 ⬈[h] V2 & ⦃G, L.ⓑ{I}V1⦄ ⊢ T1 ⬈[h] T2 &
                              U2 = ⓑ{p,I}V2.T2
                     ) ∨
                     ∃∃T. ⦃G, L.ⓓV1⦄ ⊢ T1 ⬈[h] T & ⬆*[1] U2 ≡ T &
                          p = true & I = Abbr.
#h #p #I #G #L #V1 #T1 #U2 * #c #H elim (cpg_inv_bind1 … H) -H *
/4 width=5 by ex4_intro, ex3_2_intro, ex_intro, or_introl, or_intror/
qed-.

lemma cpx_inv_abbr1: ∀h,p,G,L,V1,T1,U2. ⦃G, L⦄ ⊢ ⓓ{p}V1.T1 ⬈[h] U2 → (
                     ∃∃V2,T2. ⦃G, L⦄ ⊢ V1 ⬈[h] V2 & ⦃G, L.ⓓV1⦄ ⊢ T1 ⬈[h] T2 &
                              U2 = ⓓ{p}V2.T2
                     ) ∨
                     ∃∃T. ⦃G, L.ⓓV1⦄ ⊢ T1 ⬈[h] T & ⬆*[1] U2 ≡ T & p = true.
#h #p #G #L #V1 #T1 #U2 * #c #H elim (cpg_inv_abbr1 … H) -H *
/4 width=5 by ex3_2_intro, ex3_intro, ex_intro, or_introl, or_intror/
qed-.

lemma cpx_inv_abst1: ∀h,p,G,L,V1,T1,U2. ⦃G, L⦄ ⊢ ⓛ{p}V1.T1 ⬈[h] U2 →
                     ∃∃V2,T2. ⦃G, L⦄ ⊢ V1 ⬈[h] V2 & ⦃G, L.ⓛV1⦄ ⊢ T1 ⬈[h] T2 &
                              U2 = ⓛ{p}V2.T2.
#h #p #G #L #V1 #T1 #U2 * #c #H elim (cpg_inv_abst1 … H) -H
/3 width=5 by ex3_2_intro, ex_intro/
qed-.

lemma cpx_inv_flat1: ∀h,I,G,L,V1,U1,U2. ⦃G, L⦄ ⊢ ⓕ{I}V1.U1 ⬈[h] U2 →
                     ∨∨ ∃∃V2,T2. ⦃G, L⦄ ⊢ V1 ⬈[h] V2 & ⦃G, L⦄ ⊢ U1 ⬈[h] T2 &
                                 U2 = ⓕ{I}V2.T2
                      | (⦃G, L⦄ ⊢ U1 ⬈[h] U2 ∧ I = Cast)
                      | (⦃G, L⦄ ⊢ V1 ⬈[h] U2 ∧ I = Cast)
                      | ∃∃p,V2,W1,W2,T1,T2. ⦃G, L⦄ ⊢ V1 ⬈[h] V2 & ⦃G, L⦄ ⊢ W1 ⬈[h] W2 &
                                            ⦃G, L.ⓛW1⦄ ⊢ T1 ⬈[h] T2 &
                                            U1 = ⓛ{p}W1.T1 &
                                            U2 = ⓓ{p}ⓝW2.V2.T2 & I = Appl
                      | ∃∃p,V,V2,W1,W2,T1,T2. ⦃G, L⦄ ⊢ V1 ⬈[h] V & ⬆*[1] V ≡ V2 &
                                              ⦃G, L⦄ ⊢ W1 ⬈[h] W2 & ⦃G, L.ⓓW1⦄ ⊢ T1 ⬈[h] T2 &
                                              U1 = ⓓ{p}W1.T1 &
                                              U2 = ⓓ{p}W2.ⓐV2.T2 & I = Appl.
#h #I #G #L #V1 #U1 #U2 * #c #H elim (cpg_inv_flat1 … H) -H *
/4 width=14 by or5_intro0, or5_intro1, or5_intro2, or5_intro3, or5_intro4, ex7_7_intro, ex6_6_intro, ex3_2_intro, ex_intro, conj/
qed-.

lemma cpx_inv_appl1: ∀h,G,L,V1,U1,U2. ⦃G, L⦄ ⊢ ⓐ V1.U1 ⬈[h] U2 →
                     ∨∨ ∃∃V2,T2. ⦃G, L⦄ ⊢ V1 ⬈[h] V2 & ⦃G, L⦄ ⊢ U1 ⬈[h] T2 &
                                 U2 = ⓐV2.T2
                      | ∃∃p,V2,W1,W2,T1,T2. ⦃G, L⦄ ⊢ V1 ⬈[h] V2 & ⦃G, L⦄ ⊢ W1 ⬈[h] W2 &
                                            ⦃G, L.ⓛW1⦄ ⊢ T1 ⬈[h] T2 &
                                            U1 = ⓛ{p}W1.T1 & U2 = ⓓ{p}ⓝW2.V2.T2
                      | ∃∃p,V,V2,W1,W2,T1,T2. ⦃G, L⦄ ⊢ V1 ⬈[h] V & ⬆*[1] V ≡ V2 &
                                              ⦃G, L⦄ ⊢ W1 ⬈[h] W2 & ⦃G, L.ⓓW1⦄ ⊢ T1 ⬈[h] T2 &
                                              U1 = ⓓ{p}W1.T1 & U2 = ⓓ{p}W2.ⓐV2.T2.
#h #G #L #V1 #U1 #U2 * #c #H elim (cpg_inv_appl1 … H) -H *
/4 width=13 by or3_intro0, or3_intro1, or3_intro2, ex6_7_intro, ex5_6_intro, ex3_2_intro, ex_intro/
qed-.

lemma cpx_inv_cast1: ∀h,G,L,V1,U1,U2. ⦃G, L⦄ ⊢ ⓝV1.U1 ⬈[h] U2 →
                     ∨∨ ∃∃V2,T2. ⦃G, L⦄ ⊢ V1 ⬈[h] V2 & ⦃G, L⦄ ⊢ U1 ⬈[h] T2 &
                                 U2 = ⓝV2.T2
                      | ⦃G, L⦄ ⊢ U1 ⬈[h] U2
                      | ⦃G, L⦄ ⊢ V1 ⬈[h] U2.
#h #G #L #V1 #U1 #U2 * #c #H elim (cpg_inv_cast1 … H) -H *
/4 width=5 by or3_intro0, or3_intro1, or3_intro2, ex3_2_intro, ex_intro/
qed-.

(* Basic forward lemmas *****************************************************)

lemma cpx_fwd_bind1_minus: ∀h,I,G,L,V1,T1,T. ⦃G, L⦄ ⊢ -ⓑ{I}V1.T1 ⬈[h] T → ∀p.
                           ∃∃V2,T2. ⦃G, L⦄ ⊢ ⓑ{p,I}V1.T1 ⬈[h] ⓑ{p,I}V2.T2 &
                                    T = -ⓑ{I}V2.T2.
#h #I #G #L #V1 #T1 #T * #c #H #p elim (cpg_fwd_bind1_minus … H p) -H
/3 width=4 by ex2_2_intro, ex_intro/
qed-.

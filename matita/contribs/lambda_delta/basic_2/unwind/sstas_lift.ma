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

include "basic_2/static/ssta_lift.ma".
include "basic_2/unwind/sstas.ma".

(* STRATIFIED UNWIND ON TERMS ***********************************************)

(* Advanced properties ******************************************************)

lemma sstas_total_S: ∀h,g,L,l,T,U. ⦃h, L⦄ ⊢ T•[g, l + 1]U →
                     ∃∃W. ⦃h, L⦄ ⊢ T •*[g] W & ⦃h, L⦄ ⊢ U •*[g] W.
#h #g #L #l @(nat_ind_plus … l) -l
[ #T #U #HTU
  elim (ssta_fwd_correct … HTU) /4 width=4/
| #l #IHl #T #U #HTU
  elim (ssta_fwd_correct … HTU) <minus_plus_m_m #V #HUV
  elim (IHl … HUV) -IHl -HUV /3 width=4/
]
qed-.

(* Properties on relocation *************************************************)

lemma sstas_lift: ∀h,g,L1,T1,U1. ⦃h, L1⦄ ⊢ T1 •*[g] U1 →
                  ∀L2,d,e. ⇩[d, e] L2 ≡ L1 → ∀T2. ⇧[d, e] T1 ≡ T2 →
                  ∀U2. ⇧[d, e] U1 ≡ U2 → ⦃h, L2⦄ ⊢ T2 •*[g] U2.
#h #g #L1 #T1 #U1 #H @(sstas_ind_alt … H) -T1
[ #T1 #HUT1 #L2 #d #e #HL21 #X #HX #U2 #HU12
  >(lift_mono … HX … HU12) -X
  elim (lift_total T1 d e) /3 width=10/
| #T0 #U0 #l0 #HTU0 #_ #IHU01 #L2 #d #e #HL21 #T2 #HT02 #U2 #HU12
  elim (lift_total U0 d e) /3 width=10/
]
qed.

lemma sstas_inv_lift1: ∀h,g,L2,T2,U2. ⦃h, L2⦄ ⊢ T2 •*[g] U2 →
                       ∀L1,d,e. ⇩[d, e] L2 ≡ L1 → ∀T1. ⇧[d, e] T1 ≡ T2 →
                       ∃∃U1. ⦃h, L1⦄ ⊢ T1 •*[g] U1 & ⇧[d, e] U1 ≡ U2.
#h #g #L2 #T2 #U2 #H @(sstas_ind_alt … H) -T2
[ #T2 #HUT2 #L1 #d #e #HL21 #U1 #HU12
  elim (ssta_inv_lift1 … HUT2 … HL21 … HU12) -HUT2 -HL21 /3 width=3/
| #T0 #U0 #l0 #HTU0 #_ #IHU01 #L1 #d #e #HL21 #U1 #HU12
  elim (ssta_inv_lift1 … HTU0 … HL21 … HU12) -HTU0 -HU12 #U #HU1 #HU0
  elim (IHU01 … HL21 … HU0) -IHU01 -HL21 -U0 /3 width=4/
]
qed-.

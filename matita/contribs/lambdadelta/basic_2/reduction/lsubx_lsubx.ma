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

include "basic_2/reduction/lsubx.ma".

(* LOCAL ENVIRONMENT REFINEMENT FOR EXTENDED REDUCTION **********************)

(* Auxiliary inversion lemmas ***********************************************)

fact lsubx_inv_bind1_aux: ∀L1,L2. L1 ⓝ⊑ L2 → ∀I,K1,X. L1 = K1.ⓑ{I}X →
                          ∨∨ L2 = ⋆
                           | ∃∃K2. K1 ⓝ⊑ K2 & L2 = K2.ⓑ{I}X
                           | ∃∃K2,V,W. K1 ⓝ⊑ K2 & L2 = K2.ⓛW &
                                       I = Abbr & X = ⓝW.V.
#L1 #L2 * -L1 -L2
[ #L #J #K1 #X #H destruct /2 width=1/
| #I #L1 #L2 #V #HL12 #J #K1 #X #H destruct /3 width=3/
| #L1 #L2 #V #W #HL12 #J #K1 #X #H destruct /3 width=6/
]
qed-.

lemma lsubx_inv_bind1: ∀I,K1,L2,X. K1.ⓑ{I}X ⓝ⊑ L2 →
                       ∨∨ L2 = ⋆
                        | ∃∃K2. K1 ⓝ⊑ K2 & L2 = K2.ⓑ{I}X
                        | ∃∃K2,V,W. K1 ⓝ⊑ K2 & L2 = K2.ⓛW &
                                    I = Abbr & X = ⓝW.V.
/2 width=3 by lsubx_inv_bind1_aux/ qed-.

(* Main properties **********************************************************)

theorem lsubx_trans: Transitive … lsubx.
#L1 #L #H elim H -L1 -L
[ #L1 #X #H
  lapply (lsubx_inv_atom1 … H) -H //
| #I #L1 #L #V #_ #IHL1 #X #H
  elim (lsubx_inv_bind1 … H) -H // *
  #L2 [2: #V2 #W2 ] #HL2 #H1 [ #H2 #H3 ] destruct /3 width=1/
| #L1 #L #V1 #W #_ #IHL1 #X #H
  elim (lsubx_inv_abst1 … H) -H // *
  #L2 #HL2 #H destruct /3 width=1/
]
qed-.

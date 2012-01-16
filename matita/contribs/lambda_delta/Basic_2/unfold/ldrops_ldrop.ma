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

include "Basic_2/substitution/ldrop_ldrop.ma".
include "Basic_2/unfold/ldrops.ma".

(* GENERIC LOCAL ENVIRONMENT SLICING ****************************************)

(* Properties concerning basic local environment slicing ********************)

lemma ldrops_ldrop_trans: ∀L1,L,des. ⇩*[des] L1 ≡ L → ∀L2,i. ⇩[0, i] L ≡ L2 →
                          ∃∃L0,des0,i0. ⇩[0, i0] L1 ≡ L0 & ⇩*[des0] L0 ≡ L2 &
                                        @[i] des ≡ i0 & des ▭ i ≡ des0.
#L1 #L #des #H elim H -L1 -L -des
[ /2 width=7/
| #L1 #L3 #L #des3 #d #e #_ #HL3 #IHL13 #L2 #i #HL2
  elim (lt_or_ge i d) #Hid
  [ elim (ldrop_trans_le … HL3 … HL2 ?) -L /2 width=2/ #L #HL3 #HL2
    elim (IHL13 … HL3) -L3 /3 width=7/
  | lapply (ldrop_trans_ge … HL3 … HL2 ?) -L // #HL32
    elim (IHL13 … HL32) -L3 /3 width=7/
  ]
]
qed-.

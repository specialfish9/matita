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

include "basic_2/reduction/crr.ma".
include "basic_2/reduction/cnr.ma".

(* CONTEXT-SENSITIVE NORMAL TERMS *******************************************)

(* Advanced inversion lemmas on context-sensitive reducible terms ***********)

(* Note: this property is unusual *)
lemma cnr_inv_crr: ∀L,T. ⦃G, L⦄ ⊢ 𝐑⦃T⦄ → ⦃G, L⦄ ⊢ 𝐍⦃T⦄ → ⊥.
#L #T #H elim H -L -T
[ #L #K #V #i #HLK #H
  elim (cnr_inv_delta … HLK H)
| #L #V #T #_ #IHV #H
  elim (cnr_inv_appl … H) -H /2 width=1/
| #L #V #T #_ #IHT #H
  elim (cnr_inv_appl … H) -H /2 width=1/
| #I #L #V #T * #H1 #H2 destruct
  [ elim (cnr_inv_zeta … H2)
  | elim (cnr_inv_tau … H2)
  ]
|5,6: #a * [ elim a ] #L #V #T * #H1 #_ #IH #H2 destruct
  [1,3: elim (cnr_inv_abbr … H2) -H2 /2 width=1/
  |*: elim (cnr_inv_abst … H2) -H2 /2 width=1/
  ]
| #a #L #V #W #T #H
  elim (cnr_inv_appl … H) -H #_ #_ #H
  elim (simple_inv_bind … H)
| #a #L #V #W #T #H
  elim (cnr_inv_appl … H) -H #_ #_ #H
  elim (simple_inv_bind … H)
]
qed-.

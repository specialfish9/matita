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

include "basic_2/reduction/crx.ma".
include "basic_2/reduction/cnx.ma".

(* CONTEXT-SENSITIVE EXTENDED NORMAL TERMS **********************************)

(* Advanced inversion lemmas on context-sensitive reducible terms ***********)

(* Note: this property is unusual *)
lemma cnx_inv_crx: ∀h,g,L,T. ⦃h, L⦄ ⊢ 𝐑[g]⦃T⦄ → ⦃h, L⦄ ⊢ 𝐍[g]⦃T⦄ → ⊥.
#h #g #L #T #H elim H -L -T
[ #L #k #l #Hkl #H
  lapply (cnx_inv_sort … H) -H #H
  lapply (deg_mono … H Hkl) -h -L -k <plus_n_Sm #H destruct 
| #I #L #K #V #i #HLK #H
  elim (cnx_inv_delta … HLK H)
| #L #V #T #_ #IHV #H
  elim (cnx_inv_appl … H) -H /2 width=1/
| #L #V #T #_ #IHT #H
  elim (cnx_inv_appl … H) -H /2 width=1/
| #I #L #V #T * #H1 #H2 destruct
  [ elim (cnx_inv_zeta … H2)
  | elim (cnx_inv_tau … H2)
  ]
|6,7: #a * [ elim a ] #L #V #T * #H1 #_ #IH #H2 destruct
  [1,3: elim (cnx_inv_abbr … H2) -H2 /2 width=1/
  |*: elim (cnx_inv_abst … H2) -H2 /2 width=1/
  ]
| #a #L #V #W #T #H
  elim (cnx_inv_appl … H) -H #_ #_ #H
  elim (simple_inv_bind … H)
| #a #L #V #W #T #H
  elim (cnx_inv_appl … H) -H #_ #_ #H
  elim (simple_inv_bind … H)
]
qed-.

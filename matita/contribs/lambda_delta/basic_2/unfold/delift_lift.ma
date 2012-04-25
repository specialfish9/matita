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

include "basic_2/unfold/tpss_lift.ma".
include "basic_2/unfold/delift.ma".

(* DELIFT ON TERMS **********************************************************)

(* Advanced properties ******************************************************)

lemma delift_lref_be: ∀L,K,V1,V2,U2,i,d,e. d ≤ i → i < d + e →
                      ⇩[0, i] L ≡ K. ⓓV1 → K ⊢ V1 [0, d + e - i - 1] ≡ V2 →
                      ⇧[0, d] V2 ≡ U2 → L ⊢ #i [d, e] ≡ U2.
#L #K #V1 #V2 #U2 #i #d #e #Hdi #Hide #HLK * #V #HV1 #HV2 #HVU2
elim (lift_total V 0 (i+1)) #U #HVU
lapply (lift_trans_be … HV2 … HVU ? ?) -HV2 // >minus_plus <plus_minus_m_m
/2 width=1/ /3 width=6/
qed.
 
(* Advanced forward lemmas **************************************************)

lemma delift_inv_lref1_lt: ∀L,U2,i,d,e. L ⊢ #i [d, e] ≡ U2 → i < d → U2 = #i.
#L #U2 #i #d #e * #U #HU #HU2 #Hid
elim (tpss_inv_lref1 … HU) -HU
[ #H destruct >(lift_inv_lref2_lt … HU2) //
| * #K #V1 #V2 #Hdi
  lapply (lt_to_le_to_lt … Hid Hdi) -Hid -Hdi #Hi
  elim (lt_refl_false … Hi)
]
qed-.

lemma delift_inv_lref1_be: ∀L,U2,d,e,i. L ⊢ #i [d, e] ≡ U2 →
                           d ≤ i → i < d + e →
                           ∃∃K,V1,V2. ⇩[0, i] L ≡ K. ⓓV1 &
                                      K ⊢ V1 [0, d + e - i - 1] ≡ V2 &
                                      ⇧[0, d] V2 ≡ U2.
#L #U2 #d #e #i * #U #HU #HU2 #Hdi #Hide
elim (tpss_inv_lref1 … HU) -HU
[ #H destruct elim (lift_inv_lref2_be … HU2 ? ?) //
| * #K #V1 #V #_ #_ #HLK #HV1 #HVU
  elim (lift_div_be … HVU … HU2 ? ?) -U // /2 width=1/ /3 width=6/
]
qed-.

lemma delift_inv_lref1_ge: ∀L,U2,i,d,e. L ⊢ #i [d, e] ≡ U2 →
                           d + e ≤ i → U2 = #(i - e).
#L #U2 #i #d #e * #U #HU #HU2 #Hdei
elim (tpss_inv_lref1 … HU) -HU
[ #H destruct >(lift_inv_lref2_ge … HU2) //
| * #K #V1 #V2 #_ #Hide
  lapply (lt_to_le_to_lt … Hide Hdei) -Hide -Hdei #Hi
  elim (lt_refl_false … Hi)
]
qed-.

lemma delift_inv_lref1: ∀L,U2,i,d,e. L ⊢ #i [d, e] ≡ U2 →
                        ∨∨ (i < d ∧ U2 = #i) 
                        |  (∃∃K,V1,V2. d ≤ i & i < d + e &
                                       ⇩[0, i] L ≡ K. ⓓV1 &
                                       K ⊢ V1 [0, d + e - i - 1] ≡ V2 &
                                       ⇧[0, d] V2 ≡ U2
                           )
                        |  (d + e ≤ i ∧ U2 = #(i - e)).
#L #U2 #i #d #e #H
elim (lt_or_ge i d) #Hdi
[ elim (delift_inv_lref1_lt … H Hdi) -H /3 width=1/
| elim (lt_or_ge i (d+e)) #Hide
  [ elim (delift_inv_lref1_be … H Hdi Hide) -H /3 width=6/
  | elim (delift_inv_lref1_ge … H Hide) -H /3 width=1/
  ]
]
qed-.

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
include "basic_2/unfold/ltpss_tps.ma".

(* PARALLEL UNFOLD ON LOCAL ENVIRONMENTS ************************************)

(* Properties concerning partial unfold on terms ****************************)

lemma ltpss_tpss_conf_ge: ∀L0,T2,U2,d2,e2. L0 ⊢ T2 [d2, e2] ▶* U2 →
                          ∀L1,d1,e1. L0 [d1, e1] ▶* L1 → d1 + e1 ≤ d2 →
                          L1 ⊢ T2 [d2, e2] ▶* U2.
#L0 #T2 #U2 #d2 #e2 #H #L1 #d1 #e1 #HL01 #Hde1d2 @(tpss_ind … H) -U2 //
#U #U2 #_ #HU2 #IHU
lapply (ltpss_tps_conf_ge … HU2 … HL01 ?) -L0 // -Hde1d2 /2 width=3/
qed.

(* Basic_1: was: subst1_subst1_back *)
lemma ltpss_tps_conf: ∀L0,T2,U2,d2,e2. L0 ⊢ T2 [d2, e2] ▶ U2 →
                      ∀L1,d1,e1. L0 [d1, e1] ▶* L1 →
                      ∃∃T. L1 ⊢ T2 [d2, e2] ▶ T &
                           L1 ⊢ U2 [d1, e1] ▶* T.
#L0 #T2 #U2 #d2 #e2 #H elim H -L0 -T2 -U2 -d2 -e2
[ /2 width=3/
| #L0 #K0 #V0 #W0 #i2 #d2 #e2 #Hdi2 #Hide2 #HLK0 #HVW0 #L1 #d1 #e1 #HL01
  elim (lt_or_ge i2 d1) #Hi2d1
  [ elim (ltpss_ldrop_conf_le … HL01 … HLK0 ?) -L0 /2 width=2/ #X #H #HLK1
    elim (ltpss_inv_tpss11 … H ?) -H /2 width=1/ #K1 #V1 #_ #HV01 #H destruct
    lapply (ldrop_fwd_ldrop2 … HLK1) #H
    elim (lift_total V1 0 (i2 + 1)) #W1 #HVW1
    lapply (tpss_lift_ge … HV01 … H HVW0 … HVW1) -V0 -H // >minus_plus <plus_minus_m_m // /3 width=4/
  | elim (lt_or_ge i2 (d1 + e1)) #Hde1i2
    [ elim (ltpss_ldrop_conf_be … HL01 … HLK0 ? ?) -L0 // /2 width=2/ #X #H #HLK1
      elim (ltpss_inv_tpss21 … H ?) -H /2 width=1/ #K1 #V1 #_ #HV01 #H destruct
      lapply (ldrop_fwd_ldrop2 … HLK1) #H
      elim (lift_total V1 0 (i2 + 1)) #W1 #HVW1
      lapply (tpss_lift_ge … HV01 … H HVW0 … HVW1) -V0 -H // normalize #HW01
      lapply (tpss_weak … HW01 d1 e1 ? ?) [2: /2 width=1/ |3: /3 width=4/ ] >minus_plus >commutative_plus /2 width=1/
    | lapply (ltpss_ldrop_conf_ge … HL01 … HLK0 ?) -L0 // /3 width=4/
    ]
  ]
| #L0 #I #V2 #W2 #T2 #U2 #d2 #e2 #_ #_ #IHVW2 #IHTU2 #L1 #d1 #e1 #HL01
  elim (IHVW2 … HL01) -IHVW2 #V #HV2 #HVW2
  elim (IHTU2 (L1. ⓑ{I} V) (d1 + 1) e1 ?) -IHTU2 /2 width=1/ -HL01 /3 width=5/
| #L0 #I #V2 #W2 #T2 #U2 #d2 #e2 #_ #_ #IHVW2 #IHTU2 #L1 #d1 #e1 #HL01
  elim (IHVW2 … HL01) -IHVW2
  elim (IHTU2 … HL01) -IHTU2 -HL01 /3 width=5/
]
qed.
  
lemma ltpss_tpss_trans_ge: ∀L0,T2,U2,d2,e2. L0 ⊢ T2 [d2, e2] ▶* U2 →
                           ∀L1,d1,e1. L1 [d1, e1] ▶* L0 → d1 + e1 ≤ d2 →
                           L1 ⊢ T2 [d2, e2] ▶* U2.
#L0 #T2 #U2 #d2 #e2 #H #L1 #d1 #e1 #HL01 #Hde1d2 @(tpss_ind … H) -U2 //
#U #U2 #_ #HU2 #IHU
lapply (ltpss_tps_trans_ge … HU2 … HL01 ?) -L0 // -Hde1d2 /2 width=3/
qed.

(* Basic_1: was: subst1_subst1 *)
lemma ltpss_tps_trans: ∀L0,T2,U2,d2,e2. L0 ⊢ T2 [d2, e2] ▶ U2 →
                       ∀L1,d1,e1. L1 [d1, e1] ▶* L0 →
                       ∃∃T. L1 ⊢ T2 [d2, e2] ▶ T &
                            L0 ⊢ T [d1, e1] ▶* U2.
#L0 #T2 #U2 #d2 #e2 #H elim H -L0 -T2 -U2 -d2 -e2
[ /2 width=3/
| #L0 #K0 #V0 #W0 #i2 #d2 #e2 #Hdi2 #Hide2 #HLK0 #HVW0 #L1 #d1 #e1 #HL10
  elim (lt_or_ge i2 d1) #Hi2d1
  [ elim (ltpss_ldrop_trans_le … HL10 … HLK0 ?) -HL10 /2 width=2/ #X #H #HLK1
    elim (ltpss_inv_tpss12 … H ?) -H /2 width=1/ #K1 #V1 #_ #HV01 #H destruct
    lapply (ldrop_fwd_ldrop2 … HLK0) -HLK0 #H
    elim (lift_total V1 0 (i2 + 1)) #W1 #HVW1
    lapply (tpss_lift_ge … HV01 … H HVW1 … HVW0) -V0 -H // >minus_plus <plus_minus_m_m /2 width=1/ /3 width=4/
  | elim (lt_or_ge i2 (d1 + e1)) #Hde1i2
    [ elim (ltpss_ldrop_trans_be … HL10 … HLK0 ? ?) -HL10 // /2 width=2/ #X #H #HLK1
      elim (ltpss_inv_tpss22 … H ?) -H /2 width=1/ #K1 #V1 #_ #HV01 #H destruct
      lapply (ldrop_fwd_ldrop2 … HLK0) -HLK0 #H
      elim (lift_total V1 0 (i2 + 1)) #W1 #HVW1
      lapply (tpss_lift_ge … HV01 … H HVW1 … HVW0) -V0 -H // normalize #HW01
      lapply (tpss_weak … HW01 d1 e1 ? ?) [2: /3 width=1/ |3: /3 width=4/ ] >minus_plus >commutative_plus /2 width=1/
    | lapply (ltpss_ldrop_trans_ge … HL10 … HLK0 ?) -HL10 -HLK0 // /3 width=4/
    ]
  ]
| #L0 #I #V2 #W2 #T2 #U2 #d2 #e2 #_ #_ #IHVW2 #IHTU2 #L1 #d1 #e1 #HL10
  elim (IHVW2 … HL10) -IHVW2 #V #HV2 #HVW2
  elim (IHTU2 (L1. ⓑ{I} V) (d1 + 1) e1 ?) -IHTU2 /2 width=1/ -HL10 /3 width=5/
| #L0 #I #V2 #W2 #T2 #U2 #d2 #e2 #_ #_ #IHVW2 #IHTU2 #L1 #d1 #e1 #HL10
  elim (IHVW2 … HL10) -IHVW2
  elim (IHTU2 … HL10) -IHTU2 -HL10 /3 width=5/
]
qed.

fact ltpss_tps_trans_eq_aux: ∀Y1,X2,L1,T2,U2,d,e.
                             L1 ⊢ T2 [d, e] ▶ U2 → ∀L0. L0 [d, e] ▶* L1 →
                             Y1 = L1 → X2 = T2 → L0 ⊢ T2 [d, e] ▶* U2.
#Y1 #X2 @(cw_wf_ind … Y1 X2) -Y1 -X2 #Y1 #X2 #IH
#L1 #T2 #U2 #d #e * -L1 -T2 -U2 -d -e
[ //
| #L1 #K1 #V1 #W1 #i #d #e #Hdi #Hide #HLK1 #HVW1 #L0 #HL10 #H1 #H2 destruct
  lapply (ldrop_fwd_lw … HLK1) #H1 normalize in H1;
  elim (ltpss_ldrop_trans_be … HL10 … HLK1 ? ?) -HL10 -HLK1 // /2 width=2/ #X #H #HLK0
  elim (ltpss_inv_tpss22 … H ?) -H /2 width=1/ #K0 #V0 #HK01 #HV01 #H destruct
  lapply (tpss_fwd_tw … HV01) #H2
  lapply (transitive_le (#[K1] + #[V0]) … H1) -H1 /2 width=1/ -H2 #H
  lapply (IH … HV01 … HK01 ? ?) -IH -HV01 -HK01
  [1,3: // |2,4: skip | normalize /2 width=1/ | /3 width=6/ ]
| #L #I #V1 #V2 #T1 #T2 #d #e #HV12 #HT12 #L0 #HL0 #H1 #H2 destruct
  lapply (tps_lsubs_conf … HT12 (L. ⓑ{I} V1) ?) -HT12 /2 width=1/ #HT12
  lapply (IH … HV12 … HL0 ? ?) -HV12 [1,3: // |2,4: skip |5: /2 width=2/ ] #HV12
  lapply (IH … HT12 (L0. ⓑ{I} V1) ? ? ?) -IH -HT12 [1,3,5: /2 width=2/ |2,4: skip | normalize // ] -HL0 #HT12
  lapply (tpss_lsubs_conf … HT12 (L0. ⓑ{I} V2) ?) -HT12 /2 width=1/
| #L #I #V1 #V2 #T1 #T2 #d #e #HV12 #HT12 #L0 #HL0 #H1 #H2 destruct
  lapply (IH … HV12 … HL0 ? ?) -HV12 [1,3: // |2,4: skip |5: /2 width=3/ ]
  lapply (IH … HT12 … HL0 ? ?) -IH -HT12 [1,3,5: normalize // |2,4: skip ] -HL0 /2 width=1/
]
qed.

lemma ltps_tps_trans_eq: ∀L1,T2,U2,d,e. L1 ⊢ T2 [d, e] ▶ U2 →
                         ∀L0. L0 [d, e] ▶ L1 → L0 ⊢ T2 [d, e] ▶* U2.
/2 width=5/ qed.

lemma ltps_tpss_trans_eq: ∀L0,L1,T2,U2,d,e. L0 [d, e] ▶ L1 →
                          L1 ⊢ T2 [d, e] ▶* U2 → L0 ⊢ T2 [d, e] ▶* U2.
#L0 #L1 #T2 #U2 #d #e #HL01 #H @(tpss_ind … H) -U2 //
#U #U2 #_ #HU2 #IHU @(tpss_trans_eq … IHU) /2 width=3/
qed.
*)

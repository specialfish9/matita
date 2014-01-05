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

include "basic_2/reduction/cpx_leq.ma".
include "basic_2/reduction/lpx_ldrop.ma".

(**) (* to be proved later *)
axiom- lleq_beta: ∀L2s,L2d,V2,W2,T2,d. 
                  L2s.ⓛW2 ⋕[d+1, T2] L2d.ⓛW2 →
                  L2s.ⓓⓝW2.V2 ⋕[d+1, T2] L2d.ⓓⓝW2.V2.

(* SN EXTENDED PARALLEL REDUCTION FOR LOCAL ENVIRONMENTS ********************)

(* Properties using equivalences for local environments *********************)

(* Note: lemma 1000 *)
lemma lleq_cpx_conf_leq_dx: ∀h,g,G,L1s,L1d,T1,d. L1s ⋕[d, T1] L1d → L1s ≃[d, ∞] L1d →
                            ∀T2. ⦃G, L1d⦄ ⊢ T1 ➡[h, g] T2 →
                            ∀L2s. ⦃G, L1s⦄ ⊢ ➡[h, g] L2s → L1s ≃[0, d] L2s →
                            ∀L2d. ⦃G, L1d⦄ ⊢ ➡[h, g] L2d → L1d ≃[0, d] L2d →
                            L2s ≃[d, ∞] L2d → L2s ⋕[d, T2] L2d.
#h #g #G #L1s #L1d #T1 #d #H elim H -L1s -L1d -T1 -d
[ #L1s #L1d #d #k #_ #_ #X #H2 #L2s #_ #_ #L2d #_ #_ #H3
  lapply (leq_fwd_length … H3) -H3 #HL2sd
  elim (cpx_inv_sort1 … H2) -H2 [| * #l #_ ]
  #H destruct /2 width=1 by lleq_sort/
| #Is #Id #L1s #L1d #K1s #K1d #V1s #V1d #d #i #Hid #HLK1s #HLK1d #_ #_ #_ #IHV1d #H1 #X #H2 #L2s #H1s #H2s #L2d #H1d #H2d #H3
  elim (ldrop_leq_conf_lt … H1 … HLK1s) -H1 /2 width=1 by ylt_inj/
  <yminus_SO2 >yminus_inj #Y #H1 #HY
  lapply (ldrop_mono … HY … HLK1d) -HY #H destruct
  elim (lpx_ldrop_conf … HLK1s … H1s) -H1s #Y #H #HLK2s
  elim (lpx_inv_pair1 … H) -H #K2s #V2s #H1s #HV12s #H destruct
  elim (lpx_ldrop_conf … HLK1d … H1d) -H1d #Y #H #HLK2d
  elim (lpx_inv_pair1 … H) -H #K2d #V2d #H1d #HV12d #H destruct
  elim (ldrop_leq_conf_be … H2s … HLK1s) -H2s /2 width=1 by ylt_inj/
  >yplus_O1 <yminus_SO2 >yminus_inj #Z #Y #X #HK12s #H
  lapply (ldrop_mono … H … HLK2s) -H #H destruct
  elim (ldrop_leq_conf_be … H2d … HLK1d) -H2d /2 width=1 by ylt_inj/
  >yplus_O1 <yminus_SO2 >yminus_inj #Z #Y #X #HK12d #H
  lapply (ldrop_mono … H … HLK2d) -H #H destruct
  elim (ldrop_leq_conf_lt … H3 … HLK2s) -H3 /2 width=1 by ylt_inj/
  <yminus_SO2 >yminus_inj #Y #H3 #HY
  lapply (ldrop_mono … HY … HLK2d) -HY #H destruct
  elim (cpx_inv_lref1 … H2) -H2 -L1s
  [ -L1d #H destruct /3 width=15 by lleq_skip/
  | * #Z #Y #X1 #X2 #H #HX12 #HX2 lapply (ldrop_mono … H … HLK1d) -L1d
    #H destruct >(plus_minus_m_m d (i+1)) //
    lapply (ldrop_fwd_ldrop2 … HLK2s) -HLK2s
    lapply (ldrop_fwd_ldrop2 … HLK2d) -HLK2d
    /3 width=9 by lleq_lift_ge/
  ]
| #I #L1s #L1d #K1s #K1d #V1 #d #i #Hdi #HLK1s #HLK1d #_ #IHV1 #H1 #X #H2 #L2s #H1s #H2s #L2d #H1d #H2d #H3
  elim (ldrop_leq_conf_be … H1 … HLK1s) -H1 /2 width=1 by ylt_Y, yle_inj/ #Z #Y #X #H1 #HY
  lapply (ldrop_mono … HY … HLK1d) -HY #H destruct
  elim (lpx_ldrop_conf … HLK1s … H1s) -H1s #Y #H #HLK2s
  elim (lpx_inv_pair1 … H) -H #K2s #V2s #H1s #HV12s #H destruct
  elim (lpx_ldrop_conf … HLK1d … H1d) -H1d #Y #H #HLK2d
  elim (lpx_inv_pair1 … H) -H #K2d #V2d #H1d #HV12d #H destruct
  lapply (ldrop_leq_conf_ge … H2s … HLK1s ?) /2 width=1 by yle_inj/ #H
  lapply (ldrop_mono … H … HLK2s) -H #H destruct
  lapply (ldrop_leq_conf_ge … H2d … HLK1d ?) /2 width=1 by yle_inj/ #H
  lapply (ldrop_mono … H … HLK2d) -H #H destruct
  elim (ldrop_leq_conf_be … H3 … HLK2s) -H3 /2 width=1 by ylt_Y, yle_inj/
  >yminus_Y_inj #Z #Y #X #H3 #HY
  lapply (ldrop_mono … HY … HLK2d) -HY #H destruct
  elim (cpx_inv_lref1 … H2) -H2 -L1s
  [ -L1d #H destruct /3 width=12 by lleq_lref/
  | * #Z #Y #X1 #X2 #H #HX12 #HX2 lapply (ldrop_mono … H … HLK1d) -L1d
    #H destruct
    lapply (ldrop_fwd_ldrop2 … HLK2s) -HLK2s #HLK2s
    lapply (ldrop_fwd_ldrop2 … HLK2d) -HLK2d #HLK2d
    @(lleq_ge … 0) /3 width=10 by lleq_lift_le/ (**) (* full auto too slow *)   
  ]
| #L1s #L1d #d #i #HL1s #HL1d #_ #_ #X #H2 #L2s #_ #_ #L2s #_ #H2d #H3
  lapply (leq_fwd_length … H2d) -H2d
  lapply (leq_fwd_length … H3) -H3
  elim (cpx_inv_lref1 … H2) -H2
  [ #H destruct /2 width=1 by lleq_free/
  | -L1s * #I #K1d #V1 #V2 #HLK1d
    lapply (ldrop_fwd_length_lt2 … HLK1d) -HLK1d #H
    elim (lt_refl_false … i) /2 width=3 by lt_to_le_to_lt/ (**) (* full auto too slow *)
  ]
| #L1s #L1d #d #k #_ #_ #X #H2 #L2s #_ #_ #L2d #_ #_ #H3
  lapply (leq_fwd_length … H3) -H3 #HL2sd
  lapply (cpx_inv_gref1 … H2) -H2
  #H destruct /2 width=1 by lleq_gref/
| #a #I #L1s #L1d #V1 #T1 #d #HV1 #_ #IHV1 #IHT1 #H1 #X #H2 #L2s #H1s #H2s #L2d #H1d #H2d #H3
  elim (cpx_inv_bind1 … H2) -H2 *
  [ #V2 #T2 #HV12 #HT12 #H destruct
    /5 width=5 by lpx_pair, lleq_cpx_trans_leq, lleq_bind, leq_pair, leq_succ/
  | #T2 #HT12 #HT2X #H1 #H2 destruct >(minus_plus_m_m d 1)    
    /4 width=9 by lpx_pair, lleq_inv_lift_ge, ldrop_ldrop, leq_pair, leq_succ/
  ]
| #I #L1s #L1d #V1 #T1 #d #HV1 #_ #IHV1 #IHT1 #H1 #X #H2 #L2s #H1s #H2s #L2d #H1d #H2d #H3
  elim (cpx_inv_flat1 … H2) -H2 *
  [ #V2 #T2 #HV12 #HT12 #H destruct /3 width=1 by lleq_flat/
  | #HT1X #H destruct /2 width=1 by/
  | #HV1X #H destruct /2 width=1 by/
  | #a #V2 #W1 #W2 #T0 #T2 #HV12 #HW12 #HT02 #H1 #H2 #H3 destruct 
    lapply (IHT1 … (ⓛ{a}W2.T2) … L2s … L2d ? ? ?) -IHT1 /2 width=1 by cpx_bind/ #H
    elim (lleq_inv_bind … H) -H -HW12 -HT02 #HW2 #HT2
    /4 width=1 by lleq_beta, lleq_flat, lleq_bind/
  | #a #V0 #V2 #W1 #W2 #T0 #T2 #HV10 #HV02 #HW12 #HT02 #H1 #H2 #H3 destruct 
    lapply (IHT1 … (ⓓ{a}W2.T2) … L2s … L2d ? ? ?) -IHT1 /2 width=1 by cpx_bind/ #H
    elim (lleq_inv_bind … H) -H -HW12 -HT02
    /5 width=9 by lleq_lift_ge, lleq_flat, lleq_bind, ldrop_ldrop/
  ]
]
qed-.

lemma lleq_cpx_conf_dx: ∀h,g,G,L2,T1,T2. ⦃G, L2⦄ ⊢ T1 ➡[h, g] T2 →
                        ∀L1. L1 ⋕[0, T1] L2 → L1 ⋕[0, T2] L2.
#h #g #G #L2 #T1 #T2 #HT12 #L1 #HT1 lapply (lleq_fwd_length … HT1)
/3 width=13 by lleq_cpx_conf_leq_dx, leq_O_Y/
qed-.

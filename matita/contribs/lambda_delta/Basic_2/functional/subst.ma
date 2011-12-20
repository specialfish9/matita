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

include "Basic_2/unfold/delift_lift.ma".
include "Basic_2/functional/lift.ma".

(* CORE SUBSTITUTION ********************************************************)

let rec fsubst W d U on U ≝ match U with
[ TAtom I     ⇒ match I with
  [ Sort _ ⇒ U
  | LRef i ⇒ tri … i d (#i) (↟[0, i] W) (#(i-1))
  | GRef _ ⇒ U
  ]
| TPair I V T ⇒ match I with
  [ Bind I ⇒ 𝕓{I} (fsubst W d V). (fsubst W (d+1) T)
  | Flat I ⇒ 𝕗{I} (fsubst W d V). (fsubst W d T)
  ]
].

interpretation "functional core substitution" 'Subst V d T = (fsubst V d T).

(* Main properties **********************************************************)

theorem fsubst_delift: ∀K,V,T,L,d.
                       ↓[0, d] L ≡ K. 𝕓{Abbr} V → L ⊢ T [d, 1] ≡ ↡[d ← V] T.
#K #V #T elim T -T
[ * #i #L #d #HLK normalize in ⊢ (? ? ? ? ? %); /2 width=3/
  elim (lt_or_eq_or_gt i d) #Hid
  [ -HLK >(tri_lt ?????? Hid) /3 width=3/
  | destruct >tri_eq /4 width=4 by tpss_strap, tps_subst, le_n, ex2_1_intro/ (**) (* too slow without trace *)   
  | -HLK >(tri_gt ?????? Hid) /3 width=3/
  ]
| * /3 width=1/ /4 width=1/
]
qed.

(* Main inversion properties ************************************************)

theorem fsubst_inv_delift: ∀K,V,T1,L,T2,d. ↓[0, d] L ≡ K. 𝕓{Abbr} V →
                           L ⊢ T1 [d, 1] ≡ T2 → ↡[d ← V] T1 = T2.
#K #V #T1 elim T1 -T1
[ * #i #L #T2 #d #HLK #H
  [ -HLK >(delift_fwd_sort1 … H) -H //
  | elim (lt_or_eq_or_gt i d) #Hid normalize
    [ -HLK >(delift_fwd_lref1_lt … H) -H // /2 width=1/
    | destruct
      elim (delift_fwd_lref1_be … H ? ?) -H // #K0 #V0 #V2 #HLK0
      lapply (ldrop_mono … HLK0 … HLK) -HLK0 -HLK #H >minus_plus <minus_n_n #HV2 #HVT2 destruct
      >(delift_inv_refl_O2 … HV2) -V >(flift_inv_lift … HVT2) -V2 //
    | -HLK >(delift_fwd_lref1_ge … H) -H // /2 width=1/
    ]
  | -HLK >(delift_fwd_gref1 … H) -H //
  ]
| * #I #V1 #T1 #IHV1 #IHT1 #L #X #d #HLK #H
  [ elim (delift_fwd_bind1 … H) -H #V2 #T2 #HV12 #HT12 #H destruct
    <(IHV1 … HV12) -IHV1 -HV12 // <(IHT1 … HT12) -IHT1 -HT12 // /2 width=1/
  | elim (delift_fwd_flat1 … H) -H #V2 #T2 #HV12 #HT12 #H destruct
    <(IHV1 … HV12) -IHV1 -HV12 // <(IHT1 … HT12) -IHT1 -HT12 //
  ]
]
qed-.
 
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

include "basic_2/substitution/ldrop_ldrop.ma".
include "basic_2/static/sta.ma".

(* STATIC TYPE ASSIGNMENT ON TERMS ******************************************)

(* Main properties **********************************************************)

(* Note: apparently this was missing in basic_1 *)
theorem sta_mono: ∀h,L,T,U1. ⦃h, L⦄ ⊢ T • U1 →
                  ∀U2. ⦃h, L⦄ ⊢ T • U2 → U1 = U2.
#h #L #T #U1 #H elim H -L -T -U1
[ #L #k #X #H >(sta_inv_sort1 … H) -X //
| #L #K #V #W #U1 #i #HLK #_ #HWU1 #IHVW #U2 #H
  elim (sta_inv_lref1 … H) -H * #K0 #V0 #W0 #HLK0 #HVW0 #HW0U2
  lapply (ldrop_mono … HLK0 … HLK) -HLK -HLK0 #H destruct
  lapply (IHVW … HVW0) -IHVW -HVW0 #H destruct
  >(lift_mono … HWU1 … HW0U2) -W0 -U1 //
| #L #K #W #V #U1 #i #HLK #_ #HWU1 #IHWV #U2 #H
  elim (sta_inv_lref1 … H) -H * #K0 #W0 #V0 #HLK0 #HWV0 #HV0U2
  lapply (ldrop_mono … HLK0 … HLK) -HLK -HLK0 #H destruct
  lapply (IHWV … HWV0) -IHWV -HWV0 #H destruct
  >(lift_mono … HWU1 … HV0U2) -W -U1 //
| #I #L #V #T #U1 #_ #IHTU1 #X #H
  elim (sta_inv_bind1 … H) -H #U2 #HTU2 #H destruct /3 width=1/
| #L #V #T #U1 #_ #IHTU1 #X #H
  elim (sta_inv_appl1 … H) -H #U2 #HTU2 #H destruct /3 width=1/
| #L #W #T #U1 #_ #IHTU1 #U2 #H
  lapply (sta_inv_cast1 … H) -H /2 width=1/
]
qed-.

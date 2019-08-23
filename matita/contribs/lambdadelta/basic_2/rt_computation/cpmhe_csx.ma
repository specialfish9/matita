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

include "basic_2/rt_transition/cpm_cpx.ma".
include "basic_2/rt_transition/cnh_tdeq.ma".
include "basic_2/rt_computation/csx.ma".
include "basic_2/rt_computation/cpmhe.ma".

(* HEAD T-UNBOUND EVALUATION FOR T-BOUND RT-TRANSITION ON TERMS *************)

(* Properties with strong normalization for unbound rt-transition for terms *)

lemma cpmhe_total_csx (h) (G) (L):
      ∀T1. ⦃G,L⦄ ⊢ ⬈*[h] 𝐒⦃T1⦄ → ∃∃T2,n. ⦃G,L⦄ ⊢ T1 ➡*[h,n] 𝐍*⦃T2⦄.
#h #G #L #T1 #H
@(csx_ind … H) -T1 #T1 #_ #IHT1
elim (cnh_dec_tdeq h G L T1)
[ -IHT1 #HT1 /3 width=4 by cpmhe_intro, ex1_2_intro/
| * #n1 #T0 #HT10 #HnT10
  elim (IHT1 … HnT10) -IHT1 -HnT10 [| /2 width=2 by cpm_fwd_cpx/ ]
  #T2 #n2 * #HT02 #HT2 /4 width=5 by cpms_step_sn, cpmhe_intro, ex1_2_intro/
]
qed-.

lemma R_cpmhe_total_csx (h) (G) (L):
      ∀T1. ⦃G,L⦄ ⊢ ⬈*[h] 𝐒⦃T1⦄ → ∃n. R_cpmhe h G L T1 n.
#h #G #L #T1 #H
elim (cpmhe_total_csx … H) -H #T2 #n #HT12
/3 width=3 by ex_intro (* 2x *)/
qed-.

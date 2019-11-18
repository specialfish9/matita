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

include "basic_2/rt_computation/cpxs_teqx.ma".
include "basic_2/rt_computation/cpxs_cpxs.ma".
include "basic_2/rt_computation/csx_csx.ma".

(* UNBOUND CONTEXT-SENSITIVE PARALLEL RT-COMPUTATION FOR TERMS **************)

(* Properties with unbound context-sensitive rt-computation for terms *******)

(* Basic_1: was just: sn3_intro *)
lemma csx_intro_cpxs: ∀h,G,L,T1.
                      (∀T2. ⦃G,L⦄ ⊢ T1 ⬈*[h] T2 → (T1 ≛ T2 → ⊥) → ⦃G,L⦄ ⊢ ⬈*[h] 𝐒⦃T2⦄) →
                      ⦃G,L⦄ ⊢ ⬈*[h] 𝐒⦃T1⦄.
/4 width=1 by cpx_cpxs, csx_intro/ qed-.

(* Basic_1: was just: sn3_pr3_trans *)
lemma csx_cpxs_trans: ∀h,G,L,T1. ⦃G,L⦄ ⊢ ⬈*[h] 𝐒⦃T1⦄ →
                      ∀T2. ⦃G,L⦄ ⊢ T1 ⬈*[h] T2 → ⦃G,L⦄ ⊢ ⬈*[h] 𝐒⦃T2⦄.
#h #G #L #T1 #HT1 #T2 #H @(cpxs_ind … H) -T2
/2 width=3 by csx_cpx_trans/
qed-.

(* Eliminators with unbound context-sensitive rt-computation for terms ******)

lemma csx_ind_cpxs_teqx: ∀h,G,L. ∀Q:predicate term.
                         (∀T1. ⦃G,L⦄ ⊢ ⬈*[h] 𝐒⦃T1⦄ →
                               (∀T2. ⦃G,L⦄ ⊢ T1 ⬈*[h] T2 → (T1 ≛ T2 → ⊥) → Q T2) → Q T1
                         ) →
                         ∀T1. ⦃G,L⦄ ⊢ ⬈*[h] 𝐒⦃T1⦄ →
                         ∀T0. ⦃G,L⦄ ⊢ T1 ⬈*[h] T0 → ∀T2. T0 ≛ T2 → Q T2.
#h #G #L #Q #IH #T1 #H @(csx_ind … H) -T1
#T1 #HT1 #IH1 #T0 #HT10 #T2 #HT02
@IH -IH /3 width=3 by csx_cpxs_trans, csx_teqx_trans/ -HT1 #V2 #HTV2 #HnTV2
lapply (teqx_tneqx_trans … HT02 … HnTV2) -HnTV2 #H
elim (teqx_cpxs_trans … HT02 … HTV2) -T2 #V0 #HTV0 #HV02
lapply (tneqx_teqx_canc_dx … H … HV02) -H #HnTV0
elim (teqx_dec T1 T0) #H
[ lapply (teqx_tneqx_trans … H … HnTV0) -H -HnTV0 #Hn10
  lapply (cpxs_trans … HT10 … HTV0) -T0 #H10
  elim (cpxs_tneqx_fwd_step_sn … H10 …  Hn10) -H10 -Hn10
  /3 width=8 by teqx_trans/
| elim (cpxs_tneqx_fwd_step_sn … HT10 … H) -HT10 -H #T #V #HT1 #HnT1 #HTV #HVT0
  elim (teqx_cpxs_trans … HVT0 … HTV0) -T0
  /3 width=8 by cpxs_trans, teqx_trans/
]
qed-.

(* Basic_2A1: was: csx_ind_alt *)
lemma csx_ind_cpxs: ∀h,G,L. ∀Q:predicate term.
                    (∀T1. ⦃G,L⦄ ⊢ ⬈*[h] 𝐒⦃T1⦄ →
                          (∀T2. ⦃G,L⦄ ⊢ T1 ⬈*[h] T2 → (T1 ≛ T2 → ⊥) → Q T2) → Q T1
                    ) →
                    ∀T. ⦃G,L⦄ ⊢ ⬈*[h] 𝐒⦃T⦄ →  Q T.
#h #G #L #Q #IH #T #HT
@(csx_ind_cpxs_teqx … IH … HT) -IH -HT // (**) (* full auto fails *)
qed-.

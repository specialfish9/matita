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

include "basic_2/rt_transition/lfpx_aaa.ma".
include "basic_2/rt_computation/cpxs.ma".

(* UNCOUNTED CONTEXT-SENSITIVE PARALLEL RT-COMPUTATION FOR TERMS ************)

(* Properties with atomic arity assignment on terms *************************)

lemma cpxs_aaa_conf: ∀h,G,L,T1,A. ⦃G, L⦄ ⊢ T1 ⁝ A →
                     ∀T2. ⦃G, L⦄ ⊢ T1 ⬈*[h] T2 → ⦃G, L⦄ ⊢ T2 ⁝ A.
#h #G #L #T1 #A #HT1 #T2 #HT12
@(TC_Conf3 … HT1 ? HT12) -A -T1 -T2 /2 width=5 by cpx_aaa_conf/
qed-.

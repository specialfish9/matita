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

include "basic_2/grammar/ceq.ma".

(* CONTEXT-SENSITIVE EQUIVALENCES FOR TERMS *********************************)

(* Main properties **********************************************************)

theorem ceq_trans (L): Transitive … (ceq L).
// qed-.

lemma ceq_canc_sn (L): left_cancellable … (ceq L).
// qed-.

lemma ceq_canc_dx (L): right_cancellable … (ceq L).
// qed-.

theorem cfull_trans (L): Transitive … (cfull L).
// qed-.

lemma cfull_canc_sn (L): left_cancellable … (cfull L).
// qed-.

lemma cfull_canc_dx (L): right_cancellable … (cfull L).
// qed-.
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

include "Basic-2/grammar/term_weight.ma".
include "Basic-2/grammar/lenv.ma".

(* WEIGHTS ******************************************************************)

(* the weight of a local environment *)
let rec lw L ≝ match L with
[ LSort       ⇒ 0
| LPair L _ V ⇒ lw L + #V
].

interpretation "weight (local environment)" 'Weight L = (lw L).

(* the weight of a closure *)
definition cw: lenv → term → ? ≝ λL,T. #L + #T.

interpretation "weight (closure)" 'Weight L T = (cw L T).

axiom cw_wf_ind: ∀P:lenv→term→Prop.
                 (∀L2,T2. (∀L1,T1. #[L1,T1] < #[L2,T2] → P L1 T1) → P L2 T2) →
                 ∀L,T. P L T.

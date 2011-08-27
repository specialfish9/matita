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

(* WEIGHT OF A LOCAL ENVIRONMENT ********************************************)

let rec lw L ≝ match L with
[ LSort       ⇒ 0
| LPair L _ V ⇒ lw L + #[V]
].

interpretation "weight (local environment)" 'Weight L = (lw L).

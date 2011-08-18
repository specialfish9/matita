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

include "Basic-2/grammar/lenv.ma".

(* LENGTH *******************************************************************)

(* the length of a local environment *)
let rec length L ≝ match L with
[ LSort       ⇒ 0
| LPair L _ _ ⇒ length L + 1
].

interpretation "length (local environment)" 'card L = (length L).

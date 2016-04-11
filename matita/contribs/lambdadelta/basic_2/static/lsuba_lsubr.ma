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

include "basic_2/static/lsubr.ma".
include "basic_2/static/lsuba.ma".

(* RESTRICTED REFINEMENT FOR ATOMIC ARITY ASSIGNMENT ************************)

(* Forward lemmas with restricted refinement for local environments *********)

lemma lsuba_fwd_lsubr: ∀G,L1,L2. G ⊢ L1 ⫃⁝ L2 → L1 ⫃ L2.
#G #L1 #L2 #H elim H -L1 -L2 /2 width=1 by lsubr_pair, lsubr_beta/
qed-.

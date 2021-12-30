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

include "ground/relocation/pr_tl_eq.ma".
include "ground/relocation/pr_tls.ma".

(* ITERATED TAIL FOR PARTIAL RELOCATION MAPS ********************************)

(* Constructions with pr_eq *************************************************)

(*** tls_eq_repl *)
lemma pr_tls_eq_repl (n):
      pr_eq_repl (λf1,f2. ⫰*[n] f1 ≐ ⫰*[n] f2).
#n @(nat_ind_succ … n) -n /3 width=1 by pr_tl_eq_repl/
qed.

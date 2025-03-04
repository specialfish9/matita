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

include "delayed_updating/reduction/dbfr.ma".

include "delayed_updating/substitution/fsubst_lift.ma".
include "delayed_updating/substitution/fsubst_eq.ma".
include "delayed_updating/substitution/lift_prototerm_constructors.ma".
include "delayed_updating/substitution/lift_path_structure.ma".
include "delayed_updating/substitution/lift_path_closed.ma".
include "delayed_updating/substitution/lift_rmap_closed.ma".

(* DELAYED BALANCED FOCUSED REDUCTION ***************************************)

(* Constructions with lift **************************************************)

theorem dbfr_lift_bi (f) (t1) (t2) (r):
        t1 ➡𝐝𝐛𝐟[r] t2 → 🠡[f]t1 ➡𝐝𝐛𝐟[🠡[f]r] 🠡[f]t2.
#f #t1 #t2 #r
* #p #b #q #m #n #Hr #Hb #Hm #Hn #Ht1 #Ht2 destruct
@(ex6_5_intro … (🠡[f]p) (🠡[🠢[f](p◖𝗔)]b) (🠡[🠢[f](p◖𝗔●b◖𝗟)]q) (🠢[f](p●𝗔◗b)＠❨m❩) (🠢[f](p●𝗔◗b●𝗟◗q)＠§❨n❩))
[ -Hb -Hm -Hn -Ht1 -Ht2 //
| -Hm -Hn -Ht1 -Ht2 //
| -Hb -Hn -Ht1 -Ht2
  /2 width=1 by lift_path_closed/
| -Hb -Hm -Ht1 -Ht2
  /2 width=1 by lift_path_rmap_closed_L/
| lapply (in_comp_lift_path_term f … Ht1) -Ht2 -Ht1 -Hn
  <lift_path_d_dx #Ht1 //
| lapply (lift_term_eq_repl_dx f … Ht2) -Ht2 #Ht2 -Ht1
  @(subset_eq_trans … Ht2) -t2
  @(subset_eq_trans … (lift_term_fsubst …))
  @fsubst_eq_repl [ // | // ]
  @(subset_eq_trans … (lift_term_iref_nap …))
  <list_append_rcons_sn <list_append_rcons_sn >list_append_assoc
  >(nap_plus_lift_rmap_append_closed_Lq_dx … Hn)
  @iref_eq_repl
  @(subset_eq_canc_sn … (lift_term_grafted_S …))
  @lift_term_eq_repl_sn
(* 🠢[f]p ≗ ⇂*[↑(m+n)]🠢[f](((p◖𝗔)●b)●𝗟◗q) *)
(* Note: crux of the proof begins *)
  >lift_rmap_A_dx
  /2 width=2 by tls_succ_plus_lift_rmap_append_closed_bLq_dx/
(* Note: crux of the proof ends *)
]
qed.

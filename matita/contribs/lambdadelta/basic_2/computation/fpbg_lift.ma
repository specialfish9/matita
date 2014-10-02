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

include "basic_2/reduction/fpbu_lift.ma".
include "basic_2/computation/fpbg.ma".

(* "QRST" PARALLEL COMPUTATION FOR CLOSURES *********************************)

(* Advanced properties ******************************************************)

lemma sta_fpbg: ∀h,g,G,L,T1,T2,l. ⦃G, L⦄ ⊢ T1 ▪[h, g] l+1 →
                ⦃G, L⦄ ⊢ T1 •*[h, 1] T2 → ⦃G, L, T1⦄ >≡[h, g] ⦃G, L, T2⦄.
/4 width=2 by fpbu_fpbg, sta_fpbu/ qed.

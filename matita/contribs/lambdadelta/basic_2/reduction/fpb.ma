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

include "basic_2/notation/relations/btpred_8.ma".
include "basic_2/relocation/fquq.ma".
include "basic_2/reduction/llpx.ma".

(* "BIG TREE" PARALLEL REDUCTION FOR CLOSURES *******************************)

inductive fpb (h) (g) (G1) (L1) (T1): relation3 genv lenv term ≝
| fpb_fquq: ∀G2,L2,T2. ⦃G1, L1, T1⦄ ⊃⸮ ⦃G2, L2, T2⦄ → fpb h g G1 L1 T1 G2 L2 T2
| fpb_cpx : ∀T2. ⦃G1, L1⦄ ⊢ T1 ➡[h, g] T2 → fpb h g G1 L1 T1 G1 L1 T2
| fpb_llpx: ∀L2. ⦃G1, L1⦄ ⊢ ➡[h, g, T1, 0] L2 → fpb h g G1 L1 T1 G1 L2 T1
.

interpretation
   "'big tree' parallel reduction (closure)"
   'BTPRed h g G1 L1 T1 G2 L2 T2 = (fpb h g G1 L1 T1 G2 L2 T2).

(* Basic properties *********************************************************)

lemma fpb_refl: ∀h,g. tri_reflexive … (fpb h g).
/2 width=1 by fpb_cpx/ qed.

lemma cpr_fpb: ∀h,g,G,L,T1,T2. ⦃G, L⦄ ⊢ T1 ➡ T2 → ⦃G, L, T1⦄ ≽[h, g] ⦃G, L, T2⦄. 
/3 width=1 by fpb_cpx, cpr_cpx/ qed.
(*
lamma llpr_fpb: ∀h,g,G,L1,L2,T. ⦃G, L1⦄ ⊢ ➡[T, 0] L2 → ⦃G, L1, T⦄ ≽[h, g] ⦃G, L2, T⦄.
/3 width=1 by fpb_llpx, llpr_llpx/ qed.
*)

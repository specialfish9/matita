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

include "basic_2/static/rdeq_length.ma".
include "basic_2/rt_transition/lpx_length.ma".
include "basic_2/rt_computation/rdsx.ma".

(* STRONGLY NORMALIZING REFERRED LOCAL ENV.S FOR UNBOUND RT-TRANSITION ******)

(* Advanced properties ******************************************************)

(* Basic_2A1: uses: lsx_sort *)
lemma rdsx_sort (h) (o) (G): ∀L,s. G ⊢ ⬈*[h, o, ⋆s] 𝐒⦃L⦄.
#h #o #G #L1 #s @rdsx_intro #L2 #H #Hs
elim Hs -Hs /3 width=3 by lpx_fwd_length, rdeq_sort_length/
qed.

(* Basic_2A1: uses: lsx_gref *)
lemma rdsx_gref (h) (o) (G): ∀L,l. G ⊢ ⬈*[h, o, §l] 𝐒⦃L⦄.
#h #o #G #L1 #s @rdsx_intro #L2 #H #Hs
elim Hs -Hs /3 width=3 by lpx_fwd_length, rdeq_gref_length/
qed.

lemma rdsx_unit (h) (o) (G): ∀I,L. G ⊢ ⬈*[h, o, #0] 𝐒⦃L.ⓤ{I}⦄.
#h #o #G #I #L1 @rdsx_intro
#Y #HY #HnY elim HnY -HnY
elim (lpx_inv_unit_sn … HY) -HY #L2 #HL12 #H destruct
/3 width=3 by lpx_fwd_length, rdeq_unit_length/
qed.

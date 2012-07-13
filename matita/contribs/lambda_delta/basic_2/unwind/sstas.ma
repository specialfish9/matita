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

include "basic_2/static/ssta.ma".

(* STRATIFIED UNWIND ON TERMS ***********************************************)

inductive sstas (h:sh) (g:sd h) (L:lenv): relation term ≝
| sstas_refl: ∀T,U. ⦃h, L⦄ ⊢ T •[g, 0] U → sstas h g L T T
| sstas_step: ∀T,U1,U2,l. ⦃h, L⦄ ⊢ T •[g, l+1] U1 → sstas h g L U1 U2 →
              sstas h g L T U2.

interpretation "stratified unwind (term)"
   'StaticTypeStar h g L T U = (sstas h g L T U).

(* Basic eliminators ********************************************************)

fact sstas_ind_alt_aux: ∀h,g,L,U2. ∀R:predicate term.
                        (∀T. ⦃h, L⦄ ⊢ U2 •[g , 0] T → R U2) →
                        (∀T,U1,l. ⦃h, L⦄ ⊢ T •[g, l + 1] U1 →
                                  ⦃h, L⦄ ⊢ U1 •* [g] U2 → R U1 → R T
                        ) →
                        ∀T,U. ⦃h, L⦄ ⊢ T •*[g] U → U = U2 → R T.
#h #g #L #U2 #R #H1 #H2 #T #U #H elim H -H -T -U /2 width=2/ /3 width=5/
qed-.

lemma sstas_ind_alt: ∀h,g,L,U2. ∀R:predicate term.
                     (∀T. ⦃h, L⦄ ⊢ U2 •[g , 0] T → R U2) →
                     (∀T,U1,l. ⦃h, L⦄ ⊢ T •[g, l + 1] U1 →
                               ⦃h, L⦄ ⊢ U1 •* [g] U2 → R U1 → R T
                     ) →
                     ∀T. ⦃h, L⦄ ⊢ T •*[g] U2 → R T.
/3 width=9 by sstas_ind_alt_aux/ qed-.
                         
(* Basic inversion lemmas ***************************************************)

fact sstas_inv_sort1_aux: ∀h,g,L,T,U. ⦃h, L⦄ ⊢ T •*[g] U → ∀k. T = ⋆k →
                          ∀l. deg h g k l → U = ⋆((next h)^l k).
#h #g #L #T #U #H @(sstas_ind_alt … H) -T
[ #U0 #HU0 #k #H #l #Hkl destruct
  elim (ssta_inv_sort1 … HU0) -L #HkO #_ -U0
  >(deg_mono … Hkl HkO) -g -l //
| #T0 #U0 #l0 #HTU0 #_ #IHU0 #k #H #l #Hkl destruct
  elim (ssta_inv_sort1 … HTU0) -L #HkS #H destruct
  lapply (deg_mono … Hkl HkS) -Hkl #H destruct
  >(IHU0 (next h k) ? l0) -IHU0 // /2 width=1/ >iter_SO >iter_n_Sm //
]
qed.

lemma sstas_inv_sort1: ∀h,g,L,U,k. ⦃h, L⦄ ⊢ ⋆k •*[g] U → ∀l. deg h g k l →
                       U = ⋆((next h)^l k).
/2 width=6/ qed-.

fact sstas_inv_bind1_aux: ∀h,g,L,T,U. ⦃h, L⦄ ⊢ T •*[g] U →
                          ∀J,X,Y. T = ⓑ{J}Y.X →
                          ∃∃Z. ⦃h, L.ⓑ{J}Y⦄ ⊢ X •*[g] Z & U = ⓑ{J}Y.Z.
#h #g #L #T #U #H @(sstas_ind_alt … H) -T
[ #U0 #HU0 #J #X #Y #H destruct
  elim (ssta_inv_bind1 … HU0) -HU0 #X0 #HX0 #H destruct /3 width=3/
| #T0 #U0 #l #HTU0 #_ #IHU0 #J #X #Y #H destruct
  elim (ssta_inv_bind1 … HTU0) -HTU0 #X0 #HX0 #H destruct
  elim (IHU0 J X0 Y ?) -IHU0 // #X1 #HX01 #H destruct /3 width=4/
]
qed.

lemma sstas_inv_bind1: ∀h,g,J,L,Y,X,U. ⦃h, L⦄ ⊢ ⓑ{J}Y.X •*[g] U →
                       ∃∃Z. ⦃h, L.ⓑ{J}Y⦄ ⊢ X •*[g] Z & U = ⓑ{J}Y.Z.
/2 width=3/ qed-.

fact sstas_inv_appl1_aux: ∀h,g,L,T,U. ⦃h, L⦄ ⊢ T •*[g] U → ∀X,Y. T = ⓐY.X →
                          ∃∃Z. ⦃h, L⦄ ⊢ X •*[g] Z & U = ⓐY.Z.
#h #g #L #T #U #H @(sstas_ind_alt … H) -T
[ #U0 #HU0 #X #Y #H destruct
  elim (ssta_inv_appl1 … HU0) -HU0 #X0 #HX0 #H destruct /3 width=3/
| #T0 #U0 #l #HTU0 #_ #IHU0 #X #Y #H destruct
  elim (ssta_inv_appl1 … HTU0) -HTU0 #X0 #HX0 #H destruct
  elim (IHU0 X0 Y ?) -IHU0 // #X1 #HX01 #H destruct /3 width=4/
]
qed.

lemma sstas_inv_appl1: ∀h,g,L,Y,X,U. ⦃h, L⦄ ⊢ ⓐY.X •*[g] U →
                       ∃∃Z. ⦃h, L⦄ ⊢ X •*[g] Z & U = ⓐY.Z.
/2 width=3/ qed-.

(* Basic forward lemmas *****************************************************)

lemma sstas_fwd_correct: ∀h,g,L,T,U. ⦃h, L⦄ ⊢ T •*[g] U →
                         ∃∃W. ⦃h, L⦄ ⊢ U •[g, 0] W & ⦃h, L⦄ ⊢ U •*[g] U.
#h #g #L #T #U #H @(sstas_ind_alt … H) -T /2 width=1/ /3 width=2/
qed-.

(* Basic_1: removed theorems 7:
            sty1_bind sty1_abbr sty1_appl sty1_cast2
	    sty1_lift sty1_correct sty1_trans
*)

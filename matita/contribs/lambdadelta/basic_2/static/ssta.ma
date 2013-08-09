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

include "basic_2/notation/relations/statictype_7.ma".
include "basic_2/grammar/genv.ma".
include "basic_2/relocation/ldrop.ma".
include "basic_2/static/sd.ma".

(* STRATIFIED STATIC TYPE ASSIGNMENT ON TERMS *******************************)

(* activate genv *)
inductive ssta (h:sh) (g:sd h): nat → relation4 genv lenv term term ≝
| ssta_sort: ∀G,L,k,l. deg h g k l → ssta h g l G L (⋆k) (⋆(next h k))
| ssta_ldef: ∀G,L,K,V,W,U,i,l. ⇩[0, i] L ≡ K. ⓓV → ssta h g l G K V W →
             ⇧[0, i + 1] W ≡ U → ssta h g l G L (#i) U
| ssta_ldec: ∀G,L,K,W,V,U,i,l. ⇩[0, i] L ≡ K. ⓛW → ssta h g l G K W V →
             ⇧[0, i + 1] W ≡ U → ssta h g (l+1) G L (#i) U
| ssta_bind: ∀a,I,G,L,V,T,U,l. ssta h g l G (L. ⓑ{I} V) T U →
             ssta h g l G L (ⓑ{a,I}V.T) (ⓑ{a,I}V.U)
| ssta_appl: ∀G,L,V,T,U,l. ssta h g l G L T U →
             ssta h g l G L (ⓐV.T) (ⓐV.U)
| ssta_cast: ∀G,L,W,T,U,l. ssta h g l G L T U → ssta h g l G L (ⓝW.T) U
.

interpretation "stratified static type assignment (term)"
   'StaticType h g G L T U l = (ssta h g l G L T U).

definition ssta_step: ∀h. sd h → relation4 genv lenv term term ≝
                      λh,g,G,L,T,U. ∃l. ⦃G, L⦄ ⊢ T •[h, g] ⦃l+1, U⦄.

(* Basic inversion lemmas ************************************************)

fact ssta_inv_sort1_aux: ∀h,g,G,L,T,U,l. ⦃G, L⦄ ⊢ T •[h, g] ⦃l, U⦄ → ∀k0. T = ⋆k0 →
                         deg h g k0 l ∧ U = ⋆(next h k0).
#h #g #G #L #T #U #l * -G -L -T -U -l
[ #G #L #k #l #Hkl #k0 #H destruct /2 width=1/
| #G #L #K #V #W #U #i #l #_ #_ #_ #k0 #H destruct
| #G #L #K #W #V #U #i #l #_ #_ #_ #k0 #H destruct
| #a #I #G #L #V #T #U #l #_ #k0 #H destruct
| #G #L #V #T #U #l #_ #k0 #H destruct
| #G #L #W #T #U #l #_ #k0 #H destruct
qed-.

(* Basic_1: was just: sty0_gen_sort *)
lemma ssta_inv_sort1: ∀h,g,G,L,U,k,l. ⦃G, L⦄ ⊢ ⋆k •[h, g] ⦃l, U⦄ →
                      deg h g k l ∧ U = ⋆(next h k).
/2 width=5 by ssta_inv_sort1_aux/ qed-.

fact ssta_inv_lref1_aux: ∀h,g,G,L,T,U,l. ⦃G, L⦄ ⊢ T •[h, g] ⦃l, U⦄ → ∀j. T = #j →
                         (∃∃K,V,W. ⇩[0, j] L ≡ K. ⓓV & ⦃G, K⦄ ⊢ V •[h, g] ⦃l, W⦄ &
                                   ⇧[0, j + 1] W ≡ U
                         ) ∨
                         (∃∃K,W,V,l0. ⇩[0, j] L ≡ K. ⓛW & ⦃G, K⦄ ⊢ W •[h, g] ⦃l0, V⦄ &
                                      ⇧[0, j + 1] W ≡ U & l = l0 + 1
                         ).
#h #g #G #L #T #U #l * -G -L -T -U -l
[ #G #L #k #l #_ #j #H destruct
| #G #L #K #V #W #U #i #l #HLK #HVW #HWU #j #H destruct /3 width=6/
| #G #L #K #W #V #U #i #l #HLK #HWV #HWU #j #H destruct /3 width=8/
| #a #I #G #L #V #T #U #l #_ #j #H destruct
| #G #L #V #T #U #l #_ #j #H destruct
| #G #L #W #T #U #l #_ #j #H destruct
]
qed-.

(* Basic_1: was just: sty0_gen_lref *)
lemma ssta_inv_lref1: ∀h,g,G,L,U,i,l. ⦃G, L⦄ ⊢ #i •[h, g] ⦃l, U⦄ →
                      (∃∃K,V,W. ⇩[0, i] L ≡ K. ⓓV & ⦃G, K⦄ ⊢ V •[h, g] ⦃l, W⦄ &
                                ⇧[0, i + 1] W ≡ U
                      ) ∨
                      (∃∃K,W,V,l0. ⇩[0, i] L ≡ K. ⓛW & ⦃G, K⦄ ⊢ W •[h, g] ⦃l0, V⦄ &
                                   ⇧[0, i + 1] W ≡ U & l = l0 + 1
                      ).
/2 width=3 by ssta_inv_lref1_aux/ qed-.

fact ssta_inv_gref1_aux: ∀h,g,G,L,T,U,l. ⦃G, L⦄ ⊢ T •[h, g] ⦃l, U⦄ → ∀p0. T = §p0 → ⊥.
#h #g #G #L #T #U #l * -G -L -T -U -l
[ #G #L #k #l #_ #p0 #H destruct
| #G #L #K #V #W #U #i #l #_ #_ #_ #p0 #H destruct
| #G #L #K #W #V #U #i #l #_ #_ #_ #p0 #H destruct
| #a #I #G #L #V #T #U #l #_ #p0 #H destruct
| #G #L #V #T #U #l #_ #p0 #H destruct
| #G #L #W #T #U #l #_ #p0 #H destruct
qed-.

lemma ssta_inv_gref1: ∀h,g,G,L,U,p,l. ⦃G, L⦄ ⊢ §p •[h, g] ⦃l, U⦄ → ⊥.
/2 width=10 by ssta_inv_gref1_aux/ qed-.

fact ssta_inv_bind1_aux: ∀h,g,G,L,T,U,l. ⦃G, L⦄ ⊢ T •[h, g] ⦃l, U⦄ →
                         ∀a,I,X,Y. T = ⓑ{a,I}Y.X →
                         ∃∃Z. ⦃G, L.ⓑ{I}Y⦄ ⊢ X •[h, g] ⦃l, Z⦄ & U = ⓑ{a,I}Y.Z.
#h #g #G #L #T #U #l * -G -L -T -U -l
[ #G #L #k #l #_ #a #I #X #Y #H destruct
| #G #L #K #V #W #U #i #l #_ #_ #_ #a #I #X #Y #H destruct
| #G #L #K #W #V #U #i #l #_ #_ #_ #a #I #X #Y #H destruct
| #b #J #G #L #V #T #U #l #HTU #a #I #X #Y #H destruct /2 width=3/
| #G #L #V #T #U #l #_ #a #I #X #Y #H destruct
| #G #L #W #T #U #l #_ #a #I #X #Y #H destruct
]
qed-.

(* Basic_1: was just: sty0_gen_bind *)
lemma ssta_inv_bind1: ∀h,g,a,I,G,L,Y,X,U,l. ⦃G, L⦄ ⊢ ⓑ{a,I}Y.X •[h, g] ⦃l, U⦄ →
                      ∃∃Z. ⦃G, L.ⓑ{I}Y⦄ ⊢ X •[h, g] ⦃l, Z⦄ & U = ⓑ{a,I}Y.Z.
/2 width=3 by ssta_inv_bind1_aux/ qed-.

fact ssta_inv_appl1_aux: ∀h,g,G,L,T,U,l. ⦃G, L⦄ ⊢ T •[h, g] ⦃l, U⦄ → ∀X,Y. T = ⓐY.X →
                         ∃∃Z. ⦃G, L⦄ ⊢ X •[h, g] ⦃l, Z⦄ & U = ⓐY.Z.
#h #g #G #L #T #U #l * -G -L -T -U -l
[ #G #L #k #l #_ #X #Y #H destruct
| #G #L #K #V #W #U #i #l #_ #_ #_ #X #Y #H destruct
| #G #L #K #W #V #U #i #l #_ #_ #_ #X #Y #H destruct
| #a #I #G #L #V #T #U #l #_ #X #Y #H destruct
| #G #L #V #T #U #l #HTU #X #Y #H destruct /2 width=3/
| #G #L #W #T #U #l #_ #X #Y #H destruct
]
qed-.

(* Basic_1: was just: sty0_gen_appl *)
lemma ssta_inv_appl1: ∀h,g,G,L,Y,X,U,l. ⦃G, L⦄ ⊢ ⓐY.X •[h, g] ⦃l, U⦄ →
                      ∃∃Z. ⦃G, L⦄ ⊢ X •[h, g] ⦃l, Z⦄ & U = ⓐY.Z.
/2 width=3 by ssta_inv_appl1_aux/ qed-.

fact ssta_inv_cast1_aux: ∀h,g,G,L,T,U,l. ⦃G, L⦄ ⊢ T •[h, g] ⦃l, U⦄ →
                         ∀X,Y. T = ⓝY.X → ⦃G, L⦄ ⊢ X •[h, g] ⦃l, U⦄.
#h #g #G #L #T #U #l * -G -L -T -U -l
[ #G #L #k #l #_ #X #Y #H destruct
| #G #L #K #V #W #U #l #i #_ #_ #_ #X #Y #H destruct
| #G #L #K #W #V #U #l #i #_ #_ #_ #X #Y #H destruct
| #a #I #G #L #V #T #U #l #_ #X #Y #H destruct
| #G #L #V #T #U #l #_ #X #Y #H destruct
| #G #L #W #T #U #l #HTU #X #Y #H destruct //
]
qed-.

(* Basic_1: was just: sty0_gen_cast *)
lemma ssta_inv_cast1: ∀h,g,G,L,X,Y,U,l. ⦃G, L⦄ ⊢ ⓝY.X •[h, g] ⦃l, U⦄ →
                      ⦃G, L⦄ ⊢ X •[h, g] ⦃l, U⦄.
/2 width=4 by ssta_inv_cast1_aux/ qed-.

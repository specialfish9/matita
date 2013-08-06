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

include "basic_2/notation/relations/dpredstar_6.ma".
include "basic_2/unfold/sstas.ma".
include "basic_2/computation/cprs.ma".

(* DECOMPOSED EXTENDED PARALLEL COMPUTATION ON TERMS ************************)

definition cpds: ∀h. sd h → relation4 genv lenv term term ≝
                 λh,g,G,L,T1,T2.
                 ∃∃T. ⦃G, L⦄ ⊢ T1 •*[h, g] T & ⦃G, L⦄ ⊢ T ➡* T2.

interpretation "decomposed extended parallel computation (term)"
   'DPRedStar h g G L T1 T2 = (cpds h g G L T1 T2).

(* Basic properties *********************************************************)

lemma cpds_refl: ∀h,g,G,L. reflexive … (cpds h g G L).
/2 width=3/ qed.

lemma sstas_cpds: ∀h,g,G,L,T1,T2. ⦃G, L⦄ ⊢ T1 •*[h, g] T2 → ⦃G, L⦄ ⊢ T1 •*➡*[h, g] T2.
/2 width=3/ qed.

lemma cprs_cpds: ∀h,g,G,L,T1,T2.  ⦃G, L⦄ ⊢ T1 ➡* T2 → ⦃G, L⦄ ⊢ T1 •*➡*[h, g] T2.
/2 width=3/ qed.

lemma cpds_strap1: ∀h,g,G,L,T1,T,T2.
                   ⦃G, L⦄ ⊢ T1 •*➡*[h, g] T → ⦃G, L⦄ ⊢ T ➡ T2 → ⦃G, L⦄ ⊢ T1 •*➡*[h, g] T2.
#h #g #G #L #T1 #T #T2 * /3 width=5/
qed.

lemma cpds_strap2: ∀h,g,G,L,T1,T,T2,l.
                   ⦃G, L⦄ ⊢ T1 •[h, g] ⦃l+1, T⦄ → ⦃G, L⦄ ⊢ T •*➡*[h, g] T2 → ⦃G, L⦄ ⊢ T1 •*➡*[h, g] T2.
#h #g #G #L #T1 #T #T2 #l #HT1 * /3 width=4/
qed.

lemma ssta_cprs_cpds: ∀h,g,G,L,T1,T,T2,l. ⦃G, L⦄ ⊢ T1 •[h, g] ⦃l+1, T⦄ →
                      ⦃G, L⦄ ⊢ T ➡* T2 → ⦃G, L⦄ ⊢ T1 •*➡*[h, g] T2.
/3 width=3/ qed.

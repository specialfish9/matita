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

include "basic_2/reduction/crx_append.ma".
include "basic_2/reduction/cix.ma".

(* CONTEXT-SENSITIVE EXTENDED IRREDUCIBLE TERMS *****************************)

(* Advanced inversion lemmas ************************************************)

lemma cix_inv_append_sn: ∀h,g,G,L,K,T. ⦃G, K @@ L⦄ ⊢ 𝐈[h, g]⦃T⦄  → ⦃G, L⦄ ⊢ 𝐈[h, g]⦃T⦄.
/3 width=1/ qed-.

lemma cix_inv_tix: ∀h,g,G,L,T. ⦃G, L⦄ ⊢ 𝐈[h, g]⦃T⦄  → ⦃G, ⋆⦄ ⊢ 𝐈[h, g]⦃T⦄.
/3 width=1/ qed-.

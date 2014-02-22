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

include "basic_2/computation/csx_lpxs.ma".
include "basic_2/computation/lcosx_cpxs.ma".

(* SN EXTENDED STRONGLY NORMALIZING LOCAL ENVIRONMENTS **********************)

(* Advanced properties ******************************************************)

lemma lsx_lref_be_lpxs: ∀h,g,I,G,K1,V,i,d. d ≤ yinj i → ⦃G, K1⦄ ⊢ ⬊*[h, g] V →
                        ∀K2. G ⊢ ⋕⬊*[h, g, V, 0] K2 → ⦃G, K1⦄ ⊢ ➡*[h, g] K2 →
                        ∀L2. ⇩[i] L2 ≡ K2.ⓑ{I}V → G ⊢ ⋕⬊*[h, g, #i, d] L2.
#h #g #I #G #K1 #V #i #d #Hdi #H @(csx_ind_alt … H) -V
#V0 #_ #IHV0 #K2 #H @(lsx_ind … H) -K2
#K0 #HK0 #IHK0 #HK10 #L0 #HLK0 @lsx_intro
#L2 #HL02 #HnL02 elim (lpxs_ldrop_conf … HLK0 … HL02) -HL02
#Y #H #HLK2 elim (lpxs_inv_pair1 … H) -H
#K2 #V2 #HK02 #HV02 #H destruct
lapply (lpxs_trans … HK10 … HK02) #HK12
elim (eq_term_dec V0 V2) #HnV02 destruct [ -IHV0 -HV02 -HK0 -HK10 | -IHK0 -HnL02 -HLK0 ]
[ /4 width=8 by lleq_lref/
| @(IHV0 … HnV02 … HK12 … HLK2) -IHV0 -HnV02 -HK12 -HLK2
  /3 width=4 by lsx_cpxs_trans_O, lsx_lpxs_trans, lpxs_cpxs_trans/ (**) (* full auto too slow *)
]
qed.

lemma lsx_lref_be: ∀h,g,I,G,K,V,i,d. d ≤ yinj i → ⦃G, K⦄ ⊢ ⬊*[h, g] V →
                   G ⊢ ⋕⬊*[h, g, V, 0] K →
                   ∀L. ⇩[i] L ≡ K.ⓑ{I}V → G ⊢ ⋕⬊*[h, g, #i, d] L.
/2 width=8 by lsx_lref_be_lpxs/ qed.

(* Main properties **********************************************************)

theorem csx_lsx: ∀h,g,G,L,T. ⦃G, L⦄ ⊢ ⬊*[h, g] T → ∀d. G ⊢ ⋕⬊*[h, g, T, d] L.
#h #g #G #L #T @(fqup_wf_ind_eq … G L T) -G -L -T
#Z #Y #X #IH #G #L * * //
[ #i #HG #HL #HT #H #d destruct
  elim (lt_or_ge i (|L|)) /2 width=1 by lsx_lref_free/
  elim (ylt_split i d) /2 width=1 by lsx_lref_skip/
  #Hdi #Hi elim (ldrop_O1_lt … Hi) -Hi
  #I #K #V #HLK lapply (csx_inv_lref_bind … HLK … H) -H
  /4 width=6 by lsx_lref_be, fqup_lref/
| #a #I #V #T #HG #HL #HT #H #d destruct
  elim (csx_fwd_bind … H) -H /3 width=1 by lsx_bind/
| #I #V #T #HG #HL #HT #H #d destruct
  elim (csx_fwd_flat … H) -H /3 width=1 by lsx_flat/
]
qed.

(* Advanced eliminators *****************************************************)

fact csx_ind_lsx_aux: ∀h,g,G,T,d. ∀R:predicate lenv.
                      (∀L1. ⦃G, L1⦄ ⊢ ⬊*[h, g] T →
                            (∀L2. ⦃G, L1⦄ ⊢ ➡*[h, g] L2 → (L1 ⋕[T, d] L2 → ⊥) → R L2) →
                            R L1
                      ) →
                      ∀L. G ⊢ ⋕⬊*[h, g, T, d] L → ⦃G, L⦄ ⊢ ⬊*[h, g] T → R L.
#h #g #G #T #d #R #IH #L #H @(lsx_ind … H) -L
#L1 #_ #IHL1 #HL1 @IH -IH //
#L2 #HL12 #HnT @IHL1 -IHL1 /2 width=3 by csx_lpxs_conf/
qed-.

lemma csx_ind_lsx: ∀h,g,G,T,d. ∀R:predicate lenv.
                   (∀L1. ⦃G, L1⦄ ⊢ ⬊*[h, g] T →
                         (∀L2. ⦃G, L1⦄ ⊢ ➡*[h, g] L2 → (L1 ⋕[T, d] L2 → ⊥) → R L2) →
                         R L1
                   ) →
                   ∀L. ⦃G, L⦄ ⊢ ⬊*[h, g] T → R L.
#h #g #G #T #d #R #IH #L #HL @(csx_ind_lsx_aux … d … HL) /4 width=1 by csx_lsx/
qed-.

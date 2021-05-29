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

include "ground/notation/relations/ratsucc_3.ma".
include "ground/arith/nat_pred_succ.ma".
include "ground/relocation/gr_pat.ma".

(* NON-NEGATIVE APPLICATION FOR GENERIC RELOCATION MAPS *********************)

definition gr_nat: relation3 gr_map nat nat ≝
           λf,l1,l2. @❪↑l1,f❫ ≘ ↑l2.

interpretation
  "relational non-negative application (generic relocation maps)"
  'RAtSucc l1 f l2 = (gr_nat f l1 l2).

(* Basic constructions ******************************************************)

lemma gr_nat_refl (f) (g) (k1) (k2):
      (⫯f) = g → 𝟎 = k1 → 𝟎 = k2 → @↑❪k1,g❫ ≘ k2.
#f #g #k1 #k2 #H1 #H2 #H3 destruct
/2 width=2 by gr_pat_refl/
qed.

lemma gr_nat_push (f) (l1) (l2) (g) (k1) (k2):
      @↑❪l1,f❫ ≘ l2 → ⫯f = g → ↑l1 = k1 → ↑l2 = k2 → @↑❪k1,g❫ ≘ k2.
#f #l1 #l2 #g #k1 #k2 #Hf #H1 #H2 #H3 destruct
/2 width=7 by gr_pat_push/
qed.

lemma gr_nat_next (f) (l1) (l2) (g) (k2):
      @↑❪l1,f❫ ≘ l2 → ↑f = g → ↑l2 = k2 → @↑❪l1,g❫ ≘ k2.
#f #l1 #l2 #g #k2 #Hf #H1 #H2 destruct
/2 width=5 by gr_pat_next/
qed.

lemma gr_nat_pred_bi (f) (i1) (i2):
      @❪i1,f❫ ≘ i2 → @↑❪↓i1,f❫ ≘ ↓i2.
#f #i1 #i2
>(npsucc_pred i1) in ⊢ (%→?); >(npsucc_pred i2) in ⊢ (%→?);
//
qed.

(* Basic inversions *********************************************************)

(*** gr_nat_inv_ppx *)
lemma gr_nat_inv_zero_push (f) (l1) (l2):
      @↑❪l1,f❫ ≘ l2 → ∀g. 𝟎 = l1 → ⫯g = f → 𝟎 = l2.
#f #l1 #l2 #H #g #H1 #H2 destruct
lapply (gr_pat_inv_unit_push … H ???) -H
/2 width=2 by eq_inv_npsucc_bi/
qed-.

(*** gr_nat_inv_npx *)
lemma gr_nat_inv_succ_push (f) (l1) (l2):
      @↑❪l1,f❫ ≘ l2 → ∀g,k1. ↑k1 = l1 → ⫯g = f →
      ∃∃k2. @↑❪k1,g❫ ≘ k2 & ↑k2 = l2.
#f #l1 #l2 #H #g #k1 #H1 #H2 destruct
elim (gr_pat_inv_succ_push … H) -H [|*: // ] #k2 #Hg
>(npsucc_pred (↑l2)) #H
@(ex2_intro … (↓k2)) //
qed-.

(*** gr_nat_inv_xnx *)
lemma gr_nat_inv_next (f) (l1) (l2):
      @↑❪l1,f❫ ≘ l2 → ∀g. ↑g = f →
      ∃∃k2. @↑❪l1,g❫ ≘ k2 & ↑k2 = l2.
#f #l1 #l2 #H #g #H1 destruct
elim (gr_pat_inv_next … H) -H [|*: // ] #k2
>(npsucc_pred (k2)) in ⊢ (%→?→?); #Hg #H
@(ex2_intro … (↓k2)) //
qed-.

(* Advanced inversions ******************************************************)

(*** gr_nat_inv_ppn *)
lemma gr_nat_inv_zero_push_succ (f) (l1) (l2):
      @↑❪l1,f❫ ≘ l2 → ∀g,k2. 𝟎 = l1 → ⫯g = f → ↑k2 = l2 → ⊥.
#f #l1 #l2 #Hf #g #k2 #H1 #H <(gr_nat_inv_zero_push … Hf … H1 H) -f -g -l1 -l2
/2 width=3 by eq_inv_nsucc_zero/
qed-.

(*** gr_nat_inv_npp *)
lemma gr_nat_inv_succ_push_zero (f) (l1) (l2):
      @↑❪l1,f❫ ≘ l2 → ∀g,k1. ↑k1 = l1 → ⫯g = f → 𝟎 = l2 → ⊥.
#f #l1 #l2 #Hf #g #k1 #H1 #H elim (gr_nat_inv_succ_push … Hf … H1 H) -f -l1
#x2 #Hg * -l2 /2 width=3 by eq_inv_zero_nsucc/
qed-.

(*** gr_nat_inv_npn *)
lemma gr_nat_inv_succ_push_succ (f) (l1) (l2):
      @↑❪l1,f❫ ≘ l2 → ∀g,k1,k2. ↑k1 = l1 → ⫯g = f → ↑k2 = l2 → @↑❪k1,g❫ ≘ k2.
#f #l1 #l2 #Hf #g #k1 #k2 #H1 #H elim (gr_nat_inv_succ_push … Hf … H1 H) -f -l1
#x2 #Hg * -l2 #H >(eq_inv_nsucc_bi … H) -k2 //
qed-.

(*** gr_nat_inv_xnp *)
lemma gr_nat_inv_next_zero (f) (l1) (l2):
      @↑❪l1,f❫ ≘ l2 → ∀g. ↑g = f → 𝟎 = l2 → ⊥.
#f #l1 #l2 #Hf #g #H elim (gr_nat_inv_next … Hf … H) -f
#x2 #Hg * -l2 /2 width=3 by eq_inv_zero_nsucc/
qed-.

(*** gr_nat_inv_xnn *)
lemma gr_nat_inv_next_succ (f) (l1) (l2):
      @↑❪l1,f❫ ≘ l2 → ∀g,k2. ↑g = f → ↑k2 = l2 → @↑❪l1,g❫ ≘ k2.
#f #l1 #l2 #Hf #g #k2 #H elim (gr_nat_inv_next … Hf … H) -f
#x2 #Hg * -l2 #H >(eq_inv_nsucc_bi … H) -k2 //
qed-.

(*** gr_nat_inv_pxp *)
lemma gr_nat_inv_zero_bi (f) (l1) (l2):
      @↑❪l1,f❫ ≘ l2 → 𝟎 = l1 → 𝟎 = l2 → ∃g. ⫯g = f.
#f elim (gr_map_split_tl … f) /2 width=2 by ex_intro/
#H #l1 #l2 #Hf #H1 #H2 cases (gr_nat_inv_next_zero … Hf … H H2)
qed-.

(*** gr_nat_inv_pxn *)
lemma gr_nat_inv_zero_succ (f) (l1) (l2):
      @↑❪l1,f❫ ≘ l2 → ∀k2. 𝟎 = l1 → ↑k2 = l2 →
      ∃∃g. @↑❪l1,g❫ ≘ k2 & ↑g = f.
#f elim (gr_map_split_tl … f)
#H #l1 #l2 #Hf #k2 #H1 #H2
[ elim (gr_nat_inv_zero_push_succ … Hf … H1 H H2)
| /3 width=5 by gr_nat_inv_next_succ, ex2_intro/
]
qed-.

(*** gr_nat_inv_nxp *)
lemma gr_nat_inv_succ_zero (f) (l1) (l2):
      @↑❪l1,f❫ ≘ l2 → ∀k1. ↑k1 = l1 → 𝟎 = l2 → ⊥.
#f elim (gr_map_split_tl f)
#H #l1 #l2 #Hf #k1 #H1 #H2
[ elim (gr_nat_inv_succ_push_zero … Hf … H1 H H2)
| elim (gr_nat_inv_next_zero … Hf … H H2)
]
qed-.

(*** gr_nat_inv_nxn *)
lemma gr_nat_inv_succ_bi (f) (l1) (l2):
      @↑❪l1,f❫ ≘ l2 → ∀k1,k2. ↑k1 = l1 → ↑k2 = l2 →
      ∨∨ ∃∃g. @↑❪k1,g❫ ≘ k2 & ⫯g = f
       | ∃∃g. @↑❪l1,g❫ ≘ k2 & ↑g = f.
#f elim (gr_map_split_tl f) *
/4 width=7 by gr_nat_inv_next_succ, gr_nat_inv_succ_push_succ, ex2_intro, or_intror, or_introl/
qed-.

(* Note: the following inversion lemmas must be checked *)
(*** gr_nat_inv_xpx *)
lemma gr_nat_inv_push (f) (l1) (l2):
      @↑❪l1,f❫ ≘ l2 → ∀g. ⫯g = f →
      ∨∨ ∧∧ 𝟎 = l1 & 𝟎 = l2
       | ∃∃k1,k2. @↑❪k1,g❫ ≘ k2 & ↑k1 = l1 & ↑k2 = l2.
#f * [2: #l1 ] #l2 #Hf #g #H
[ elim (gr_nat_inv_succ_push … Hf … H) -f /3 width=5 by or_intror, ex3_2_intro/
| >(gr_nat_inv_zero_push … Hf … H) -f /3 width=1 by conj, or_introl/
]
qed-.

(*** gr_nat_inv_xpp *)
lemma gr_nat_inv_push_zero (f) (l1) (l2):
      @↑❪l1,f❫ ≘ l2 → ∀g. ⫯g = f → 𝟎 = l2 → 𝟎 = l1.
#f #l1 #l2 #Hf #g #H elim (gr_nat_inv_push … Hf … H) -f * //
#k1 #k2 #_ #_ * -l2 #H elim (eq_inv_zero_nsucc … H)
qed-.

(*** gr_nat_inv_xpn *)
lemma gr_nat_inv_push_succ (f) (l1) (l2):
      @↑❪l1,f❫ ≘ l2 → ∀g,k2. ⫯g = f → ↑k2 = l2 →
      ∃∃k1. @↑❪k1,g❫ ≘ k2 & ↑k1 = l1.
#f #l1 #l2 #Hf #g #k2 #H elim (gr_nat_inv_push … Hf … H) -f *
[ #_ * -l2 #H elim (eq_inv_nsucc_zero … H)
| #x1 #x2 #Hg #H1 * -l2 #H
  lapply (eq_inv_nsucc_bi … H) -H #H destruct
  /2 width=3 by ex2_intro/
]
qed-.

(*** gr_nat_inv_xxp *)
lemma gr_nat_inv_zero_dx (f) (l1) (l2):
      @↑❪l1,f❫ ≘ l2 → 𝟎 = l2 → ∃∃g. 𝟎 = l1 & ⫯g = f.
#f elim (gr_map_split_tl f)
#H #l1 #l2 #Hf #H2
[ /3 width=6 by gr_nat_inv_push_zero, ex2_intro/
| elim (gr_nat_inv_next_zero … Hf … H H2)
]
qed-.

(*** gr_nat_inv_xxn *)
lemma gr_nat_inv_succ_dx (f) (l1) (l2): @↑❪l1,f❫ ≘ l2 → ∀k2.  ↑k2 = l2 →
      ∨∨ ∃∃g,k1. @↑❪k1,g❫ ≘ k2 & ↑k1 = l1 & ⫯g = f
       | ∃∃g. @↑❪l1,g❫ ≘ k2 & ↑g = f.
#f elim (gr_map_split_tl f)
#H #l1 #l2 #Hf #k2 #H2
[ elim (gr_nat_inv_push_succ … Hf … H H2) -l2 /3 width=5 by or_introl, ex3_2_intro/
| lapply (gr_nat_inv_next_succ … Hf … H H2) -l2 /3 width=3 by or_intror, ex2_intro/
]
qed-.

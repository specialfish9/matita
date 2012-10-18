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

include "basics/star.ma".
include "ground_2/xoa_props.ma".
include "ground_2/notation.ma".

(* PROPERTIES OF RELATIONS **************************************************)

definition Decidable: Prop → Prop ≝ λR. R ∨ (R → ⊥).

definition Confluent: ∀A. ∀R: relation A. Prop ≝ λA,R.
                      ∀a0,a1. R a0 a1 → ∀a2. R a0 a2 →
                      ∃∃a. R a1 a & R a2 a.

definition Transitive: ∀A. ∀R: relation A. Prop ≝ λA,R.
                       ∀a1,a0. R a1 a0 → ∀a2. R a0 a2 → R a1 a2.

definition confluent2: ∀A. ∀R1,R2: relation A. Prop ≝ λA,R1,R2.
                       ∀a0,a1. R1 a0 a1 → ∀a2. R2 a0 a2 →
                       ∃∃a. R2 a1 a & R1 a2 a.

definition transitive2: ∀A. ∀R1,R2: relation A. Prop ≝ λA,R1,R2.
                        ∀a1,a0. R1 a1 a0 → ∀a2. R2 a0 a2 →
                        ∃∃a. R2 a1 a & R1 a a2.

definition bi_confluent:  ∀A,B. ∀R: bi_relation A B. Prop ≝ λA,B,R.
                          ∀a0,a1,b0,b1. R a0 b0 a1 b1 → ∀a2,b2. R a0 b0 a2 b2 →
                          ∃∃a,b. R a1 b1 a b & R a2 b2 a b.

lemma TC_strip1: ∀A,R1,R2. confluent2 A R1 R2 →
                 ∀a0,a1. TC … R1 a0 a1 → ∀a2. R2 a0 a2 →
                 ∃∃a. R2 a1 a & TC … R1 a2 a.
#A #R1 #R2 #HR12 #a0 #a1 #H elim H -a1
[ #a1 #Ha01 #a2 #Ha02
  elim (HR12 … Ha01 … Ha02) -HR12 -a0 /3 width=3/
| #a #a1 #_ #Ha1 #IHa0 #a2 #Ha02
  elim (IHa0 … Ha02) -a0 #a0 #Ha0 #Ha20
  elim (HR12 … Ha1 … Ha0) -HR12 -a /4 width=3/
]
qed.

lemma TC_strip2: ∀A,R1,R2. confluent2 A R1 R2 →
                 ∀a0,a2. TC … R2 a0 a2 → ∀a1. R1 a0 a1 →
                 ∃∃a. TC … R2 a1 a & R1 a2 a.
#A #R1 #R2 #HR12 #a0 #a2 #H elim H -a2
[ #a2 #Ha02 #a1 #Ha01
  elim (HR12 … Ha01 … Ha02) -HR12 -a0 /3 width=3/
| #a #a2 #_ #Ha2 #IHa0 #a1 #Ha01
  elim (IHa0 … Ha01) -a0 #a0 #Ha10 #Ha0
  elim (HR12 … Ha0 … Ha2) -HR12 -a /4 width=3/
]
qed.

lemma TC_confluent2: ∀A,R1,R2.
                     confluent2 A R1 R2 → confluent2 A (TC … R1) (TC … R2).
#A #R1 #R2 #HR12 #a0 #a1 #H elim H -a1
[ #a1 #Ha01 #a2 #Ha02
  elim (TC_strip2 … HR12 … Ha02 … Ha01) -HR12 -a0 /3 width=3/
| #a #a1 #_ #Ha1 #IHa0 #a2 #Ha02
  elim (IHa0 … Ha02) -a0 #a0 #Ha0 #Ha20
  elim (TC_strip2 … HR12 … Ha0 … Ha1) -HR12 -a /4 width=3/
]
qed.

lemma TC_strap1: ∀A,R1,R2. transitive2 A R1 R2 →
                 ∀a1,a0. TC … R1 a1 a0 → ∀a2. R2 a0 a2 →
                 ∃∃a. R2 a1 a & TC … R1 a a2.
#A #R1 #R2 #HR12 #a1 #a0 #H elim H -a0
[ #a0 #Ha10 #a2 #Ha02
  elim (HR12 … Ha10 … Ha02) -HR12 -a0 /3 width=3/
| #a #a0 #_ #Ha0 #IHa #a2 #Ha02
  elim (HR12 … Ha0 … Ha02) -HR12 -a0 #a0 #Ha0 #Ha02
  elim (IHa … Ha0) -a /4 width=3/
]
qed.

lemma TC_strap2: ∀A,R1,R2. transitive2 A R1 R2 →
                 ∀a0,a2. TC … R2 a0 a2 → ∀a1. R1 a1 a0 →
                 ∃∃a. TC … R2 a1 a & R1 a a2.
#A #R1 #R2 #HR12 #a0 #a2 #H elim H -a2
[ #a2 #Ha02 #a1 #Ha10
  elim (HR12 … Ha10 … Ha02) -HR12 -a0 /3 width=3/
| #a #a2 #_ #Ha02 #IHa #a1 #Ha10
  elim (IHa … Ha10) -a0 #a0 #Ha10 #Ha0
  elim (HR12 … Ha0 … Ha02) -HR12 -a /4 width=3/
]
qed.

lemma TC_transitive2: ∀A,R1,R2.
                      transitive2 A R1 R2 → transitive2 A (TC … R1) (TC … R2).
#A #R1 #R2 #HR12 #a1 #a0 #H elim H -a0
[ #a0 #Ha10 #a2 #Ha02
  elim (TC_strap2 … HR12 … Ha02 … Ha10) -HR12 -a0 /3 width=3/
| #a #a0 #_ #Ha0 #IHa #a2 #Ha02
  elim (TC_strap2 … HR12 … Ha02 … Ha0) -HR12 -a0 #a0 #Ha0 #Ha02
  elim (IHa … Ha0) -a /4 width=3/
]
qed.

definition NF: ∀A. relation A → relation A → predicate A ≝
   λA,R,S,a1. ∀a2. R a1 a2 → S a2 a1.

inductive SN (A) (R,S:relation A): predicate A ≝
| SN_intro: ∀a1. (∀a2. R a1 a2 → (S a2 a1 → ⊥) → SN A R S a2) → SN A R S a1
.

lemma NF_to_SN: ∀A,R,S,a. NF A R S a → SN A R S a.
#A #R #S #a1 #Ha1
@SN_intro #a2 #HRa12 #HSa12
elim (HSa12 ?) -HSa12 /2 width=1/
qed.

definition NF_sn: ∀A. relation A → relation A → predicate A ≝
   λA,R,S,a2. ∀a1. R a1 a2 → S a2 a1.

inductive SN_sn (A) (R,S:relation A): predicate A ≝
| SN_sn_intro: ∀a2. (∀a1. R a1 a2 → (S a2 a1 → ⊥) → SN_sn A R S a1) → SN_sn A R S a2
.

lemma NF_to_SN_sn: ∀A,R,S,a. NF_sn A R S a → SN_sn A R S a.
#A #R #S #a2 #Ha2
@SN_sn_intro #a1 #HRa12 #HSa12
elim (HSa12 ?) -HSa12 /2 width=1/
qed.

lemma bi_TC_strip: ∀A,B,R. bi_confluent A B R →
                   ∀a0,a1,b0,b1. R a0 b0 a1 b1 → ∀a2,b2. bi_TC … R a0 b0 a2 b2 →
                   ∃∃a,b. bi_TC … R a1 b1 a b & R a2 b2 a b.
#A #B #R #HR #a0 #a1 #b0 #b1 #H01 #a2 #b2 #H elim H -a2 -b2
[ #a2 #b2 #H02
  elim (HR … H01 … H02) -HR -a0 -b0 /3 width=4/
| #a2 #b2 #a3 #b3 #_ #H23 * #a #b #H1 #H2
  elim (HR … H23 … H2) -HR -a0 -b0 -a2 -b2 /3 width=4/
]
qed.

lemma bi_TC_confluent: ∀A,B,R. bi_confluent A B R →
                       bi_confluent A B (bi_TC … R).
#A #B #R #HR #a0 #a1 #b0 #b1 #H elim H -a1 -b1
[ #a1 #b1 #H01 #a2 #b2 #H02
  elim (bi_TC_strip … HR … H01 … H02) -a0 -b0 /3 width=4/
| #a1 #b1 #a3 #b3 #_ #H13 #IH #a2 #b2 #H02
  elim (IH … H02) -a0 -b0 #a0 #b0 #H10 #H20
  elim (bi_TC_strip … HR … H13 … H10) -a1 -b1 /3 width=7/
]
qed.

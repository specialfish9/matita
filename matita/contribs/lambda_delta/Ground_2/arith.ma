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

include "arithmetics/nat.ma".
include "Ground_2/star.ma".

(* ARITHMETICAL PROPERTIES **************************************************)

(* equations ****************************************************************)

lemma plus_plus_comm_23: ∀x,y,z. x + y + z = x + z + y.
// qed.

lemma le_plus_minus: ∀m,n,p. p ≤ n → m + n - p = m + (n - p).
/2 by plus_minus/ qed.

lemma le_plus_minus_comm: ∀n,m,p. p ≤ m → m + n - p = m - p + n.
/2 by plus_minus/ qed.

lemma minus_le_minus_minus_comm: ∀b,c,a. c ≤ b → a - (b - c) = a + c - b.
#b elim b -b
[ #c #a #H >(le_n_O_to_eq … H) -H //
| #b #IHb #c elim c -c //
  #c #_ #a #Hcb
  lapply (le_S_S_to_le … Hcb) -Hcb #Hcb
  <plus_n_Sm normalize /2 width=1/
]
qed.

lemma minus_minus_comm: ∀a,b,c. a - b - c = a - c - b.
/3 by monotonic_le_minus_l, le_to_le_to_eq/ qed.

lemma arith_b1: ∀a,b,c1. c1 ≤ b → a - c1 - (b - c1) = a - b.
#a #b #c1 #H >minus_plus @eq_f2 /2 width=1/
qed.

lemma arith_b2: ∀a,b,c1,c2. c1 + c2 ≤ b → a - c1 - c2 - (b - c1 - c2) = a - b.
#a #b #c1 #c2 #H >minus_plus >minus_plus >minus_plus /2 width=1/
qed.

lemma arith_c1x: ∀x,a,b,c1. x + c1 + a - (b + c1) = x + a - b.
/3 by monotonic_le_minus_l, le_to_le_to_eq, le_n/ qed.

lemma arith_h1: ∀a1,a2,b,c1. c1 ≤ a1 → c1 ≤ b →
                a1 - c1 + a2 - (b - c1) = a1 + a2 - b.
#a1 #a2 #b #c1 #H1 #H2 >plus_minus // /2 width=1/
qed.

(* inversion & forward lemmas ***********************************************)

axiom eq_nat_dec: ∀n1,n2:nat. Decidable (n1 = n2).

axiom lt_dec: ∀n1,n2. Decidable (n1 < n2).

lemma lt_or_ge: ∀m,n. m < n ∨ n ≤ m.
#m #n elim (decidable_lt m n) /2 width=1/ /3 width=1/
qed-.

lemma lt_or_eq_or_gt: ∀m,n. ∨∨ m < n | n = m | n < m.
#m elim m -m
[ * /2 width=1/
| #m #IHm * /2 width=1/
  #n elim (IHm n) -IHm #H 
  [ @or3_intro0 | @or3_intro1 destruct | @or3_intro2 ] // /2 width=1/ (**) (* /3 width=1/ is slow *)
qed-.

lemma le_inv_plus_plus_r: ∀x,y,z. x + z ≤ y + z → x ≤ y.
/2 by le_plus_to_le/ qed-.

lemma le_inv_plus_l: ∀x,y,z. x + y ≤ z → x ≤ z - y ∧ y ≤ z.
/3 width=2/ qed-.

lemma lt_refl_false: ∀n. n < n → False.
#n #H elim (lt_to_not_eq … H) -H /2 width=1/
qed-.

lemma lt_zero_false: ∀n. n < 0 → False.
#n #H elim (lt_to_not_le … H) -H /2 width=1/
qed-.

lemma plus_S_eq_O_false: ∀n,m. n + S m = 0 → False.
#n #m <plus_n_Sm #H destruct
qed-.

lemma plus_lt_false: ∀m,n. m + n < m → False.
#m #n #H1 lapply (le_plus_n_r n m) #H2
lapply (le_to_lt_to_lt … H2 H1) -H2 -H1 #H
elim (lt_refl_false … H)
qed-.

lemma false_lt_to_le: ∀x,y. (x < y → False) → y ≤ x.
#x #y #H elim (decidable_lt x y) /2 width=1/
#Hxy elim (H Hxy)
qed-.

lemma le_fwd_plus_plus_ge: ∀m1,m2. m2 ≤ m1 → ∀n1,n2. m1 + n1 ≤ m2 + n2 → n1 ≤ n2.
#m1 #m2 #H elim H -m1
[ /2 width=2/
| #m1 #_ #IHm1 #n1 #n2 #H @IHm1 /2 width=3/
]
qed-.

(* backward lemmas **********************************************************)

lemma monotonic_lt_minus_l: ∀p,q,n. n ≤ q → q < p → q - n < p - n.
#p #q #n #H1 #H2
@lt_plus_to_minus_r <plus_minus_m_m //.
qed.

(* unstable *****************************************************************)

lemma arith2: ∀j,i,e,d. d + e ≤ i → d ≤ i - e + j.
#j #i #e #d #H lapply (le_plus_to_minus_r … H) -H /2 width=3/
qed.

lemma arith5: ∀a,b1,b2,c1. c1 ≤ b1 → c1 ≤ a → a < b1 + b2 → a - c1 < b1 - c1 + b2.
#a #b1 #b2 #c1 #H1 #H2 #H3
>plus_minus // @monotonic_lt_minus_l //
qed.

lemma arith10: ∀a,b,c,d,e. a ≤ b → c + (a - d - e) ≤ c + (b - d - e).
#a #b #c #d #e #H
>minus_plus >minus_plus @monotonic_le_plus_r @monotonic_le_minus_l //
qed.

(* remove *******************************************************************)
(*
lemma minus_plus_comm: ∀a,b,c. a - b - c = a - (c + b).
// qed.

lemma plus_S_le_to_pos: ∀n,m,p. n + S m ≤ p → 0 < p.
/2 by ltn_to_ltO/ qed.

lemma minus_le: ∀m,n. m - n ≤ m.
/2 by monotonic_le_minus_l/ qed.

lemma le_O_to_eq_O: ∀n. n ≤ 0 → n = 0.
/2 by le_n_O_to_eq/ qed.

lemma lt_to_le: ∀a,b. a < b → a ≤ b.
/2 by le_plus_b/ qed.

lemma le_to_lt_or_eq: ∀m,n. m ≤ n → m < n ∨ m = n.
/2 by le_to_or_lt_eq/ qed.

lemma plus_le_weak: ∀m,n,p. m + n ≤ p → n ≤ p.
/2 by le_plus_b/ qed.

lemma plus_le_minus: ∀a,b,c. a + b ≤ c → a ≤ c - b.
/2 by le_plus_to_minus_r/ qed.

lemma lt_plus_minus: ∀i,u,d. u ≤ i → i < d + u → i - u < d.
/2 by monotonic_lt_minus_l/ qed.

lemma arith_a2: ∀a,c1,c2. c1 + c2 ≤ a → a - c1 - c2 + (c1 + c2) = a.
/2 by plus_minus/ qed.

lemma arith_c1: ∀a,b,c1. a + c1 - (b + c1) = a - b.
// qed.

lemma arith_d1: ∀a,b,c1. c1 ≤ b → a + c1 + (b - c1) = a + b.
/2 by plus_minus/ qed.

lemma arith_e2: ∀a,c1,c2. a ≤ c1 → c1 + c2 - (c1 - a + c2) = a.
/2 by minus_le_minus_minus_comm/ qed.

lemma arith_f1: ∀a,b,c1. a + b ≤ c1 → c1 - (c1 - a - b) = a + b.
/2 by minus_le_minus_minus_comm/
qed.

lemma arith_g1: ∀a,b,c1. c1 ≤ b → a - (b - c1) - c1 = a - b.
/2 by arith_b1/ qed.

lemma arith_i2: ∀a,c1,c2. c1 + c2 ≤ a → c1 + c2 + (a - c1 - c2) = a.
/2 by plus_minus_m_m/ qed.

lemma arith_z1: ∀a,b,c1. a + c1 - b - c1 = a - b.
// qed.

lemma arith1: ∀n,h,m,p. n + h + m ≤ p + h → n + m ≤ p.
/2 by le_plus_to_le/ qed.

lemma arith3: ∀a1,a2,b,c1. a1 + a2 ≤ b → a1 + c1 + a2 ≤ b + c1.
/2 by le_minus_to_plus/ qed.

lemma arith4: ∀h,d,e1,e2. d ≤ e1 + e2 → d + h ≤ e1 + h + e2.
/2 by arith3/ qed.

lemma arith8: ∀a,b. a < a + b + 1.
// qed.

lemma arith9: ∀a,b,c. c < a + (b + c + 1) + 1.
// qed.

(* backward form of le_inv_plus_l *)
lemma P2: ∀x,y,z. x ≤ z - y → y ≤ z → x + y ≤ z.
/2 by le_minus_to_plus_r/ qed.
*)

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

include "ground_2/ynat/ynat_lt.ma".

(* NATURAL NUMBERS WITH INFINITY ********************************************)

(* subtraction *)
definition yminus: ynat → ynat → ynat ≝ λx,y. match y with
[ yinj n ⇒ ypred^n x
| Y      ⇒ yinj 0
].

interpretation "ynat minus" 'minus x y = (yminus x y).

lemma yminus_O2: ∀m:ynat. m - 0 = m.
// qed.

lemma yminus_S2: ∀m:ynat. ∀n:nat. m - S n = ⫰(m - n).
// qed.

lemma yminus_Y2: ∀m. m - (∞) = 0.
// qed.

(* Basic properties *********************************************************)

lemma yminus_inj: ∀m,n. yinj m - yinj n = yinj (m - n).
#m #n elim n -n //
#n #IH >yminus_S2 >IH -IH >eq_minus_S_pred //
qed.

lemma yminus_Y_inj: ∀n. ∞ - yinj n = ∞.
#n elim n -n //
qed.

lemma yminus_O1: ∀x:ynat. 0 - x = 0.
* // qed.

lemma yminus_refl: ∀x:ynat. x - x = 0.
* // qed.

lemma yminus_minus_comm: ∀y,z,x. x - y - z = x - z - y.
* #y [ * #z [ * // ] ] >yminus_O1 //
qed.

(* Properties on predecessor ************************************************)

lemma yminus_SO2: ∀m. m - 1 = ⫰m.
* //
qed.

lemma yminus_pred1: ∀x,y. ⫰x - y = ⫰(x-y).
#x * // #y elim y -y //
qed.

lemma yminus_pred: ∀n,m. 0 < m → 0 < n → ⫰m - ⫰n = m - n.
* // #n *
[ #m #Hm #Hn >yminus_inj >yminus_inj
  /4 width=1 by ylt_inv_inj, minus_pred_pred, eq_f/
| >yminus_Y_inj //
]
qed-.

(* Properties on successor **************************************************)

lemma yminus_succ: ∀n,m. ⫯m - ⫯n = m - n.
* // qed.

lemma yminus_succ1_inj: ∀n:nat. ∀m:ynat. n ≤ m → ⫯m - n = ⫯(m - n).
#n *
[ #m #Hmn >yminus_inj >yminus_inj
  /4 width=1 by yle_inv_inj, plus_minus, eq_f/
| >yminus_Y_inj //
]
qed-.

lemma yminus_succ2: ∀y,x. x - ⫯y = ⫰(x-y).
* //
qed.

(* Properties on order ******************************************************)

lemma yle_minus_sn: ∀n,m. m - n ≤ m.
* // #n * /2 width=1 by yle_inj/
qed.

lemma yle_to_minus: ∀m:ynat. ∀n:ynat. m ≤ n → m - n = 0.
#m #n * -m -n /3 width=3 by eq_minus_O, eq_f/
qed-.

lemma yminus_to_le: ∀n:ynat. ∀m:ynat. m - n = 0 → m ≤ n.
* // #n *
[ #m >yminus_inj #H lapply (yinj_inj … H) -H (**) (* destruct lemma needed *)
  /2 width=1 by yle_inj/
| >yminus_Y_inj #H destruct
]
qed.

lemma monotonic_yle_minus_dx: ∀x,y. x ≤ y → ∀z. x - z ≤ y - z.
#x #y #Hxy * //
#z elim z -z /3 width=1 by yle_pred/
qed.

(* Properties on strict order ***********************************************)

lemma ylt_to_minus: ∀x,y:ynat. x < y → 0 < y - x.
#x #y #H elim H -x -y /3 width=1 by ylt_inj, lt_plus_to_minus_r/
qed.

lemma yminus_to_lt: ∀x,y:ynat. 0 < y - x → x < y.
* [2: #y #H elim (ylt_yle_false … H) // ]
#m * /4 width=1 by ylt_inv_inj, ylt_inj, lt_minus_to_plus_r/
qed-.

lemma monotonic_ylt_minus_dx: ∀x,y:ynat. x < y → ∀z:nat. z ≤ x → x - z < y - z.
#x #y * -x -y
/4 width=1 by ylt_inj, yle_inv_inj, monotonic_lt_minus_l/
qed.

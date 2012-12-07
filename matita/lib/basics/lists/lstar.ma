(*
    ||M||  This file is part of HELM, an Hypertextual, Electronic        
    ||A||  Library of Mathematics, developed at the Computer Science     
    ||T||  Department of the University of Bologna, Italy.                     
    ||I||                                                                 
    ||T||  
    ||A||  
    \   /  This file is distributed under the terms of the       
     \ /   GNU General Public License Version 2   
      V_______________________________________________________________ *)

include "basics/lists/list.ma".

(* labelled reflexive and transitive closure ********************************)

inductive lstar (A:Type[0]) (B:Type[0]) (R: A→relation B): list A → relation B ≝
| lstar_nil : ∀b. lstar A B R ([]) b b
| lstar_cons: ∀a,b1,b. R a b1 b →
              ∀l,b2. lstar A B R l b b2 → lstar A B R (a::l) b1 b2
.

fact lstar_ind_l_aux: ∀A,B,R,b2. ∀P:relation2 (list A) B.
                      P ([]) b2 →
                      (∀a,l,b1,b. R a b1 b → lstar … R l b b2 → P l b → P (a::l) b1) →
                      ∀l,b1,b. lstar … R l b1 b → b = b2 → P l b1.
#A #B #R #b2 #P #H1 #H2 #l #b1 #b #H elim H -b -b1
[ #b #H destruct /2 width=1/
| #a #b #b0 #Hb0 #l #b1 #Hb01 #IH #H destruct /3 width=4/
]
qed-.

(* imporeved version of lstar_ind with "left_parameter" *)
lemma lstar_ind_l: ∀A,B,R,b2. ∀P:relation2 (list A) B.
                   P ([]) b2 →
                   (∀a,l,b1,b. R a b1 b → lstar … R l b b2 → P l b → P (a::l) b1) →
                   ∀l,b1. lstar … R l b1 b2 → P l b1.
#A #B #R #b2 #P #H1 #H2 #l #b1 #Hb12
@(lstar_ind_l_aux … H1 H2 … Hb12) //
qed-.

lemma lstar_step: ∀A,B,R,a,b1,b2. R a b1 b2 → lstar A B R ([a]) b1 b2.
/2 width=3/
qed.

lemma lstar_inv_nil: ∀A,B,R,l,b1,b2. lstar A B R l b1 b2 → [] = l → b1 = b2.
#A #B #R #l #b1 #b2 * -l -b1 -b2 //
#a #b1 #b #_ #l #b2 #_ #H destruct
qed-.

lemma lstar_inv_cons: ∀A,B,R,l,b1,b2. lstar A B R l b1 b2 →
                      ∀a0,l0. a0::l0 = l →
                      ∃∃b. R a0 b1 b & lstar A B R l0 b b2.
#A #B #R #l #b1 #b2 * -l -b1 -b2
[ #b #a0 #l0 #H destruct
| #a #b1 #b #Hb1 #l #b2 #Hb2 #a0 #l0 #H destruct /2 width=3/
]
qed-.

lemma lstar_inv_step: ∀A,B,R,a,b1,b2. lstar A B R ([a]) b1 b2 → R a b1 b2.
#A #B #R #a #b1 #b2 #H
elim (lstar_inv_cons ?????? H ???) -H [4: // |2,3: skip ] #b #Hb1 #H (**) (* simplify line *)
<(lstar_inv_nil ?????? H ?) -H // (**) (* simplify line *)
qed-.

theorem lstar_singlevalued: ∀A,B,R. (∀a. singlevalued ?? (R a)) →
                            ∀l. singlevalued … (lstar A B R l).
#A #B #R #HR #l #b #c1 #H @(lstar_ind_l ????????? H) -l -b
[ /2 width=5 by lstar_inv_nil/
| #a #l #b #b1 #Hb1 #_ #IHbc1 #c2 #H
  elim (lstar_inv_cons ?????? H ???) -H [4: // |2,3: skip ] #b2 #Hb2 #Hbc2 (**) (* simplify line *)
  lapply (HR … Hb1 … Hb2) -b #H destruct /2 width=1/
]
qed-.

theorem lstar_trans: ∀A,B,R,l1,b1,b. lstar A B R l1 b1 b →
                     ∀l2,b2. lstar A B R l2 b b2 → lstar A B R (l1@l2) b1 b2.
#A #B #R #l1 #b1 #b #H @(lstar_ind_l ????????? H) -l1 -b1 normalize // /3 width=3/
qed-.

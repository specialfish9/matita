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

include "ground_2/lib/arith.ma".

(* APPLICABILITY CONDITION  *************************************************)

(* applicability condition specification *)
record ac: Type[0] ≝ {
(* degree of the sort *)
   appl: predicate nat
}.

(* applicability condition postulates *)
record ac_props (a): Prop ≝ {
   ac_dec: ∀m. Decidable (∃∃n. m ≤ n & appl a n)
}.

(* Notable specifications ***************************************************)

definition apply_top: predicate nat ≝ λn. ⊤.

definition ac_top: ac ≝ mk_ac apply_top.

lemma ac_top_props: ac_props ac_top ≝ mk_ac_props ….
/3 width=3 by or_introl, ex2_intro/
qed.

definition ac_eq (k): ac ≝ mk_ac (eq … k).

lemma ac_eq_props (k): ac_props (ac_eq k) ≝ mk_ac_props ….
#m elim (le_dec m k) #Hm
[ /3 width=3 by or_introl, ex2_intro/
| @or_intror * #n #Hmn #H destruct /2 width=1 by/
]
qed.

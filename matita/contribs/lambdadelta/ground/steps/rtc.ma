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

include "ground/xoa/ex_1_2.ma".
include "ground/notation/functions/tuple_4.ma".
include "ground/notation/functions/zerozero_0.ma".
include "ground/notation/functions/zeroone_0.ma".
include "ground/notation/functions/onezero_0.ma".
include "ground/lib/arith.ma".

(* RT-TRANSITION COUNTER ****************************************************)

record rtc: Type[0] ≝ {
   ri: nat; (* Note: inner r-steps *)
   rs: nat; (* Note: spine r-steps *)
   ti: nat; (* Note: inner t-steps *)
   ts: nat  (* Note: spine t-steps *)
}.

interpretation "constructor (rtc)"
   'Tuple ri rs ti ts = (mk_rtc ri rs ti ts).

interpretation "one structural step (rtc)"
   'ZeroZero = (mk_rtc O O O O).

interpretation "one r-step (rtc)"
   'OneZero = (mk_rtc O (S O) O O).

interpretation "one t-step (rtc)"
   'ZeroOne = (mk_rtc O O O (S O)).

definition rtc_eq_f: relation rtc ≝ λc1,c2. ⊤.

inductive rtc_eq_t: relation rtc ≝
| eq_t_intro: ∀ri1,ri2,rs1,rs2,ti,ts.
              rtc_eq_t (〈ri1,rs1,ti,ts〉) (〈ri2,rs2,ti,ts〉)
.

(* Basic properties *********************************************************)

lemma rtc_eq_t_refl: reflexive …  rtc_eq_t.
* // qed.

(* Basic inversion lemmas ***************************************************)

fact rtc_eq_t_inv_dx_aux:
     ∀x,y. rtc_eq_t x y →
     ∀ri1,rs1,ti,ts. x = 〈ri1,rs1,ti,ts〉 →
     ∃∃ri2,rs2. y = 〈ri2,rs2,ti,ts〉.
#x #y * -x -y
#ri1 #ri #rs1 #rs #ti1 #ts1 #ri2 #rs2 #ti2 #ts2 #H destruct -ri2 -rs2
/2 width=3 by ex1_2_intro/
qed-.

lemma rtc_eq_t_inv_dx:
      ∀ri1,rs1,ti,ts,y. rtc_eq_t (〈ri1,rs1,ti,ts〉) y →
      ∃∃ri2,rs2. y = 〈ri2,rs2,ti,ts〉.
/2 width=5 by rtc_eq_t_inv_dx_aux/ qed-.

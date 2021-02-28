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

(* LOGIC ********************************************************************)

(* NOTE: This file was generated by xoa.native, do not edit *****************)

include "basics/pts.ma".

include "ground/notation/xoa/ex_5_4.ma".

(* Note: multiple existental quantifier (5, 4) *)
inductive ex5_4 (A0,A1,A2,A3:Type[0]) (P0,P1,P2,P3,P4:A0→A1→A2→A3→Prop) : Prop ≝
  | ex5_4_intro: ∀x0,x1,x2,x3. P0 x0 x1 x2 x3 → P1 x0 x1 x2 x3 → P2 x0 x1 x2 x3 → P3 x0 x1 x2 x3 → P4 x0 x1 x2 x3 → ex5_4 ? ? ? ? ? ? ? ? ?
.

interpretation "multiple existental quantifier (5, 4)" 'Ex4 P0 P1 P2 P3 P4 = (ex5_4 ? ? ? ? P0 P1 P2 P3 P4).


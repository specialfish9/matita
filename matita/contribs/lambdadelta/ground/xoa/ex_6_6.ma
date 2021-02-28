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

include "ground/notation/xoa/ex_6_6.ma".

(* Note: multiple existental quantifier (6, 6) *)
inductive ex6_6 (A0,A1,A2,A3,A4,A5:Type[0]) (P0,P1,P2,P3,P4,P5:A0→A1→A2→A3→A4→A5→Prop) : Prop ≝
  | ex6_6_intro: ∀x0,x1,x2,x3,x4,x5. P0 x0 x1 x2 x3 x4 x5 → P1 x0 x1 x2 x3 x4 x5 → P2 x0 x1 x2 x3 x4 x5 → P3 x0 x1 x2 x3 x4 x5 → P4 x0 x1 x2 x3 x4 x5 → P5 x0 x1 x2 x3 x4 x5 → ex6_6 ? ? ? ? ? ? ? ? ? ? ? ?
.

interpretation "multiple existental quantifier (6, 6)" 'Ex6 P0 P1 P2 P3 P4 P5 = (ex6_6 ? ? ? ? ? ? P0 P1 P2 P3 P4 P5).


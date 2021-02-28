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

include "ground/notation/xoa/ex_8_5.ma".

(* Note: multiple existental quantifier (8, 5) *)
inductive ex8_5 (A0,A1,A2,A3,A4:Type[0]) (P0,P1,P2,P3,P4,P5,P6,P7:A0→A1→A2→A3→A4→Prop) : Prop ≝
  | ex8_5_intro: ∀x0,x1,x2,x3,x4. P0 x0 x1 x2 x3 x4 → P1 x0 x1 x2 x3 x4 → P2 x0 x1 x2 x3 x4 → P3 x0 x1 x2 x3 x4 → P4 x0 x1 x2 x3 x4 → P5 x0 x1 x2 x3 x4 → P6 x0 x1 x2 x3 x4 → P7 x0 x1 x2 x3 x4 → ex8_5 ? ? ? ? ? ? ? ? ? ? ? ? ?
.

interpretation "multiple existental quantifier (8, 5)" 'Ex5 P0 P1 P2 P3 P4 P5 P6 P7 = (ex8_5 ? ? ? ? ? P0 P1 P2 P3 P4 P5 P6 P7).


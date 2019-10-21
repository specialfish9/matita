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

(* This file was generated by xoa.native: do not edit *********************)

include "basics/pts.ma".

include "ground_2/notation/xoa/ex_7_8.ma".

(* multiple existental quantifier (7, 8) *)

inductive ex7_8 (A0,A1,A2,A3,A4,A5,A6,A7:Type[0]) (P0,P1,P2,P3,P4,P5,P6:A0→A1→A2→A3→A4→A5→A6→A7→Prop) : Prop ≝
   | ex7_8_intro: ∀x0,x1,x2,x3,x4,x5,x6,x7. P0 x0 x1 x2 x3 x4 x5 x6 x7 → P1 x0 x1 x2 x3 x4 x5 x6 x7 → P2 x0 x1 x2 x3 x4 x5 x6 x7 → P3 x0 x1 x2 x3 x4 x5 x6 x7 → P4 x0 x1 x2 x3 x4 x5 x6 x7 → P5 x0 x1 x2 x3 x4 x5 x6 x7 → P6 x0 x1 x2 x3 x4 x5 x6 x7 → ex7_8 ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?
.

interpretation "multiple existental quantifier (7, 8)" 'Ex8 P0 P1 P2 P3 P4 P5 P6 = (ex7_8 ? ? ? ? ? ? ? ? P0 P1 P2 P3 P4 P5 P6).


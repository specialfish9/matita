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

(* multiple existental quantifier (2, 2) *)

inductive ex2_2 (A0,A1:Type[0]) (P0,P1:A0→A1→Prop) : Prop ≝
   | ex2_2_intro: ∀x0,x1. P0 x0 x1 → P1 x0 x1 → ex2_2 ? ? ? ?
.

interpretation "multiple existental quantifier (2, 2)" 'Ex P0 P1 = (ex2_2 ? ? P0 P1).

(* multiple existental quantifier (3, 1) *)

inductive ex3_1 (A0:Type[0]) (P0,P1,P2:A0→Prop) : Prop ≝
   | ex3_1_intro: ∀x0. P0 x0 → P1 x0 → P2 x0 → ex3_1 ? ? ? ?
.

interpretation "multiple existental quantifier (3, 1)" 'Ex P0 P1 P2 = (ex3_1 ? P0 P1 P2).

(* multiple existental quantifier (3, 2) *)

inductive ex3_2 (A0,A1:Type[0]) (P0,P1,P2:A0→A1→Prop) : Prop ≝
   | ex3_2_intro: ∀x0,x1. P0 x0 x1 → P1 x0 x1 → P2 x0 x1 → ex3_2 ? ? ? ? ?
.

interpretation "multiple existental quantifier (3, 2)" 'Ex P0 P1 P2 = (ex3_2 ? ? P0 P1 P2).

(* multiple existental quantifier (3, 3) *)

inductive ex3_3 (A0,A1,A2:Type[0]) (P0,P1,P2:A0→A1→A2→Prop) : Prop ≝
   | ex3_3_intro: ∀x0,x1,x2. P0 x0 x1 x2 → P1 x0 x1 x2 → P2 x0 x1 x2 → ex3_3 ? ? ? ? ? ?
.

interpretation "multiple existental quantifier (3, 3)" 'Ex P0 P1 P2 = (ex3_3 ? ? ? P0 P1 P2).

(* multiple existental quantifier (4, 3) *)

inductive ex4_3 (A0,A1,A2:Type[0]) (P0,P1,P2,P3:A0→A1→A2→Prop) : Prop ≝
   | ex4_3_intro: ∀x0,x1,x2. P0 x0 x1 x2 → P1 x0 x1 x2 → P2 x0 x1 x2 → P3 x0 x1 x2 → ex4_3 ? ? ? ? ? ? ?
.

interpretation "multiple existental quantifier (4, 3)" 'Ex P0 P1 P2 P3 = (ex4_3 ? ? ? P0 P1 P2 P3).

(* multiple disjunction connective (3) *)

inductive or3 (P0,P1,P2:Prop) : Prop ≝
   | or3_intro0: P0 → or3 ? ? ?
   | or3_intro1: P1 → or3 ? ? ?
   | or3_intro2: P2 → or3 ? ? ?
.

interpretation "multiple disjunction connective (3)" 'Or P0 P1 P2 = (or3 P0 P1 P2).


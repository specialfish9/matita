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

include "ground_2/notation/constructors/nil_0.ma".
include "ground_2/notation/constructors/cons_3.ma".
include "ground_2/notation/functions/append_2.ma".
include "ground_2/lib/arith.ma".

(* LISTS OF PAIRS ***********************************************************)

inductive list2 (A1,A2:Type[0]) : Type[0] :=
  | nil2 : list2 A1 A2
  | cons2: A1 → A2 → list2 A1 A2 → list2 A1 A2.

interpretation "nil (list of pairs)" 'Nil = (nil2 ? ?).

interpretation "cons (list of pairs)" 'Cons hd1 hd2 tl = (cons2 ? ? hd1 hd2 tl).

rec definition append2 (A1,A2:Type[0]) (l1,l2:list2 A1 A2) on l1 ≝ match l1 with
[ nil2           ⇒ l2
| cons2 a1 a2 tl ⇒ {a1, a2} @ append2 A1 A2 tl l2
].

interpretation "append (list of pairs)"
   'Append l1 l2 = (append2 ? ? l1 l2).

rec definition length2 (A1,A2:Type[0]) (l:list2 A1 A2) on l ≝ match l with
[ nil2        ⇒ 0
| cons2 _ _ l ⇒ ⫯(length2 A1 A2 l)
].

interpretation "length (list of pairs)"
   'card l = (length2 ? ? l).

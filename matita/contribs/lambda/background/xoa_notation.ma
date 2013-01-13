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

(* multiple existental quantifier (2, 2) *)

notation > "hvbox(∃∃ ident x0 , ident x1 break . term 19 P0 break & term 19 P1)"
 non associative with precedence 20
 for @{ 'Ex (λ${ident x0}.λ${ident x1}.$P0) (λ${ident x0}.λ${ident x1}.$P1) }.

notation < "hvbox(∃∃ ident x0 , ident x1 break . term 19 P0 break & term 19 P1)"
 non associative with precedence 20
 for @{ 'Ex (λ${ident x0}:$T0.λ${ident x1}:$T1.$P0) (λ${ident x0}:$T0.λ${ident x1}:$T1.$P1) }.

(* multiple existental quantifier (2, 3) *)

notation > "hvbox(∃∃ ident x0 , ident x1 , ident x2 break . term 19 P0 break & term 19 P1)"
 non associative with precedence 20
 for @{ 'Ex (λ${ident x0}.λ${ident x1}.λ${ident x2}.$P0) (λ${ident x0}.λ${ident x1}.λ${ident x2}.$P1) }.

notation < "hvbox(∃∃ ident x0 , ident x1 , ident x2 break . term 19 P0 break & term 19 P1)"
 non associative with precedence 20
 for @{ 'Ex (λ${ident x0}:$T0.λ${ident x1}:$T1.λ${ident x2}:$T2.$P0) (λ${ident x0}:$T0.λ${ident x1}:$T1.λ${ident x2}:$T2.$P1) }.

(* multiple existental quantifier (3, 1) *)

notation > "hvbox(∃∃ ident x0 break . term 19 P0 break & term 19 P1 break & term 19 P2)"
 non associative with precedence 20
 for @{ 'Ex (λ${ident x0}.$P0) (λ${ident x0}.$P1) (λ${ident x0}.$P2) }.

notation < "hvbox(∃∃ ident x0 break . term 19 P0 break & term 19 P1 break & term 19 P2)"
 non associative with precedence 20
 for @{ 'Ex (λ${ident x0}:$T0.$P0) (λ${ident x0}:$T0.$P1) (λ${ident x0}:$T0.$P2) }.

(* multiple existental quantifier (3, 2) *)

notation > "hvbox(∃∃ ident x0 , ident x1 break . term 19 P0 break & term 19 P1 break & term 19 P2)"
 non associative with precedence 20
 for @{ 'Ex (λ${ident x0}.λ${ident x1}.$P0) (λ${ident x0}.λ${ident x1}.$P1) (λ${ident x0}.λ${ident x1}.$P2) }.

notation < "hvbox(∃∃ ident x0 , ident x1 break . term 19 P0 break & term 19 P1 break & term 19 P2)"
 non associative with precedence 20
 for @{ 'Ex (λ${ident x0}:$T0.λ${ident x1}:$T1.$P0) (λ${ident x0}:$T0.λ${ident x1}:$T1.$P1) (λ${ident x0}:$T0.λ${ident x1}:$T1.$P2) }.

(* multiple existental quantifier (3, 3) *)

notation > "hvbox(∃∃ ident x0 , ident x1 , ident x2 break . term 19 P0 break & term 19 P1 break & term 19 P2)"
 non associative with precedence 20
 for @{ 'Ex (λ${ident x0}.λ${ident x1}.λ${ident x2}.$P0) (λ${ident x0}.λ${ident x1}.λ${ident x2}.$P1) (λ${ident x0}.λ${ident x1}.λ${ident x2}.$P2) }.

notation < "hvbox(∃∃ ident x0 , ident x1 , ident x2 break . term 19 P0 break & term 19 P1 break & term 19 P2)"
 non associative with precedence 20
 for @{ 'Ex (λ${ident x0}:$T0.λ${ident x1}:$T1.λ${ident x2}:$T2.$P0) (λ${ident x0}:$T0.λ${ident x1}:$T1.λ${ident x2}:$T2.$P1) (λ${ident x0}:$T0.λ${ident x1}:$T1.λ${ident x2}:$T2.$P2) }.

(* multiple existental quantifier (3, 4) *)

notation > "hvbox(∃∃ ident x0 , ident x1 , ident x2 , ident x3 break . term 19 P0 break & term 19 P1 break & term 19 P2)"
 non associative with precedence 20
 for @{ 'Ex (λ${ident x0}.λ${ident x1}.λ${ident x2}.λ${ident x3}.$P0) (λ${ident x0}.λ${ident x1}.λ${ident x2}.λ${ident x3}.$P1) (λ${ident x0}.λ${ident x1}.λ${ident x2}.λ${ident x3}.$P2) }.

notation < "hvbox(∃∃ ident x0 , ident x1 , ident x2 , ident x3 break . term 19 P0 break & term 19 P1 break & term 19 P2)"
 non associative with precedence 20
 for @{ 'Ex (λ${ident x0}:$T0.λ${ident x1}:$T1.λ${ident x2}:$T2.λ${ident x3}:$T3.$P0) (λ${ident x0}:$T0.λ${ident x1}:$T1.λ${ident x2}:$T2.λ${ident x3}:$T3.$P1) (λ${ident x0}:$T0.λ${ident x1}:$T1.λ${ident x2}:$T2.λ${ident x3}:$T3.$P2) }.

(* multiple existental quantifier (4, 1) *)

notation > "hvbox(∃∃ ident x0 break . term 19 P0 break & term 19 P1 break & term 19 P2 break & term 19 P3)"
 non associative with precedence 20
 for @{ 'Ex (λ${ident x0}.$P0) (λ${ident x0}.$P1) (λ${ident x0}.$P2) (λ${ident x0}.$P3) }.

notation < "hvbox(∃∃ ident x0 break . term 19 P0 break & term 19 P1 break & term 19 P2 break & term 19 P3)"
 non associative with precedence 20
 for @{ 'Ex (λ${ident x0}:$T0.$P0) (λ${ident x0}:$T0.$P1) (λ${ident x0}:$T0.$P2) (λ${ident x0}:$T0.$P3) }.

(* multiple existental quantifier (4, 2) *)

notation > "hvbox(∃∃ ident x0 , ident x1 break . term 19 P0 break & term 19 P1 break & term 19 P2 break & term 19 P3)"
 non associative with precedence 20
 for @{ 'Ex (λ${ident x0}.λ${ident x1}.$P0) (λ${ident x0}.λ${ident x1}.$P1) (λ${ident x0}.λ${ident x1}.$P2) (λ${ident x0}.λ${ident x1}.$P3) }.

notation < "hvbox(∃∃ ident x0 , ident x1 break . term 19 P0 break & term 19 P1 break & term 19 P2 break & term 19 P3)"
 non associative with precedence 20
 for @{ 'Ex (λ${ident x0}:$T0.λ${ident x1}:$T1.$P0) (λ${ident x0}:$T0.λ${ident x1}:$T1.$P1) (λ${ident x0}:$T0.λ${ident x1}:$T1.$P2) (λ${ident x0}:$T0.λ${ident x1}:$T1.$P3) }.

(* multiple existental quantifier (4, 3) *)

notation > "hvbox(∃∃ ident x0 , ident x1 , ident x2 break . term 19 P0 break & term 19 P1 break & term 19 P2 break & term 19 P3)"
 non associative with precedence 20
 for @{ 'Ex (λ${ident x0}.λ${ident x1}.λ${ident x2}.$P0) (λ${ident x0}.λ${ident x1}.λ${ident x2}.$P1) (λ${ident x0}.λ${ident x1}.λ${ident x2}.$P2) (λ${ident x0}.λ${ident x1}.λ${ident x2}.$P3) }.

notation < "hvbox(∃∃ ident x0 , ident x1 , ident x2 break . term 19 P0 break & term 19 P1 break & term 19 P2 break & term 19 P3)"
 non associative with precedence 20
 for @{ 'Ex (λ${ident x0}:$T0.λ${ident x1}:$T1.λ${ident x2}:$T2.$P0) (λ${ident x0}:$T0.λ${ident x1}:$T1.λ${ident x2}:$T2.$P1) (λ${ident x0}:$T0.λ${ident x1}:$T1.λ${ident x2}:$T2.$P2) (λ${ident x0}:$T0.λ${ident x1}:$T1.λ${ident x2}:$T2.$P3) }.

(* multiple disjunction connective (3) *)

notation "hvbox(∨∨ term 29 P0 break | term 29 P1 break | term 29 P2)"
 non associative with precedence 30
 for @{ 'Or $P0 $P1 $P2 }.


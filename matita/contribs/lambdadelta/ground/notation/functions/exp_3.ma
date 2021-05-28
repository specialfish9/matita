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

(* GROUND NOTATION **********************************************************)

notation < "hvbox( f ^ break x )"
  left associative with precedence 65
  for @{ 'Exp $X $f $x }.

notation > "hvbox( f ^ break x )"
  left associative with precedence 65
  for @{ 'Exp ? $f $x }.

notation > "hvbox( f ^{ break term 46 X } break term 65 x )"
  non associative with precedence 65
  for @{ 'Exp $X $f $x }.

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

(* NOTATION FOR DELAYED UPDATING ********************************************)

notation < "hvbox( ↑❨ term 46 k, break term 46 p, break term 46 f ❩ )"
  non associative with precedence 70
  for @{ 'UpArrow $S $k $p $f }.

notation > "hvbox( ↑❨ term 46 k, break term 46 p, break term 46 f ❩ )"
  non associative with precedence 70
  for @{ 'UpArrow ? $k $p $f }.

notation > "hvbox( ↑{ term 46 S }❨ break term 46 k, break term 46 p, break term 46 f ❩ )"
  non associative with precedence 70
  for @{ 'UpArrow $S $k $p $f }.

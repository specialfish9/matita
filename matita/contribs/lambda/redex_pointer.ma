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

include "term.ma".

(* REDEX POINTER ************************************************************)

(* Policy: boolean metavariables: a, b
           pointer metavariables: p, q
*)
(* Note: this is a path in the tree representation of a term
         in which abstraction nodes are omitted;
         on application nodes, "false" means "proceed right"
         and "true" means "proceed left"
*)
definition rptr: Type[0] ≝ list bool.

(* Note: a redex is "in the spine" when is not in the argument of an application *)
definition in_spine: predicate rptr ≝ λp.
                     All … is_false p.

(* Note: precedence relation on redex pointers: p ≺ q
         to serve as base for the order relations: p < q and p ≤ q *)
inductive rpprec: relation rptr ≝
| rpprec_nil : ∀b,q.   rpprec (◊) (b::q)
| rppprc_cons: ∀p,q.   rpprec (false::p) (true::q)
| rpprec_comp: ∀b,p,q. rpprec p q → rpprec (b::p) (b::q)
| rpprec_skip: ∀p,q.   rpprec (false::p) q → rpprec p q
.

interpretation "'precedes' on redex pointers"
   'prec p q = (rpprec p q).

(* Note: this should go to core_notation *)
notation "hvbox(a break ≺ b)"
   non associative with precedence 45
   for @{ 'prec $a $b }.

(* Note: this is p < q *)
definition rplt: relation rptr ≝ TC … rpprec.

interpretation "'less than' on redex pointers"
   'lt p q = (rplt p q).

(* Note: this is p ≤ q *)
definition rple: relation rptr ≝ star … rpprec.

interpretation "'less or equal to' on redex pointers"
   'leq p q = (rple p q).

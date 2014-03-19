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

include "basic_2/relocation/llpx_sn.ma".

(* LAZY SN POINTWISE EXTENSION OF A CONTEXT-SENSITIVE REALTION FOR TERMS ****)

definition llpx_sn_confluent: relation (lenv→relation term) ≝ λR1,R2.
                              ∀L0,T0,T1. R1 L0 T0 T1 → ∀T2. R2 L0 T0 T2 →
                              ∀L1. llpx_sn R1 0 T0 L0 L1 → ∀L2. llpx_sn R2 0 T0 L0 L2 →
                              ∃∃T. R2 L1 T1 T & R1 L2 T2 T.

(* Note: we miss llpx_sn_conf and derivatives: lpr_conf *)

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

include "ground/arith/pnat.ma".
include "delayed_updating/notation/functions/nodelabel_d_1.ma".
include "delayed_updating/notation/functions/edgelabel_l_0.ma".
include "delayed_updating/notation/functions/edgelabel_a_0.ma".
include "delayed_updating/notation/functions/edgelabel_s_0.ma".

(* LABEL ********************************************************************)

inductive label: Type[0] ≝
| label_node_d: pnat → label
| label_edge_L: label
| label_edge_A: label
| label_edge_S: label
.

interpretation
  "variable reference by depth (label)"
  'NodeLabelD p = (label_node_d p).

interpretation
  "name-free functional abstruction (label)"
  'EdgeLabelL = (label_edge_L).

interpretation
  "application (label)"
  'EdgeLabelA = (label_edge_A).

interpretation
  "side branch (label)"
  'EdgeLabelS = (label_edge_S).

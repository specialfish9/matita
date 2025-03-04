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

include "ground/arith/nat_plus.ma".
include "delayed_updating/syntax/path.ma".
include "delayed_updating/notation/functions/sharp_1.ma".

(* HEIGHT FOR PATH **********************************************************)

rec definition height (p) on p: nat ≝
match p with
[ list_empty     ⇒ 𝟎
| list_lcons l q ⇒
  match l with
  [ label_d k ⇒ height q + k
  | label_m   ⇒ height q
  | label_L   ⇒ height q
  | label_A   ⇒ height q
  | label_S   ⇒ height q
  ]
].

interpretation
  "height (path)"
  'Sharp p = (height p).

(* Basic constructions ******************************************************)

lemma height_empty: 𝟎 = ♯𝐞.
// qed.

lemma height_d_dx (p) (k:pnat):
      (♯p)+k = ♯(p◖𝗱k).
// qed.

lemma height_m_dx (p):
      (♯p) = ♯(p◖𝗺).
// qed.

lemma height_L_dx (p):
      (♯p) = ♯(p◖𝗟).
// qed.

lemma height_A_dx (p):
      (♯p) = ♯(p◖𝗔).
// qed.

lemma height_S_dx (p):
      (♯p) = ♯(p◖𝗦).
// qed.

(* Main constructions *******************************************************)

theorem height_append (p) (q):
        (♯p+♯q) = ♯(p●q).
#p #q elim q -q //
* [ #k ] #q #IH <list_append_lcons_sn
[ <height_d_dx <height_d_dx //
| <height_m_dx <height_m_dx //
| <height_L_dx <height_L_dx //
| <height_A_dx <height_A_dx //
| <height_S_dx <height_S_dx //
]
qed.

(* Constructions with path_lcons ********************************************)

lemma height_d_sn (p) (k:pnat):
      k+♯p = ♯(𝗱k◗p).
// qed.

lemma height_m_sn (p):
      ♯p = ♯(𝗺◗p).
// qed.

lemma height_L_sn (p):
      ♯p = ♯(𝗟◗p).
// qed.

lemma height_A_sn (p):
      ♯p = ♯(𝗔◗p).
// qed.

lemma height_S_sn (p):
      ♯p = ♯(𝗦◗p).
// qed.

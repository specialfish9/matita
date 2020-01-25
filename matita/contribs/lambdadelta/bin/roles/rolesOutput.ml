(*
    ||M||  This file is part of HELM, an Hypertextual, Electronic
    ||A||  Library of Mathematics, developed at the Computer Science
    ||T||  Department, University of Bologna, Italy.
    ||I||
    ||T||  HELM is free software; you can redistribute it and/or
    ||A||  modify it under the terms of the GNU General Public License
    \   /  version 2 or (at your option) any later version.
     \ /   This software is distributed as is, NO WARRANTY.
      V_______________________________________________________________ *)

module ET = RolesTypes
module EU = RolesUtils

let indent n =
  String.make (2*n) ' '

let out_tag i tag h map och l =
  let aux och = List.iter (map (succ i) och) l in
  if h then Printf.fprintf och "%s(%s%t)\n" (indent i) tag aux
  else Printf.fprintf och "%s(%s\n%t%s)\n" (indent i) tag aux (indent i)

let string_map f _i och x =
  Printf.fprintf och " %S" (f x)

let out_version i och v =
  out_tag i "ver" true (string_map EU.string_of_version) och [v]

let out_old i och os =
  let map (_,o) = EU.string_of_obj o in
  out_tag i "old" true (string_map map) och os

let out_new i och ns =
  let map (_,n) = EU.string_of_name n in
  out_tag i "new" true (string_map map) och ns

let out_role i och (_,r) =
  let map i och r =
    out_version i och r.ET.v;
    out_old i och r.ET.o;
    out_new i och r.ET.n
  in
  out_tag i "rel" false map och [r]

let out_roles i och rs =
  out_tag i "base" false out_role och rs

let out_status och st =
  let map i och st =
    out_roles i och st.ET.r;
    out_version i och st.ET.s;
    out_old i och st.ET.t;
    out_new i och st.ET.w
  in
  output_string och "roles:";
  out_tag 0 "top" false map och [st]

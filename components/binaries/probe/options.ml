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

module US = NUri.UriSet

let default_objs = US.empty

let default_srcs = US.empty

let default_exclude = []

let default_net = 0

let objs = ref default_objs

let srcs = ref default_srcs

let exclude = ref default_exclude

let net = ref default_net

let no_devel = ref true

let clear () =
   objs := default_objs; srcs := default_srcs;
   exclude := default_exclude; net := default_net

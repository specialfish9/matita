(*
    ||M||  This file is part of HELM, an Hypertextual, Electronic        
    ||A||  Library of Mathematics, developed at the Computer Science     
    ||T||  Department of the University of Bologna, Italy.                     
    ||I||                                                                 
    ||T||  
    ||A||  This file is distributed under the terms of the 
    \   /  GNU General Public License Version 2        
     \ /      
      V_______________________________________________________________ *)

(* Core notation *******************************************************)

notation < "hvbox({ ident i | term 19 p })" with precedence 90
for @{ 'subset (\lambda ${ident i} : $nonexistent . $p)}.

notation > "hvbox({ ident i | term 19 p })" with precedence 90
for @{ 'subset (\lambda ${ident i}. $p)}.

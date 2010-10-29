(* Copyright (C) 2004-2005, HELM Team.
 * 
 * This file is part of HELM, an Hypertextual, Electronic
 * Library of Mathematics, developed at the Computer Science
 * Department, University of Bologna, Italy.
 * 
 * HELM is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 * 
 * HELM is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with HELM; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston,
 * MA  02111-1307, USA.
 * 
 * For details, see the HELM World-Wide-Web page,
 * http://helm.cs.unibo.it/
 *)

exception BaseUriNotSetYet

class type g_status =
 object
  inherit LexiconEngine.g_status
  inherit NCicCoercion.g_status
 end

class status :
 object ('self)
  inherit LexiconEngine.status
  inherit NCicCoercion.status
  method set_grafite_disambiguate_status: #g_status -> 'self
 end

val disambiguate_nterm :
 NCic.term option -> 
 (#status as 'status) ->
 NCic.context -> NCic.metasenv -> NCic.substitution ->
 NotationPt.term Disambiguate.disambiguator_input ->
   NCic.metasenv * NCic.substitution * 'status * NCic.term

val disambiguate_nobj :
 #status as 'status ->
 ?baseuri:string ->
 (NotationPt.term NotationPt.obj) Disambiguate.disambiguator_input ->
  'status * NCic.obj

type pattern = 
  NotationPt.term Disambiguate.disambiguator_input option * 
  (string * NCic.term) list * NCic.term option

val disambiguate_npattern:
  GrafiteAst.npattern Disambiguate.disambiguator_input -> pattern
    


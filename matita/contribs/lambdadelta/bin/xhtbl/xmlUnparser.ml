module A = Array
module F = Filename
module L = List
module P = Printf
module S = String

module O = Options
module T = Table
module M = Matrix

let xhtbl = "xhtbl"

let i = 0

let myself = F.basename (Sys.argv.(0))

let msg = P.sprintf "This file was generated by %s, do not edit" myself

let compose uri ext =
   if uri.[pred (S.length uri)] = '/' then uri else
   try
      let i = S.index uri '#' in
      let uri, fragment = S.sub uri 0 i, S.sub uri i (S.length uri - i) in
      uri ^ ext ^ fragment
   with Not_found -> uri ^ ext

let border cell =
   let str = S.make 4 'n' in
   if cell.M.cb.T.n then str.[0] <- 's';   
   if cell.M.cb.T.e then str.[1] <- 's';
   if cell.M.cb.T.s then str.[2] <- 's';
   if cell.M.cb.T.w then str.[3] <- 's';
   str :: cell.M.cc

let text baseuri ext = function
   | T.Plain s              -> s
   | T.Link (true, uri, s)  -> P.sprintf "<a href=\"%s\">%s</a>" uri s
   | T.Link (false, uri, s) -> 
      let uri = !O.baseuri ^ baseuri ^ compose uri ext in
      P.sprintf "<a href=\"%s\">%s</a>" uri s

let name cell =
   if cell.M.cn = "" then "" else P.sprintf " id=\"%s\"" cell.M.cn

let key cell =
   if cell.M.ck = [] then "<br/>" else S.concat "" (L.map (text cell.M.cu cell.M.cx) cell.M.ck)

let ind i = S.make (2 * i) ' '

let out_cell och cell =
   let cc = xhtbl :: border cell in
   P.fprintf och "%s<td class=\"%s\"%s>%s</td>\n"
      (ind (i+3)) (S.concat " " cc) (name cell) (key cell)

let out_row och row =
   P.fprintf och "%s<tr class=\"%s\">\n" (ind (i+2)) xhtbl;
   A.iter (out_cell och) row;
   P.fprintf och "%s</tr>\n" (ind (i+2))

let out_space och (name, uri) =
   let name = if name = "" then name else ":" ^ name in
   P.fprintf och "                xmlns%s=\"%s\"\n" name uri

(****************************************************************************)

let open_out name spaces =
   let fname = F.concat !O.output_dir (P.sprintf "%s.xsl" name) in
   let spaces = ("xsl", "http://www.w3.org/1999/XSL/Transform") :: spaces in
   let och = open_out fname in
   P.fprintf och "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n\n";
   P.fprintf och "<!-- %s -->\n\n" msg;   
   P.fprintf och "<xsl:stylesheet version=\"1.0\"\n";
   L.iter (out_space och) spaces;
   P.fprintf och ">\n\n";
   och

let output och name matrix =
   P.fprintf och "<xsl:template name=\"%s\">\n" name;
   P.fprintf och "%s<table class=\"%s\" cellpadding=\"4\" cellspacing=\"0\">\n" (ind (i+1)) xhtbl;
   A.iter (out_row och) matrix.M.m;
   P.fprintf och "%s</table>\n" (ind (i+1));
   P.fprintf och "</xsl:template>\n\n"

let close_out och =
   P.fprintf och "</xsl:stylesheet>\n";
   close_out och

let map_incs och name =
   P.fprintf och "<xsl:include href=\"%s.xsl\"/>\n" name

let map_tbls och name =
   P.fprintf och "%s<xsl:when test=\"@name='%s'\">\n" (ind (i+2)) name;
   P.fprintf och "%s<xsl:call-template name=\"%s\"/>\n" (ind (i+3)) name;
   P.fprintf och "%s</xsl:when>\n" (ind (i+2))

let write_hook name incs tbls =
   let och = open_out name [] in
   L.iter (map_incs och) incs;
   P.fprintf och "\n<xsl:template name=\"%s\">\n" name;
   P.fprintf och "%s<xsl:choose>\n" (ind (i+1));
   L.iter (map_tbls och) tbls;   
   P.fprintf och "%s</xsl:choose>\n" (ind (i+1));
   P.fprintf och "</xsl:template>\n\n";
   close_out och

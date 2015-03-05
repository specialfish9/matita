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

(* This file was automatically generated: do not edit *********************)

include "basic_1/wf3/getl.ma".

theorem wf3_pr2_conf:
 \forall (g: G).(\forall (c1: C).(\forall (t1: T).(\forall (t2: T).((pr2 c1 
t1 t2) \to (\forall (c2: C).((wf3 g c1 c2) \to (\forall (u: T).((ty3 g c1 t1 
u) \to (pr2 c2 t1 t2)))))))))
\def
 \lambda (g: G).(\lambda (c1: C).(\lambda (t1: T).(\lambda (t2: T).(\lambda 
(H: (pr2 c1 t1 t2)).(let TMP_1 \def (\lambda (c: C).(\lambda (t: T).(\lambda 
(t0: T).(\forall (c2: C).((wf3 g c c2) \to (\forall (u: T).((ty3 g c t u) \to 
(pr2 c2 t t0)))))))) in (let TMP_2 \def (\lambda (c: C).(\lambda (t3: 
T).(\lambda (t4: T).(\lambda (H0: (pr0 t3 t4)).(\lambda (c2: C).(\lambda (_: 
(wf3 g c c2)).(\lambda (u: T).(\lambda (_: (ty3 g c t3 u)).(pr2_free c2 t3 t4 
H0))))))))) in (let TMP_12 \def (\lambda (c: C).(\lambda (d: C).(\lambda (u: 
T).(\lambda (i: nat).(\lambda (H0: (getl i c (CHead d (Bind Abbr) 
u))).(\lambda (t3: T).(\lambda (t4: T).(\lambda (H1: (pr0 t3 t4)).(\lambda 
(t: T).(\lambda (H2: (subst0 i u t4 t)).(\lambda (c2: C).(\lambda (H3: (wf3 g 
c c2)).(\lambda (u0: T).(\lambda (H4: (ty3 g c t3 u0)).(let H_y \def 
(ty3_sred_pr0 t3 t4 H1 g c u0 H4) in (let H_x \def (ty3_getl_subst0 g c t4 u0 
H_y u t i H2 Abbr d u H0) in (let H5 \def H_x in (let TMP_3 \def (\lambda (w: 
T).(ty3 g d u w)) in (let TMP_4 \def (pr2 c2 t3 t) in (let TMP_11 \def 
(\lambda (x: T).(\lambda (H6: (ty3 g d u x)).(let H_x0 \def (wf3_getl_conf 
Abbr i c d u H0 g c2 H3 x H6) in (let H7 \def H_x0 in (let TMP_7 \def 
(\lambda (d2: C).(let TMP_5 \def (Bind Abbr) in (let TMP_6 \def (CHead d2 
TMP_5 u) in (getl i c2 TMP_6)))) in (let TMP_8 \def (\lambda (d2: C).(wf3 g d 
d2)) in (let TMP_9 \def (pr2 c2 t3 t) in (let TMP_10 \def (\lambda (x0: 
C).(\lambda (H8: (getl i c2 (CHead x0 (Bind Abbr) u))).(\lambda (_: (wf3 g d 
x0)).(pr2_delta c2 x0 u i H8 t3 t4 H1 t H2)))) in (ex2_ind C TMP_7 TMP_8 
TMP_9 TMP_10 H7))))))))) in (ex_ind T TMP_3 TMP_4 TMP_11 
H5))))))))))))))))))))) in (pr2_ind TMP_1 TMP_2 TMP_12 c1 t1 t2 H)))))))).

theorem wf3_pr3_conf:
 \forall (g: G).(\forall (c1: C).(\forall (t1: T).(\forall (t2: T).((pr3 c1 
t1 t2) \to (\forall (c2: C).((wf3 g c1 c2) \to (\forall (u: T).((ty3 g c1 t1 
u) \to (pr3 c2 t1 t2)))))))))
\def
 \lambda (g: G).(\lambda (c1: C).(\lambda (t1: T).(\lambda (t2: T).(\lambda 
(H: (pr3 c1 t1 t2)).(let TMP_1 \def (\lambda (t: T).(\lambda (t0: T).(\forall 
(c2: C).((wf3 g c1 c2) \to (\forall (u: T).((ty3 g c1 t u) \to (pr3 c2 t 
t0))))))) in (let TMP_2 \def (\lambda (t: T).(\lambda (c2: C).(\lambda (_: 
(wf3 g c1 c2)).(\lambda (u: T).(\lambda (_: (ty3 g c1 t u)).(pr3_refl c2 
t)))))) in (let TMP_6 \def (\lambda (t3: T).(\lambda (t4: T).(\lambda (H0: 
(pr2 c1 t4 t3)).(\lambda (t5: T).(\lambda (_: (pr3 c1 t3 t5)).(\lambda (H2: 
((\forall (c2: C).((wf3 g c1 c2) \to (\forall (u: T).((ty3 g c1 t3 u) \to 
(pr3 c2 t3 t5))))))).(\lambda (c2: C).(\lambda (H3: (wf3 g c1 c2)).(\lambda 
(u: T).(\lambda (H4: (ty3 g c1 t4 u)).(let TMP_3 \def (wf3_pr2_conf g c1 t4 
t3 H0 c2 H3 u H4) in (let TMP_4 \def (ty3_sred_pr2 c1 t4 t3 H0 g u H4) in 
(let TMP_5 \def (H2 c2 H3 u TMP_4) in (pr3_sing c2 t3 t4 TMP_3 t5 
TMP_5)))))))))))))) in (pr3_ind c1 TMP_1 TMP_2 TMP_6 t1 t2 H)))))))).

theorem wf3_pc3_conf:
 \forall (g: G).(\forall (c1: C).(\forall (t1: T).(\forall (t2: T).((pc3 c1 
t1 t2) \to (\forall (c2: C).((wf3 g c1 c2) \to (\forall (u1: T).((ty3 g c1 t1 
u1) \to (\forall (u2: T).((ty3 g c1 t2 u2) \to (pc3 c2 t1 t2)))))))))))
\def
 \lambda (g: G).(\lambda (c1: C).(\lambda (t1: T).(\lambda (t2: T).(\lambda 
(H: (pc3 c1 t1 t2)).(\lambda (c2: C).(\lambda (H0: (wf3 g c1 c2)).(\lambda 
(u1: T).(\lambda (H1: (ty3 g c1 t1 u1)).(\lambda (u2: T).(\lambda (H2: (ty3 g 
c1 t2 u2)).(let H3 \def H in (let TMP_1 \def (\lambda (t: T).(pr3 c1 t1 t)) 
in (let TMP_2 \def (\lambda (t: T).(pr3 c1 t2 t)) in (let TMP_3 \def (pc3 c2 
t1 t2) in (let TMP_6 \def (\lambda (x: T).(\lambda (H4: (pr3 c1 t1 
x)).(\lambda (H5: (pr3 c1 t2 x)).(let TMP_4 \def (wf3_pr3_conf g c1 t1 x H4 
c2 H0 u1 H1) in (let TMP_5 \def (wf3_pr3_conf g c1 t2 x H5 c2 H0 u2 H2) in 
(pc3_pr3_t c2 t1 x TMP_4 t2 TMP_5)))))) in (ex2_ind T TMP_1 TMP_2 TMP_3 TMP_6 
H3)))))))))))))))).

theorem wf3_ty3_conf:
 \forall (g: G).(\forall (c1: C).(\forall (t1: T).(\forall (t2: T).((ty3 g c1 
t1 t2) \to (\forall (c2: C).((wf3 g c1 c2) \to (ty3 g c2 t1 t2)))))))
\def
 \lambda (g: G).(\lambda (c1: C).(\lambda (t1: T).(\lambda (t2: T).(\lambda 
(H: (ty3 g c1 t1 t2)).(let TMP_1 \def (\lambda (c: C).(\lambda (t: 
T).(\lambda (t0: T).(\forall (c2: C).((wf3 g c c2) \to (ty3 g c2 t t0)))))) 
in (let TMP_9 \def (\lambda (c: C).(\lambda (t3: T).(\lambda (t: T).(\lambda 
(H0: (ty3 g c t3 t)).(\lambda (H1: ((\forall (c2: C).((wf3 g c c2) \to (ty3 g 
c2 t3 t))))).(\lambda (u: T).(\lambda (t4: T).(\lambda (H2: (ty3 g c u 
t4)).(\lambda (H3: ((\forall (c2: C).((wf3 g c c2) \to (ty3 g c2 u 
t4))))).(\lambda (H4: (pc3 c t4 t3)).(\lambda (c2: C).(\lambda (H5: (wf3 g c 
c2)).(let TMP_2 \def (\lambda (t0: T).(ty3 g c t4 t0)) in (let TMP_3 \def 
(ty3 g c2 u t3) in (let TMP_7 \def (\lambda (x: T).(\lambda (H6: (ty3 g c t4 
x)).(let TMP_4 \def (H1 c2 H5) in (let TMP_5 \def (H3 c2 H5) in (let TMP_6 
\def (wf3_pc3_conf g c t4 t3 H4 c2 H5 x H6 t H0) in (ty3_conv g c2 t3 t TMP_4 
u t4 TMP_5 TMP_6)))))) in (let TMP_8 \def (ty3_correct g c u t4 H2) in 
(ex_ind T TMP_2 TMP_3 TMP_7 TMP_8))))))))))))))))) in (let TMP_10 \def 
(\lambda (c: C).(\lambda (m: nat).(\lambda (c2: C).(\lambda (_: (wf3 g c 
c2)).(ty3_sort g c2 m))))) in (let TMP_21 \def (\lambda (n: nat).(\lambda (c: 
C).(\lambda (d: C).(\lambda (u: T).(\lambda (H0: (getl n c (CHead d (Bind 
Abbr) u))).(\lambda (t: T).(\lambda (H1: (ty3 g d u t)).(\lambda (H2: 
((\forall (c2: C).((wf3 g d c2) \to (ty3 g c2 u t))))).(\lambda (c2: 
C).(\lambda (H3: (wf3 g c c2)).(let H_x \def (wf3_getl_conf Abbr n c d u H0 g 
c2 H3 t H1) in (let H4 \def H_x in (let TMP_13 \def (\lambda (d2: C).(let 
TMP_11 \def (Bind Abbr) in (let TMP_12 \def (CHead d2 TMP_11 u) in (getl n c2 
TMP_12)))) in (let TMP_14 \def (\lambda (d2: C).(wf3 g d d2)) in (let TMP_15 
\def (TLRef n) in (let TMP_16 \def (S n) in (let TMP_17 \def (lift TMP_16 O 
t) in (let TMP_18 \def (ty3 g c2 TMP_15 TMP_17) in (let TMP_20 \def (\lambda 
(x: C).(\lambda (H5: (getl n c2 (CHead x (Bind Abbr) u))).(\lambda (H6: (wf3 
g d x)).(let TMP_19 \def (H2 x H6) in (ty3_abbr g n c2 x u H5 t TMP_19))))) 
in (ex2_ind C TMP_13 TMP_14 TMP_18 TMP_20 H4)))))))))))))))))))) in (let 
TMP_32 \def (\lambda (n: nat).(\lambda (c: C).(\lambda (d: C).(\lambda (u: 
T).(\lambda (H0: (getl n c (CHead d (Bind Abst) u))).(\lambda (t: T).(\lambda 
(H1: (ty3 g d u t)).(\lambda (H2: ((\forall (c2: C).((wf3 g d c2) \to (ty3 g 
c2 u t))))).(\lambda (c2: C).(\lambda (H3: (wf3 g c c2)).(let H_x \def 
(wf3_getl_conf Abst n c d u H0 g c2 H3 t H1) in (let H4 \def H_x in (let 
TMP_24 \def (\lambda (d2: C).(let TMP_22 \def (Bind Abst) in (let TMP_23 \def 
(CHead d2 TMP_22 u) in (getl n c2 TMP_23)))) in (let TMP_25 \def (\lambda 
(d2: C).(wf3 g d d2)) in (let TMP_26 \def (TLRef n) in (let TMP_27 \def (S n) 
in (let TMP_28 \def (lift TMP_27 O u) in (let TMP_29 \def (ty3 g c2 TMP_26 
TMP_28) in (let TMP_31 \def (\lambda (x: C).(\lambda (H5: (getl n c2 (CHead x 
(Bind Abst) u))).(\lambda (H6: (wf3 g d x)).(let TMP_30 \def (H2 x H6) in 
(ty3_abst g n c2 x u H5 t TMP_30))))) in (ex2_ind C TMP_24 TMP_25 TMP_29 
TMP_31 H4)))))))))))))))))))) in (let TMP_38 \def (\lambda (c: C).(\lambda 
(u: T).(\lambda (t: T).(\lambda (H0: (ty3 g c u t)).(\lambda (H1: ((\forall 
(c2: C).((wf3 g c c2) \to (ty3 g c2 u t))))).(\lambda (b: B).(\lambda (t3: 
T).(\lambda (t4: T).(\lambda (_: (ty3 g (CHead c (Bind b) u) t3 t4)).(\lambda 
(H3: ((\forall (c2: C).((wf3 g (CHead c (Bind b) u) c2) \to (ty3 g c2 t3 
t4))))).(\lambda (c2: C).(\lambda (H4: (wf3 g c c2)).(let TMP_33 \def (H1 c2 
H4) in (let TMP_34 \def (Bind b) in (let TMP_35 \def (CHead c2 TMP_34 u) in 
(let TMP_36 \def (wf3_bind g c c2 H4 u t H0 b) in (let TMP_37 \def (H3 TMP_35 
TMP_36) in (ty3_bind g c2 u t TMP_33 b t3 t4 TMP_37)))))))))))))))))) in (let 
TMP_41 \def (\lambda (c: C).(\lambda (w: T).(\lambda (u: T).(\lambda (_: (ty3 
g c w u)).(\lambda (H1: ((\forall (c2: C).((wf3 g c c2) \to (ty3 g c2 w 
u))))).(\lambda (v: T).(\lambda (t: T).(\lambda (_: (ty3 g c v (THead (Bind 
Abst) u t))).(\lambda (H3: ((\forall (c2: C).((wf3 g c c2) \to (ty3 g c2 v 
(THead (Bind Abst) u t)))))).(\lambda (c2: C).(\lambda (H4: (wf3 g c 
c2)).(let TMP_39 \def (H1 c2 H4) in (let TMP_40 \def (H3 c2 H4) in (ty3_appl 
g c2 w u TMP_39 v t TMP_40)))))))))))))) in (let TMP_44 \def (\lambda (c: 
C).(\lambda (t3: T).(\lambda (t4: T).(\lambda (_: (ty3 g c t3 t4)).(\lambda 
(H1: ((\forall (c2: C).((wf3 g c c2) \to (ty3 g c2 t3 t4))))).(\lambda (t0: 
T).(\lambda (_: (ty3 g c t4 t0)).(\lambda (H3: ((\forall (c2: C).((wf3 g c 
c2) \to (ty3 g c2 t4 t0))))).(\lambda (c2: C).(\lambda (H4: (wf3 g c 
c2)).(let TMP_42 \def (H1 c2 H4) in (let TMP_43 \def (H3 c2 H4) in (ty3_cast 
g c2 t3 t4 TMP_42 t0 TMP_43))))))))))))) in (ty3_ind g TMP_1 TMP_9 TMP_10 
TMP_21 TMP_32 TMP_38 TMP_41 TMP_44 c1 t1 t2 H))))))))))))).


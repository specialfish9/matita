(*
    ||M||  This file is part of HELM, an Hypertextual, Electronic   
    ||A||  Library of Mathematics, developed at the Computer Science 
    ||T||  Department of the University of Bologna, Italy.           
    ||I||                                                            
    ||T||  
    ||A||  
    \   /  This file is distributed under the terms of the       
     \ /   GNU General Public License Version 2   
      V_____________________________________________________________*)


(* COMPARE BIT

*)

include "turing/universal/tuples.ma".

definition write_states ≝ initN 2.

definition write ≝ λalpha,c.
  mk_TM alpha write_states
  (λp.let 〈q,a〉 ≝ p in
    match q with 
    [ O ⇒ 〈1,Some ? 〈c,N〉〉
    | S _ ⇒ 〈1,None ?〉 ])
  O (λx.x == 1).
  
definition R_write ≝ λalpha,c,t1,t2.
  ∀ls,x,rs.t1 = midtape alpha ls x rs → t2 = midtape alpha ls c rs.
  
axiom sem_write : ∀alpha,c.Realize ? (write alpha c) (R_write alpha c).

definition copy_step_subcase ≝
  λalpha,c,elseM.ifTM ? (test_char ? (λx.x == 〈c,true〉))
    (seq (FinProd alpha FinBool) (adv_mark_r …)
      (seq ? (move_l …)
        (seq ? (adv_to_mark_l … (is_marked alpha))
          (seq ? (write ? 〈c,false〉)
            (seq ? (move_r …)
              (seq ? (mark …)
                (seq ? (move_r …) (adv_to_mark_r … (is_marked alpha)))))))))
    elseM tc_true.

definition R_copy_step_subcase ≝ 
  λalpha,c,RelseM,t1,t2.
    ∀ls,x,rs.t1 = midtape (FinProd … alpha FinBool) ls 〈x,true〉 rs → 
    (x = c ∧
     ∀a,l1,x0,a0,l2,l3. (∀c.memb ? c l1 = true → is_marked ? c = false) → 
     ls = l1@〈a0,false〉::〈x0,true〉::l2 → 
     rs = 〈a,false〉::l3 → 
     t2 = midtape ? (〈x,false〉::l1@〈a0,true〉::〈x,false〉::l2) 〈a,true〉 l3) ∨
    (x ≠ c ∧ RelseM t1 t2).
    
axiom sem_copy_step_subcase : 
  ∀alpha,c,elseM,RelseM.
  Realize ? (copy_step_subcase alpha c elseM) (R_copy_step_subcase alpha c RelseM).
    
(*
if current = 0,tt
   then advance_mark_r;
        move_l;
        advance_to_mark_l;
        write(0,ff)
        move_r;
        mark;
        move_r;
        advance_to_mark_r;
else if current = 1,tt
   then advance_mark_r;
        move_l;
        advance_to_mark_l;
        write(1,ff)
        move_r;
        mark;
        move_r;
        advance_to_mark_r;
else nop
*)

definition copy_step ≝
  ifTM ? (test_char STape (λc.is_bit (\fst c)))
  (single_finalTM ? (copy_step_subcase FSUnialpha (bit false)
    (copy_step_subcase FSUnialpha (bit true) (nop ?))))
  (nop ?)
  tc_true.
  
definition R_copy_step_true ≝ 
  λt1,t2.
    ∀ls,c,rs.t1 = midtape (FinProd … FSUnialpha FinBool) ls 〈c,true〉 rs → 
    ∃x. c = bit x ∧
    (∀a,l1,c0,a0,l2,l3. (∀y.memb ? y l1 = true → is_marked ? y = false) → 
     ls = l1@〈a0,false〉::〈c0,true〉::l2 → 
     rs = 〈a,false〉::l3 → 
     t2 = midtape STape (〈bit x,false〉::l1@〈a0,true〉::〈bit x,false〉::l2) 〈a,true〉 l3).

definition R_copy_step_false ≝ 
  λt1,t2.
   ∀ls,c,rs.t1 = midtape (FinProd … FSUnialpha FinBool) ls c rs → 
   is_bit (\fst c) = false ∧ t2 = t1.

axiom sem_comp_step : 
  accRealize ? copy_step (inr … (inl … (inr … 0))) R_copy_step_true R_copy_step_false.
   
definition copy ≝ whileTM ? copy_step (inr … (inl … (inr … 0))).

definition R_copy ≝ λt1,t2.
  ∀ls,c,rs.t1 = midtape ? ls 〈c,true〉 rs → 
  (∀l1,d,l2,l3,l4.
   〈c,false〉::rs = l1@〈d,false〉::l2 → only_bits l1 → is_bit d = false → 
   ls = l3@l4@〈c0,true〉::l5 → |l4| = |l1@[〈d,false〉]|
  
  

axiom no_grids_in_table: ∀n.∀l.table_TM n l → no_grids l.
(*
l0 x* a l1 x0* a0 l2 ------> l0 x a* l1 x0 a0* l2
   ^                               ^

if current (* x *) = #
   then 
   else if x = 0
      then move_right; ----
           adv_to_mark_r;
           if current (* x0 *) = 0
              then advance_mark ----
                   adv_to_mark_l;
                   advance_mark
              else STOP
      else x = 1 (* analogo *)

*)


(*
   MARK NEXT TUPLE machine
   (partially axiomatized)
   
   marks the first character after the first bar (rightwards)
 *)
 
definition bar_or_grid ≝ λc:STape.is_bar (\fst c) ∨ is_grid (\fst c).

definition mark_next_tuple ≝ 
  seq ? (adv_to_mark_r ? bar_or_grid)
     (ifTM ? (test_char ? (λc:STape.is_bar (\fst c)))
       (move_right_and_mark ?) (nop ?) 1).

definition R_mark_next_tuple ≝ 
  λt1,t2.
    ∀ls,c,rs1,rs2.
    (* c non può essere un separatore ... speriamo *)
    t1 = midtape STape ls c (rs1@〈grid,false〉::rs2) → 
    no_marks rs1 → no_grids rs1 → bar_or_grid c = false → 
    (∃rs3,rs4,d,b.rs1 = rs3 @ 〈bar,false〉 :: rs4 ∧
      no_bars rs3 ∧
      Some ? 〈d,b〉 = option_hd ? (rs4@〈grid,false〉::rs2) ∧
      t2 = midtape STape (〈bar,false〉::reverse ? rs3@c::ls) 〈d,true〉 (tail ? (rs4@〈grid,false〉::rs2)))
    ∨
    (no_bars rs1 ∧ t2 = midtape ? (reverse ? rs1@c::ls) 〈grid,false〉 rs2).
     
axiom tech_split :
  ∀A:DeqSet.∀f,l.
   (∀x.memb A x l = true → f x = false) ∨
   (∃l1,c,l2.f c = true ∧ l = l1@c::l2 ∧ ∀x.memb ? x l1 = true → f x = false).
(*#A #f #l elim l
[ % #x normalize #Hfalse *)
     
theorem sem_mark_next_tuple :
  Realize ? mark_next_tuple R_mark_next_tuple.
#intape 
lapply (sem_seq ? (adv_to_mark_r ? bar_or_grid)
         (ifTM ? (test_char ? (λc:STape.is_bar (\fst c))) (move_right_and_mark ?) (nop ?) 1) ????)
[@sem_if [5: // |6: @sem_move_right_and_mark |7: // |*:skip]
| //
|||#Hif cases (Hif intape) -Hif
   #j * #outc * #Hloop * #ta * #Hleft #Hright
   @(ex_intro ?? j) @ex_intro [|% [@Hloop] ]
   -Hloop
   #ls #c #rs1 #rs2 #Hrs #Hrs1 #Hrs1' #Hc
   cases (Hleft … Hrs)
   [ * #Hfalse >Hfalse in Hc; #Htf destruct (Htf)
   | * #_ #Hta cases (tech_split STape (λc.is_bar (\fst c)) rs1)
     [ #H1 lapply (Hta rs1 〈grid,false〉 rs2 (refl ??) ? ?)
       [ * #x #b #Hx whd in ⊢ (??%?); >(Hrs1' … Hx) >(H1 … Hx) %
       | %
       | -Hta #Hta cases Hright
         [ * #tb * whd in ⊢ (%→?); #Hcurrent
           @False_ind cases (Hcurrent 〈grid,false〉 ?)
           [ normalize #Hfalse destruct (Hfalse)
           | >Hta % ]
         | * #tb * whd in ⊢ (%→?); #Hcurrent
           cases (Hcurrent 〈grid,false〉 ?)
           [  #_ #Htb whd in ⊢ (%→?); #Houtc
             %2 %
             [ @H1
             | >Houtc >Htb >Hta % ]
           | >Hta % ]
         ]
       ]
    | * #rs3 * #c0 * #rs4 * * #Hc0 #Hsplit #Hrs3
      % @(ex_intro ?? rs3) @(ex_intro ?? rs4)
     lapply (Hta rs3 c0 (rs4@〈grid,false〉::rs2) ???)
     [ #x #Hrs3' whd in ⊢ (??%?); >Hsplit in Hrs1;>Hsplit in Hrs3;
       #Hrs3 #Hrs1 >(Hrs1 …) [| @memb_append_l1 @Hrs3'|]
       >(Hrs3 … Hrs3') @Hrs1' >Hsplit @memb_append_l1 //
     | whd in ⊢ (??%?); >Hc0 %
     | >Hsplit >associative_append % ] -Hta #Hta
       cases Hright
       [ * #tb * whd in ⊢ (%→?); #Hta'
         whd in ⊢ (%→?); #Htb
         cases (Hta' c0 ?)
         [ #_ #Htb' >Htb' in Htb; #Htb
           generalize in match Hsplit; -Hsplit
           cases rs4 in Hta;
           [ #Hta #Hsplit >(Htb … Hta)
             >(?:c0 = 〈bar,false〉)
             [ @(ex_intro ?? grid) @(ex_intro ?? false)
               % [ % [ % 
               [(* Hsplit *) @daemon |(*Hrs3*) @daemon ] | % ] | % ] 
               | (* Hc0 *) @daemon ]
           | #r5 #rs5 >(eq_pair_fst_snd … r5)
             #Hta #Hsplit >(Htb … Hta)
             >(?:c0 = 〈bar,false〉)
             [ @(ex_intro ?? (\fst r5)) @(ex_intro ?? (\snd r5))
               % [ % [ % [ (* Hc0, Hsplit *) @daemon | (*Hrs3*) @daemon ] | % ]
                     | % ] | (* Hc0 *) @daemon ] ] | >Hta % ]
             | * #tb * whd in ⊢ (%→?); #Hta'
               whd in ⊢ (%→?); #Htb
               cases (Hta' c0 ?)
               [ #Hfalse @False_ind >Hfalse in Hc0;
                 #Hc0 destruct (Hc0)
               | >Hta % ]
]]]]
qed.

definition init_current ≝ 
  seq ? (adv_to_mark_l ? (is_marked ?))
    (seq ? (clear_mark ?)
       (seq ? (adv_to_mark_l ? (λc:STape.is_grid (\fst c)))
          (seq ? (move_r ?) (mark ?)))).
          
definition R_init_current ≝ λt1,t2.
  ∀l1,c,l2,b,l3,c1,rs,c0,b0. no_marks l1 → no_grids l2 → is_grid c = false → 
  Some ? 〈c0,b0〉 = option_hd ? (reverse ? (〈c,true〉::l2)) → 
  t1 = midtape STape (l1@〈c,true〉::l2@〈grid,b〉::l3) 〈c1,false〉 rs → 
  t2 = midtape STape (〈grid,b〉::l3) 〈c0,true〉
        ((tail ? (reverse ? (l1@〈c,false〉::l2))@〈c1,false〉::rs)).

lemma sem_init_current : Realize ? init_current R_init_current.
#intape 
cases (sem_seq ????? (sem_adv_to_mark_l ? (is_marked ?))
        (sem_seq ????? (sem_clear_mark ?)
           (sem_seq ????? (sem_adv_to_mark_l ? (λc:STape.is_grid (\fst c)))
             (sem_seq ????? (sem_move_r ?) (sem_mark ?)))) intape)
#k * #outc * #Hloop #HR 
@(ex_intro ?? k) @(ex_intro ?? outc) % [@Hloop]
cases HR -HR #ta * whd in ⊢ (%→?); #Hta 
* #tb * whd in ⊢ (%→?); #Htb 
* #tc * whd in ⊢ (%→?); #Htc 
* #td * whd in ⊢ (%→%→?); #Htd #Houtc
#l1 #c #l2 #b #l3 #c1 #rs #c0 #b0 #Hl1 #Hl2 #Hc #Hc0 #Hintape
cases (Hta … Hintape) [ * #Hfalse normalize in Hfalse; destruct (Hfalse) ]
-Hta * #_ #Hta lapply (Hta l1 〈c,true〉 ? (refl ??) ??) [@Hl1|%]
-Hta #Hta lapply (Htb … Hta) -Htb #Htb cases (Htc … Htb) [ >Hc -Hc * #Hc destruct (Hc) ] 
-Htc * #_ #Htc lapply (Htc … (refl ??) (refl ??) ?) [@Hl2]
-Htc #Htc lapply (Htd … Htc) -Htd
>reverse_append >reverse_cons 
>reverse_cons in Hc0; cases (reverse … l2)
[ normalize in ⊢ (%→?); #Hc0 destruct (Hc0)
  #Htd >(Houtc … Htd) %
| * #c2 #b2 #tl2 normalize in ⊢ (%→?);
  #Hc0 #Htd >(Houtc … Htd)
  whd in ⊢ (???%); destruct (Hc0)
  >associative_append >associative_append %
]
qed.

definition match_tuple_step ≝ 
  ifTM ? (test_char ? (λc:STape.¬ is_grid (\fst c))) 
   (single_finalTM ? 
     (seq ? compare
      (ifTM ? (test_char ? (λc:STape.is_grid (\fst c)))
        (nop ?)
        (seq ? mark_next_tuple 
           (ifTM ? (test_char ? (λc:STape.is_grid (\fst c)))
             (mark ?) (seq ? (move_l ?) init_current) tc_true)) tc_true)))
    (nop ?) tc_true.

definition R_match_tuple_step_true ≝ λt1,t2.
  ∀ls,c,l1,l2,c1,l3,l4,rs,n.
  is_bit c = true → only_bits l1 → no_grids l2 → is_bit c1 = true →
  only_bits l3 → n = |l1| → |l1| = |l3| →
  table_TM (S n) (〈c1,true〉::l3@〈comma,false〉::l4) → 
  t1 = midtape STape (〈grid,false〉::ls) 〈c,true〉 
         (l1@〈grid,false〉::l2@〈bar,false〉::〈c1,true〉::l3@〈comma,false〉::l4@〈grid,false〉::rs) → 
  (* facciamo match *)
  (〈c,false〉::l1 = 〈c1,false〉::l3 ∧
  t2 = midtape ? (reverse ? l1@〈c,false〉::〈grid,false〉::ls) 〈grid,false〉
        (l2@〈bar,false〉::〈c1,false〉::l3@〈comma,true〉::l4@〈grid,false〉::rs))
  ∨
  (* non facciamo match e marchiamo la prossima tupla *)
  ((〈c,false〉::l1 ≠ 〈c1,false〉::l3 ∧
   ∃c2,l5,l6,l7.l4 = l5@〈bar,false〉::〈c2,false〉::l6@〈comma,false〉::l7 ∧
   (* condizioni su l5 l6 l7 *)
   t2 = midtape STape (〈grid,false〉::ls) 〈c,true〉 
         (l1@〈grid,false〉::l2@〈bar,false〉::〈c1,true〉::l3@〈comma,false〉::
          l5@〈bar,false〉::〈c2,true〉::l6@〈comma,false〉::l7))
  ∨  
  (* non facciamo match e non c'è una prossima tupla:
     non specifichiamo condizioni sul nastro di output, perché
     non eseguiremo altre operazioni, quindi il suo formato non ci interessa *)
  (〈c,false〉::l1 ≠ 〈c1,false〉::l3 ∧ no_bars l4 ∧ current ? t2 = Some ? 〈grid,true〉)).  
  
definition R_match_tuple_step_false ≝ λt1,t2.
  ∀ls,c,rs.t1 = midtape STape ls c rs → is_grid (\fst c) = true ∧ t2 = t1.
  
include alias "basics/logic.ma". 

(*
lemma eq_f4: ∀A1,A2,A3,A4,B.∀f:A1 → A2 →A3 →A4 →B.
  ∀x1,x2,x3,x4,y1,y2,y3,y4. x1 = y1 → x2 = y2 →x3=y3 →x4 = y4 →   
    f x1 x2 x3 x4 = f y1 y2 y3 y4.
//
qed-. *)

lemma some_option_hd: ∀A.∀l:list A.∀a.∃b.
  Some ? b = option_hd ? (l@[a]) .
#A #l #a cases l normalize /2/
qed.

lemma bit_not_grid: ∀d. is_bit d = true → is_grid d = false.
* // normalize #H destruct
qed.

lemma bit_not_bar: ∀d. is_bit d = true → is_bar d = false.
* // normalize #H destruct
qed.

axiom sem_match_tuple_step: 
    accRealize ? match_tuple_step (inr … (inl … (inr … 0))) 
    R_match_tuple_step_true R_match_tuple_step_false.
(* @(acc_sem_if_app … (sem_test_char ? (λc:STape.¬ is_grid (\fst c))) …
  (sem_seq … sem_compare
    (sem_if … (sem_test_char ? (λc:STape.is_grid (\fst c)))
      (sem_nop …)
        (sem_seq … sem_mark_next_tuple 
           (sem_if … (sem_test_char ? (λc:STape.is_grid (\fst c)))
             (sem_mark ?) (sem_seq … (sem_move_l …) (sem_init_current …))))))
  (sem_nop ?) …)
[(* is_grid: termination case *)
 2:#t1 #t2 #t3 whd in ⊢ (%→?); #H #H1 whd #ls #c #rs #Ht1
  cases (H c ?) [2: >Ht1 %] #Hgrid #Heq %
    [@injective_notb @Hgrid | <Heq @H1]
|#tapea #tapeout #tapeb whd in ⊢ (%→?); #Htapea
 * #tapec * #Hcompare #Hor 
 #ls #c #l1 #l2 #c1 #l3 #l4 #rs #n #Hc #Hl1 #Hl2 #Hc1 #Hl3 #eqn
 #eqlen #Htable #Htapea1 cases (Htapea 〈c,true〉 ?) >Htapea1 [2:%]
 #notgridc -Htapea -Htapea1 -tapea #Htapeb  
 cases (Hcompare … Htapeb) -Hcompare -Htapeb * #_ #_ #Hcompare 
 cases (Hcompare c c1 l1 l3 (l2@[〈bar,false〉]) (l4@〈grid,false〉::rs) eqlen … (refl …) Hc ?)  
 -Hcompare 
   [* #Htemp destruct (Htemp) #Htapec %1 % [%]
    >Htapec in Hor; -Htapec *
     [2: * #t3 * whd in ⊢ (%→?); #H @False_ind
      cases (H … (refl …)) whd in ⊢ ((??%?)→?); #H destruct (H)
     |* #taped * whd in ⊢ (%→?); #Htaped cases (Htaped ? (refl …)) -Htaped *
      #Htaped whd in ⊢ (%→?); #Htapeout >Htapeout >Htaped >associative_append
      %
     ]
   |* #la * #c' * #d' * #lb * #lc * * * #H1 #H2 #H3 #Htapec 
    cut (〈c,false〉::l1 ≠ 〈c1,false〉::l3) 
      [>H2 >H3 elim la
        [@(not_to_not …H1) normalize #H destruct % 
        |#x #tl @not_to_not normalize #H destruct // 
        ]
      ] #Hnoteq %2
    cut (is_bit d' = true) 
      [cases la in H3;
        [normalize in ⊢ (%→?); #H destruct //
        |#x #tl #H @(Hl3 〈d',false〉)
         normalize in H; destruct @memb_append_l2 @memb_hd
        ] 
      ] #Hd'
    >Htapec in Hor; -Htapec *
     [* #taped * whd in ⊢ (%→?); #H @False_ind
      cases (H … (refl …)) >Hd' #Htemp destruct (Htemp)
     |* #taped * whd in ⊢ (%→?); #H cases (H … (refl …)) -H #_
      #Htaped * #tapee * whd in ⊢ (%→?); #Htapee  
      <(associative_append ? lc (〈comma,false〉::l4)) in Htaped; #Htaped
      lapply (Htapee … Htaped ???) -Htaped -Htapee 
       [whd in ⊢ (??%?); >(bit_not_grid … Hd') >(bit_not_bar … Hd') %
       |#x #Hx cases (memb_append … Hx) 
         [-Hx #Hx @bit_not_grid @Hl3 cases la in H3; normalize 
           [#H3 destruct (H3) @Hx | #y #tl #H3 destruct (H3) 
            @memb_append_l2 @memb_cons @Hx ]
         |-Hx #Hx @(no_grids_in_table … Htable) 
          @memb_cons @memb_append_l2 @Hx
         ]
       |@daemon (* TODO *)
       |* 
         [* #rs3 * * (* we proceed by cases on rs4 *) 
           [* #d * #b * * * #Heq1 #Hnobars
            whd in ⊢ ((???%)→?); #Htemp destruct (Htemp)
            #Htapee * 
             [* #tapef * whd in ⊢ (%→?); >Htapee -Htapee #Htapef 
              cases (Htapef … (refl …)) -Htapef #_ #Htapef >Htapef -Htapef
              whd in ⊢ (%→?); #H lapply (H … ???? (refl …)) #Htapeout
              %1 %
              [ //| @daemon]
              | >Htapeout %
              ]
           |* #tapef * whd in ⊢ (%→?); >Htapee -Htapee #Htapef
            cases (Htapef … (refl …)) whd in ⊢ ((??%?)→?); #Htemp destruct (Htemp)
           ]
         |* #d2 #b2 #rs3' * #d  * #b * * * #Heq1 #Hnobars
          cut (is_grid d2 = false) [@daemon (* ??? *)] #Hd2
          whd in ⊢ ((???%)→?); #Htemp destruct (Htemp) #Htapee >Htapee -Htapee *
           [* #tapef * whd in ⊢ (%→?); #Htapef 
            cases (Htapef … (refl …)) >Hd2 #Htemp destruct (Htemp) 
           |* #tapef * whd in ⊢ (%→?); #Htapef 
            cases (Htapef … (refl …)) #_ -Htapef #Htapef
            * #tapeg >Htapef -Htapef * whd in ⊢ (%→?); 
            #H lapply (H … (refl …)) whd in ⊢ (???%→?); -H  #Htapeg
            >Htapeg -Htapeg whd in ⊢ (%→?); #Htapeout
            %1 cases (some_option_hd ? (reverse ? (reverse ? la)) 〈c',true〉)
            * #c00 #b00 #Hoption
            lapply 
             (Htapeout (reverse ? rs3 @〈d',false〉::reverse ? la@reverse ? (l2@[〈bar,false〉])@(〈grid,false〉::reverse ? lb))
             c' (reverse ? la) false ls bar (〈d2,true〉::rs3'@〈grid,false〉::rs) c00 b00 ?????) -Htapeout
              [whd in ⊢ (??(??%??)?); @eq_f3 [2:%|3: %]
               >associative_append 
               generalize in match (〈c',true〉::reverse ? la@〈grid,false〉::ls); #l
               whd in ⊢ (???(???%)); >associative_append >associative_append 
               % 
              |@daemon 
              |@daemon
              |@daemon
              |@daemon
              |@daemon
              ]
           ]
         ]
       |* #Hnobars #Htapee >Htapee -Htapee *
         [whd in ⊢ (%→?); * #tapef * whd in ⊢ (%→?); #Htapef
          cases (Htapef … (refl …)) -Htapef #_ #Htapef >Htapef -Htapef
          whd in ⊢ (%→?); #Htapeout %2
          >(Htapeout … (refl …)) %
           [ % 
             [ @daemon 
             | @daemon
             ]
           | %
           ] 
         |whd in ⊢ (%→?); * #tapef * whd in ⊢ (%→?); #Htapef
          cases (Htapef … (refl …)) -Htapef 
          whd in ⊢ ((??%?)→?); #Htemp destruct (Htemp) 
         ]
       |
           
           
      
      
   
  
  ????? (refl …) Hc ?) -Hcompare 
 #Hcompare 
  is_bit c = true → only_bits l1 → no_grids l2 → is_bit c1 = true →
  only_bits l3 → n = |l2| → |l2| = |l3| →
  table_TM (S n) (〈c1,true〉::l3@〈comma,false〉::l4) →#x

  #intape
cases 
  (acc_sem_if … (sem_test_char ? (λc:STape.¬ is_grid (\fst c))) 
    (sem_seq … sem_compare
      (sem_if … (sem_test_char ? (λc:STape.is_grid (\fst c)))
        (sem_nop …)
        (sem_seq … sem_mark_next_tuple 
           (sem_if … (sem_test_char ? (λc:STape.is_grid (\fst c)))
             (sem_mark ?) (sem_seq … (sem_move_l …) (sem_init_current …))))))
    (sem_nop ?) intape)
#k * #outc * * #Hloop #H1 #H2
@(ex_intro ?? k) @(ex_intro ?? outc) %
[ % [@Hloop ] ] -Hloop
  *)

(* 
  MATCH TUPLE

  scrolls through the tuples in the transition table until one matching the
  current configuration is found
*)

definition match_tuple ≝  whileTM ? match_tuple_step (inr … (inl … (inr … 0))).

definition R_match_tuple ≝ λt1,t2.
  ∀ls,c,l1,c1,l2,rs,n.
  is_bit c = true → only_bits l1 → is_bit c1 = true → n = |l1| →
  table_TM (S n) (〈c1,true〉::l2) → 
  t1 = midtape STape (〈grid,false〉::ls) 〈c,true〉 
         (l1@〈grid,false〉::〈c1,true〉::l2@〈grid,false〉::rs) → 
  (* facciamo match *)
  (∃l3,newc,mv,l4.
   〈c1,false〉::l2 = l3@〈c,false〉::l1@〈comma,false〉::newc@〈comma,false〉::mv@l4 ∧
   t2 = midtape ? (reverse ? l1@〈c,false〉::〈grid,false〉::ls) 〈grid,false〉
        (l3@〈c,false〉::l1@〈comma,true〉::newc@〈comma,false〉::mv@l4@〈grid,false〉::rs))
  ∨
  (* non facciamo match su nessuna tupla;
     non specifichiamo condizioni sul nastro di output, perché
     non eseguiremo altre operazioni, quindi il suo formato non ci interessa *)
  (current ? t2 = Some ? 〈grid,true〉 ∧
   ∀l3,newc,mv,l4.
   〈c1,false〉::l2 ≠ l3@〈c,false〉::l1@〈comma,false〉::newc@〈comma,false〉::mv@l4).  

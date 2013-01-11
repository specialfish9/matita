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

include "turing/multi_universal/moves.ma".
include "turing/if_multi.ma".
include "turing/inject.ma".
include "turing/basic_machines.ma".

definition compare_states ≝ initN 3.

definition comp0 : compare_states ≝ mk_Sig ?? 0 (leb_true_to_le 1 3 (refl …)).
definition comp1 : compare_states ≝ mk_Sig ?? 1 (leb_true_to_le 2 3 (refl …)).
definition comp2 : compare_states ≝ mk_Sig ?? 2 (leb_true_to_le 3 3 (refl …)).

(*

0) (x,x) → (x,x)(R,R) → 1
   (x,y≠x) → None 2
1) (_,_) → None 1
2) (_,_) → None 2

*)

definition trans_compare_step ≝ 
 λi,j.λsig:FinSet.λn.
 λp:compare_states × (Vector (option sig) (S n)).
 let 〈q,a〉 ≝ p in
 match pi1 … q with
 [ O ⇒ match nth i ? a (None ?) with
   [ None ⇒ 〈comp2,null_action sig n〉
   | Some ai ⇒ match nth j ? a (None ?) with 
     [ None ⇒ 〈comp2,null_action ? n〉
     | Some aj ⇒ if ai == aj 
         then 〈comp1,change_vec ? (S n) 
                      (change_vec ? (S n) (null_action ? n) (〈None ?,R〉) i)
                        (〈None ?,R〉) j〉
         else 〈comp2,null_action ? n〉 ]
   ]
 | S q ⇒ match q with 
   [ O ⇒ (* 1 *) 〈comp1,null_action ? n〉
   | S _ ⇒ (* 2 *) 〈comp2,null_action ? n〉 ] ].

definition compare_step ≝ 
  λi,j,sig,n.
  mk_mTM sig n compare_states (trans_compare_step i j sig n) 
    comp0 (λq.q == comp1 ∨ q == comp2).

definition R_comp_step_true ≝ 
  λi,j,sig,n.λint,outt: Vector (tape sig) (S n).
  ∃x.
   current ? (nth i ? int (niltape ?)) = Some ? x ∧
   current ? (nth j ? int (niltape ?)) = Some ? x ∧
   outt = change_vec ?? 
            (change_vec ?? int
              (tape_move_right ? (nth i ? int (niltape ?))) i)
            (tape_move_right ? (nth j ? int (niltape ?))) j.

definition R_comp_step_false ≝ 
  λi,j:nat.λsig,n.λint,outt: Vector (tape sig) (S n).
   (current ? (nth i ? int (niltape ?)) ≠ current ? (nth j ? int (niltape ?)) ∨
    current ? (nth i ? int (niltape ?)) = None ? ∨
    current ? (nth j ? int (niltape ?)) = None ?) ∧ outt = int.

lemma comp_q0_q2_null :
  ∀i,j,sig,n,v.i < S n → j < S n → 
  (nth i ? (current_chars ?? v) (None ?) = None ? ∨
   nth j ? (current_chars ?? v) (None ?) = None ?) → 
  step sig n (compare_step i j sig n) (mk_mconfig ??? comp0 v) 
  = mk_mconfig ??? comp2 v.
#i #j #sig #n #v #Hi #Hj
whd in ⊢ (? → ??%?); >(eq_pair_fst_snd … (trans ????)) whd in ⊢ (?→??%?);
* #Hcurrent
[ @eq_f2
  [ whd in ⊢ (??(???%)?); >Hcurrent %
  | whd in ⊢ (??(????(???%))?); >Hcurrent @tape_move_null_action ]
| @eq_f2
  [ whd in ⊢ (??(???%)?); >Hcurrent cases (nth i ?? (None sig)) //
  | whd in ⊢ (??(????(???%))?); >Hcurrent
    cases (nth i ?? (None sig)) [|#x] @tape_move_null_action ] ]
qed.

lemma comp_q0_q2_neq :
  ∀i,j,sig,n,v.i < S n → j < S n → 
  (nth i ? (current_chars ?? v) (None ?) ≠ nth j ? (current_chars ?? v) (None ?)) → 
  step sig n (compare_step i j sig n) (mk_mconfig ??? comp0 v) 
  = mk_mconfig ??? comp2 v.
#i #j #sig #n #v #Hi #Hj lapply (refl ? (nth i ?(current_chars ?? v)(None ?)))
cases (nth i ?? (None ?)) in ⊢ (???%→?);
[ #Hnth #_ @comp_q0_q2_null // % //
| #ai #Hai lapply (refl ? (nth j ?(current_chars ?? v)(None ?)))
  cases (nth j ?? (None ?)) in ⊢ (???%→?);
  [ #Hnth #_ @comp_q0_q2_null // %2 //
  | #aj #Haj * #Hneq
    whd in ⊢ (??%?); >(eq_pair_fst_snd … (trans ????)) whd in ⊢ (??%?); @eq_f2
    [ whd in match (trans ????); >Hai >Haj
      whd in ⊢ (??(???%)?); cut ((ai==aj)=false)
      [>(\bf ?) /2 by not_to_not/ % #Haiaj @Hneq
       >Hai >Haj //
      | #Haiaj >Haiaj % ]
    | whd in match (trans ????); >Hai >Haj
      whd in ⊢ (??(????(???%))?); cut ((ai==aj)=false)
      [>(\bf ?) /2 by not_to_not/ % #Haiaj @Hneq
       >Hai >Haj //
      |#Hcut >Hcut @tape_move_null_action
      ]
    ]
  ]
]
qed.

lemma comp_q0_q1 :
  ∀i,j,sig,n,v,a.i ≠ j → i < S n → j < S n → 
  nth i ? (current_chars ?? v) (None ?) = Some ? a →
  nth j ? (current_chars ?? v) (None ?) = Some ? a → 
  step sig n (compare_step i j sig n) (mk_mconfig ??? comp0 v) =
    mk_mconfig ??? comp1 
     (change_vec ? (S n) 
       (change_vec ?? v
         (tape_move_right ? (nth i ? v (niltape ?))) i)
       (tape_move_right ? (nth j ? v (niltape ?))) j).
#i #j #sig #n #v #a #Heq #Hi #Hj #Ha1 #Ha2
whd in ⊢ (??%?); >(eq_pair_fst_snd … (trans ????)) whd in ⊢ (??%?); @eq_f2
[ whd in match (trans ????);
  >Ha1 >Ha2 whd in ⊢ (??(???%)?); >(\b ?) //
| whd in match (trans ????);
  >Ha1 >Ha2 whd in ⊢ (??(????(???%))?); >(\b ?) //
  change with (change_vec ?????) in ⊢ (??(????%)?);
  <(change_vec_same … v j (niltape ?)) in ⊢ (??%?);
  <(change_vec_same … v i (niltape ?)) in ⊢ (??%?);
  >tape_move_multi_def 
  >pmap_change >pmap_change <tape_move_multi_def
  >tape_move_null_action
  @eq_f2 // >nth_change_vec_neq //
]
qed.

lemma sem_comp_step :
  ∀i,j,sig,n.i ≠ j → i < S n → j < S n → 
  compare_step i j sig n ⊨ 
    [ comp1: R_comp_step_true i j sig n, 
             R_comp_step_false i j sig n ].
#i #j #sig #n #Hneq #Hi #Hj #int
lapply (refl ? (current ? (nth i ? int (niltape ?))))
cases (current ? (nth i ? int (niltape ?))) in ⊢ (???%→?);
[ #Hcuri %{2} %
  [| % [ %
    [ whd in ⊢ (??%?); >comp_q0_q2_null /2/ % <Hcuri in ⊢ (???%); 
      @sym_eq @nth_vec_map
    | normalize in ⊢ (%→?); #H destruct (H) ]
  | #_ % // % %2 // ] ]
| #a #Ha lapply (refl ? (current ? (nth j ? int (niltape ?))))
  cases (current ? (nth j ? int (niltape ?))) in ⊢ (???%→?);
  [ #Hcurj %{2} %
    [| % [ %
       [ whd in ⊢ (??%?); >comp_q0_q2_null /2/ %2 <Hcurj in ⊢ (???%); 
         @sym_eq @nth_vec_map
       | normalize in ⊢ (%→?); #H destruct (H) ]
       | #_ % // >Ha >Hcurj % % % #H destruct (H) ] ]
  | #b #Hb %{2} cases (true_or_false (a == b)) #Hab
    [ %
      [| % [ % 
        [whd in ⊢  (??%?);  >(comp_q0_q1 … a Hneq Hi Hj) //
          [>(\P Hab) <Hb @sym_eq @nth_vec_map
          |<Ha @sym_eq @nth_vec_map ]
        | #_ whd >(\P Hab) %{b} % // % // <(\P Hab) // ]
        | * #H @False_ind @H %
      ] ]
    | %
      [| % [ % 
        [whd in ⊢  (??%?);  >comp_q0_q2_neq //
         <(nth_vec_map ?? (current …) i ? int (niltape ?))
         <(nth_vec_map ?? (current …) j ? int (niltape ?)) >Ha >Hb
         @(not_to_not ??? (\Pf Hab)) #H destruct (H) %
        | normalize in ⊢ (%→?); #H destruct (H) ]
      | #_ % // % % >Ha >Hb @(not_to_not ??? (\Pf Hab)) #H destruct (H) % ] ]
    ]
  ]
]
qed.

definition compare ≝ λi,j,sig,n.
  whileTM … (compare_step i j sig n) comp1.

definition R_compare ≝ 
  λi,j,sig,n.λint,outt: Vector (tape sig) (S n).
  ((current ? (nth i ? int (niltape ?)) ≠ current ? (nth j ? int (niltape ?)) ∨
    current ? (nth i ? int (niltape ?)) = None ? ∨
    current ? (nth j ? int (niltape ?)) = None ?) → outt = int) ∧
  (∀ls,x,rs,ls0,rs0. 
(*    nth i ? int (niltape ?) = midtape sig ls x (xs@ci::rs) → *)
    nth i ? int (niltape ?) = midtape sig ls x rs →
    nth j ? int (niltape ?) = midtape sig ls0 x rs0 →
    (∃rs'.rs = rs0@rs' ∧ current ? (nth j ? outt (niltape ?)) = None ?) ∨
    (∃rs0'.rs0 = rs@rs0' ∧ 
     outt = change_vec ?? 
            (change_vec ?? int  
              (mk_tape sig (reverse sig rs@x::ls) (None sig) []) i)
            (mk_tape sig (reverse sig rs@x::ls0) (option_hd sig rs0')
            (tail sig rs0')) j) ∨
    (∃xs,ci,cj,rs',rs0'.ci ≠ cj ∧ rs = xs@ci::rs' ∧ rs0 = xs@cj::rs0' ∧
     outt = change_vec ?? 
            (change_vec ?? int (midtape sig (reverse ? xs@x::ls) ci rs') i)
            (midtape sig (reverse ? xs@x::ls0) cj rs0') j)).
          
lemma wsem_compare : ∀i,j,sig,n.i ≠ j → i < S n → j < S n → 
  compare i j sig n ⊫ R_compare i j sig n.
#i #j #sig #n #Hneq #Hi #Hj #ta #k #outc #Hloop
lapply (sem_while … (sem_comp_step i j sig n Hneq Hi Hj) … Hloop) //
-Hloop * #tb * #Hstar @(star_ind_l ??????? Hstar) -Hstar
[ whd in ⊢ (%→?); * * [ *
 [ #Hcicj #Houtc % 
   [ #_ @Houtc
   | #ls #x #rs #ls0 #rs0 #Hnthi #Hnthj
     >Hnthi in Hcicj; >Hnthj normalize in ⊢ (%→?); * #H @False_ind @H %
   ]
 | #Hci #Houtc %
   [ #_ @Houtc
   | #ls #x #rs #ls0 #rs0 #Hnthi >Hnthi in Hci;
     normalize in ⊢ (%→?); #H destruct (H) ] ]
 | #Hcj #Houtc %
  [ #_ @Houtc
  | #ls #x #rs #ls0 #rs0 #_ #Hnthj >Hnthj in Hcj;
    normalize in ⊢ (%→?); #H destruct (H) ] ]
| #td #te * #x * * #Hci #Hcj #Hd #Hstar #IH #He lapply (IH He) -IH *
  #IH1 #IH2 %
  [ >Hci >Hcj * [ * 
    [ * #H @False_ind @H % | #H destruct (H)] | #H destruct (H)] 
  | #ls #c0 #rs #ls0 #rs0 cases rs
    [ -IH2 #Hnthi #Hnthj % %2 %{rs0} % [%]
      >Hnthi in Hd; #Hd >Hd in IH1; #IH1 >IH1
      [| % %2 >nth_change_vec_neq [|@sym_not_eq //] >nth_change_vec // % ]
      >Hnthj cases rs0 [| #r1 #rs1 ] %
    | #r1 #rs1 #Hnthi cases rs0
      [ -IH2 #Hnthj % % %{(r1::rs1)} % [%]
        >Hnthj in Hd; #Hd >Hd in IH1; #IH1 >IH1
        [| %2 >nth_change_vec // ]
        >nth_change_vec //
      | #r2 #rs2 #Hnthj lapply IH2; >Hd in IH1; >Hnthi >Hnthj
        >nth_change_vec //
        >nth_change_vec_neq [| @sym_not_eq // ] >nth_change_vec //
        cases (true_or_false (r1 == r2)) #Hr1r2
        [ >(\P Hr1r2) #_ #IH2 cases (IH2 … (refl ??) (refl ??)) [ *
          [ * #rs' * #Hrs1 #Hcurout_j % % %{rs'}
            >Hrs1 >Hcurout_j normalize % //
          | * #rs0' * #Hrs2 #Hcurout_i % %2 %{rs0'}
            >Hrs2 >Hcurout_i % //
            >change_vec_commute // >change_vec_change_vec
            >change_vec_commute [|@sym_not_eq//] >change_vec_change_vec
            >reverse_cons >associative_append >associative_append % ]
          | * #xs * #ci * #cj * #rs' * #rs0' * * * #Hcicj #Hrs1 #Hrs2 
            >change_vec_commute // >change_vec_change_vec 
            >change_vec_commute [| @sym_not_eq ] // >change_vec_change_vec 
            #Houtc %2 %{(r2::xs)} %{ci} %{cj} %{rs'} %{rs0'}
            % [ % [ % [ // | >Hrs1 // ] | >Hrs2 // ] 
              | >reverse_cons >associative_append >associative_append >Houtc % ] ]
        | lapply (\Pf Hr1r2) -Hr1r2 #Hr1r2 #IH1 #_ %2
          >IH1 [| % % normalize @(not_to_not … Hr1r2) #H destruct (H) % ]
          %{[]} %{r1} %{r2} %{rs1} %{rs2} % [ % [ % /2/ | % ] | % ] ]]]]]
qed.
 
lemma terminate_compare :  ∀i,j,sig,n,t.
  i ≠ j → i < S n → j < S n → 
  compare i j sig n ↓ t.
#i #j #sig #n #t #Hneq #Hi #Hj
@(terminate_while … (sem_comp_step …)) //
<(change_vec_same … t i (niltape ?))
cases (nth i (tape sig) t (niltape ?))
[ % #t1 * #x * * >nth_change_vec // normalize in ⊢ (%→?); #Hx destruct
|2,3: #a0 #al0 % #t1 * #x * * >nth_change_vec // normalize in ⊢ (%→?); #Hx destruct
| #ls #c #rs lapply c -c lapply ls -ls lapply t -t elim rs
  [#t #ls #c % #t1 * #x * * >nth_change_vec // normalize in ⊢ (%→?);
   #H1 destruct (H1) #_ >change_vec_change_vec #Ht1 % 
   #t2 * #x0 * * >Ht1 >nth_change_vec_neq [|@sym_not_eq //]
   >nth_change_vec // normalize in ⊢ (%→?); #H destruct (H)
  |#r0 #rs0 #IH #t #ls #c % #t1 * #x * * >nth_change_vec //
   normalize in ⊢ (%→?); #H destruct (H) #Hcur
   >change_vec_change_vec >change_vec_commute // #Ht1 >Ht1 @IH
  ]
]
qed.

lemma sem_compare : ∀i,j,sig,n.
  i ≠ j → i < S n → j < S n → 
  compare i j sig n ⊨ R_compare i j sig n.
#i #j #sig #n #Hneq #Hi #Hj @WRealize_to_Realize /2/
qed.

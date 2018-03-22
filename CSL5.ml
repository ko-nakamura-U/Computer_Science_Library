(* 再起関数の中で再起関数を使う時は、この関数には何を与えたら何が帰ってくるかというのを１つ１つ考えればよい *)

(* #use "CSL5.ml";; *)
(* exit 0;; *)


(*10.1*)
(* 目的：すでに昇順に並んだリストにを受け取ったら、リストが昇順となる位置に要素を追加したリストを返す *)
(* insert : list int -> list *)
let rec insert l n = match l with
    [] -> n :: []
  | first :: rest -> if n >= first then first :: insert rest n
                                   else n :: l;;

(* テスト *)
let test1 = insert [] 1 = [1]
let test2 = insert [1; 3; 4] 2 = [1; 2; 3; 4]
let test3 = insert [5; 7; 8] 2 = [2; 5; 7; 8]
let test4 = insert [1; 3; 4] 3 = [1; 3; 3; 4]
let test4 = insert [1; 2; 3] 10 = [1; 2; 3; 10];;



(*10.2*)
(* 目的：整数のリストを受け取ったら、それを昇順に整列したリストを返す *)
(* ins_sort : list -> list *)
let rec insert l n = match l with
    [] -> n :: []
  | first :: rest -> if n >= first then first :: insert rest n
                                   else n :: l;;

let rec ins_sort l = match l with
    [] -> []
  | first :: rest -> insert (ins_sort rest) first;;

(* テスト *)
let test1 = ins_sort [] = []
let test2 = ins_sort [1; 2; 3] = [1; 2; 3]
let test3 = ins_sort [1; 3; 2] = [1; 2; 3]
let test4 = ins_sort [1; 3; 2; 3] = [1; 2; 3; 3]
let test5 = ins_sort [7; 3; 2; 4; 5; 8; 6; 1] = [1; 2; 3; 4; 5; 6; 7; 8];;

(*
  バブルソート
  [4; 1; 3; 2]  左から前後を比較して右が一番大きい数字にする
  [1; 4; 3; 2]
  [1; 3; 4; 2]
  [1; 3; 2; 4]
  [1; 3; 2; 4]

  [1; 3; 2; 4]  4以外を比較で同じことを行う
  [1; 2; 3; 4]
*)

(* #use "CSL11.ml";; *)
(* exit 0;; *)

(* 14.14 *)
(* 目的：文字列のリストを受け取ったら、その要素を前からくっつけた文字列を返す *)
(* count_A : string list -> string *)
let concat l = List.fold_right (^) l "";;

(* 14.14 tests *)
let test_14_14_1 = concat [] = ""
let test_14_14_2 = concat ["春"] = "春"
let test_14_14_3 = concat [""; "春"] = "春"
let test_14_14_4 = concat ["春"; "夏"; "秋"; "冬"] = "春夏秋冬";;



(* 14.15 *)
(* 目的：n から 1 までのリストを作る *)
(* enumerate : int -> int list *)
let rec enumerate n =
  if n = 0 then [] else n :: enumerate (n - 1);;

(* 目的：1から受け取った自然数までの合計を求める（enumerateと高階関数を使う） *)
(* one_to_n -> int -> int *)
let one_to_n n = if n < 1 then 0
                          else List.fold_right (+) (enumerate n) 0;;

(* 14.15 tests *)
let test_14_15_1 = one_to_n 0 = 0
let test_14_15_2 = one_to_n 1 = 1
let test_14_15_3 = one_to_n 5 = 15;;



(* 14.16 *)
(* 目的：階乗を求める（enumerateと高階関数を使う） *)
(* fac -> int -> int *)
let fac n = if n < 1 then 1
                     else List.fold_right ( * ) (enumerate n) 1;;

(* 14.16 tests *)
let test_14_16_1 = fac 1 = 1
let test_14_16_2 = fac 3 = 6
let test_14_16_3 = fac 5 = 120;;





(*
クイックソート アルゴリズム

1. [5; 4; 9; 8; 2; 3]
2. 5を基準として5より小さいものを5の左に、大きいものを5の右におく
3. [4; 2; 3] と [5] と [9; 8]
4. [4; 2; 3] で同じことをしていく -> [2; 3] [4] -> [2] [3] [4]
4. [5]
4. [9; 8] で同じことをしていく -> [8] [9]
5. ステップ4でできたものを左から繋げる -> [2; 3; 4; 5; 8; 9]

*)

(* 15.1 *)
(* 目的：受け取った lst をクイックソートを使って昇順に整列する *)
(* quick_sort : int list > int list *)
let rec quick_sort lst =
  (* 目的：lst の中から n より p である要素のみを取り出す *)
  (* take : int -> int list -> (int -> int -> bool) -> int list *)
  let take n lst p = List.filter (fun item -> p item n) lst
  (* 目的：lst の中から n より小さい要素のみを取り出す *)
  (* take_less : int -> int list -> int list *)
  in let take_less n lst = take n lst (<=)  (* 値の重複があるとき同じ値が消滅するのでどっちかで = も許容する *)
  (* 目的：lst の中から n より大きいさい要素のみを取り出す *)
  (* take_greater : int -> int list -> int list *)
  in let take_greater n lst = take n lst (>)
  in match lst with
      [] -> []
    | first :: rest -> quick_sort (take_less first rest)
                       @ [first]
                       @ quick_sort (take_greater first rest);;

(* 15.1 tests *)
let test_15_1_1 = quick_sort [] = []
let test_15_1_2 = quick_sort [1] = [1]
let test_15_1_3 = quick_sort [1; 3; 2] = [1; 2; 3]
let test_15_1_4 = quick_sort [1; 3; 2; 3] = [1; 2; 3; 3]
let test_15_1_5 = quick_sort [5; 4; 9; 8; 2; 3] = [2; 3; 4; 5; 8; 9];;  (* 重複がある場合がポイント *)

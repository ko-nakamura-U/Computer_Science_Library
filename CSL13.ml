(* #use "CSL13.ml";; *)
(* exit 0;; *)

(* 16.1 *)
(* 目的：整数のリストを受け取ったら、それまでの合計からなるリストを返す *)
(* sum_list : int list -> int list *)
let sum_list lst =
  (* 目的：(アキュムレータ)整数のリストを受け取ったら、それまでの合計からなるリストを返す *)
  (* hojo : int list -> int -> int list *)
  let rec hojo lst total = match lst with
      [] -> []
    | first :: rest -> first + total :: hojo rest (first + total) in
    hojo lst 0;;

(* 16.1 tests *)
let test_16_1_1 = sum_list [] = []
let test_16_1_2 = sum_list [1] = [1]
let test_16_1_3 = sum_list [1; 2; 3] = [1; 3; 6]
let test_16_1_4 = sum_list [3; 2; 1; 4] = [3; 5; 6; 10];;



(* 16.2 *)
(* 目的：init から始めて lst の要素を右から順に f に施し込む *)
(* fold_right : ('a -> 'b -> 'b') -> 'a list -> 'b -> 'b' *)
(*
let rec fold_right f lst init = match lst with
    [] -> init
  | first :: rest -> f first (fold_right f rest init);;
*)

(* 目的：
関数f と 初期値init、そしてリストlst を受け取ったら、
init から始めてリストlst の要素を「左から」順に f に施し込む
 *)
(* folf_left : ('a -> 'b -> 'a) -> 'a -> 'b list -> 'a *)
let rec folf_left f init lst = match lst with
    [] -> init
  | first :: rest -> folf_left f (f init first) rest;;

(* 16.2 tests *)
let test_16_2_1 = folf_left (^) "a" [] = "a"
let test_16_2_2 = folf_left (^) "a" ["b"; "c"] = "abc"
let test_16_2_3 = folf_left (^) "a" ["b"; "c"; "d"] = "abcd";;

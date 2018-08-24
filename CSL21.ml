(* #use "CSL21.ml";; *)
(* exit 0;; *)


(* print test *)
print_string "aaa";
print_newline();
print_string "aaa";
print_string "bbb";
print_int 100;;



(* 22.1 *)
(* 文字列につける数字 *)
let count = ref (-1);;

(* 文字列を受け取ったら、その文字列が呼ばれるごとに異なる数字をつけた文字を返す *)
(* gensym : string -> string *)
let gensym s = (count := !count + 1;
                s ^ string_of_int !count);;
(*
let c = ref 0
let gensym s = (c := !c + 1;
                s ^ string_of_int(!c - 1));;
*)

(* 21.1 tests *)
let test_21_1_1 = gensym "a" = "a0"
let test_21_1_2 = gensym "a" = "a1"
let test_21_1_3 = gensym "x" = "x2";;



(* 22.2 *)
(* 目的：配列を与えられたら、フィボナッチ数を順に入れた配列を返す *)
(* fib_array : int array -> int array *)
let fib_array (arr: int array) =
  let total: int = Array.length arr in
  let rec append i = if i < total then
    (if i = 0 then arr.(i) <- 0
              else if i = 1 then arr.(i) <- 1
              else arr.(i) <- arr.(i - 1) + arr.(i - 2);
              append (i + 1))
                                  else () in
  (append 0; arr);;

(* 22.2 tests *)
let test_21_2_1 = fib_array [|0; 0; 0; 0; 0;|] = [|0; 1; 1; 2; 3;|]
let test_21_2_2 = fib_array [|0; 0; 0; 0; 0; 0; 0; 0; 0; 0|] = [|0; 1; 1; 2; 3; 5; 8; 13; 21; 34|];;

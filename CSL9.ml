(* #use "CSL9.ml";; *)
(* exit 0;; *)

(* 13.3 *)
(* 1 *)
(* let f x = x;; *)

(* 2 *)
(* let f x y = x; *)

(* 3 *)
(* let f x y = y; *)

(* 4 *)
(* let x -> a
let y a -> b
let f x y = y x; *)

(* 5 *)
(* let x a -> b
let y b -> c
let f x y z = y (x z);;

もしくは

let f = z x y =
  let h a = y (x a)
    in h;; *)


(* 13.4 *)
(* 2つの関数を合成した関数を返す関数 *)
(* compose : (`a -> `b) -> (`b -> `c) -> `a -> `c *)
(*
下記のように局所変数定義を使うとわかりやすい。

  let ans f g =
    let h = f (g a)
      in h;;
*)

(*
合成できる関数　＝ (`a -> `b) -> (`b -> `c)
                       ~~~~~~~~~~
                       ここが同じ型でなければならない

ちなみに `a と `b はそれぞれの要素を持つが、同じ型でもよい。
*)


(* 13.5 *)
let twice f = let g a = f (f a) in g;;
let test1 = twice twice;;

(* 実行結果 *)
(*
val twice : ('a -> 'a) -> 'a -> 'a = <fun>
val test1 : ('_weak1 -> '_weak1) -> '_weak1 -> '_weak1 = <fun>

weak: 受け取る型によって自分自身の型が決まるときの型は、
      自分から見てポインタになっており、それをweakという。（多相型に多相型を入れるとweakになる）
*)

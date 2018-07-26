(* #use "CSL18.ml";; *)
(* exit 0;; *)


(*
例：座標計算（P.213）
自分からの距離の計算方法を知っている点を表している。
データとそれに対する操作をひとまとめに扱う考え方は、オブジェクト指向言語の基本的な考え方。
（オブジェクト指向言語のオブジェクトは、このことを指している）
*)

(*
モジュール(関数のまとまりを表すもの)とシグネチャ(インタフェースみたいなもの)の関係性は、
モジュールをシグネチャで公開制限することができる。
*)


(* 20.1 *)

(* 赤か黒を示す型 *)
type color_t = Red | Black

(* 'a型のキーと 'b型の値、色を表す color_t 型の値を持つ木の型 *)
type ('a, 'b) rb_tree_t = Empty
                        | Node of 'a * 'b * color_t * ('a, 'b) rb_tree_t * ('a, 'b) rb_tree_t;;



(* 20.2 *)
(* rb_tree_t型の木を受け取ったらその木が図20.2の左側のような格好になっているか調べ、
なっていたら図の右側の木を返すような木を返し、なっていなかったらそのまま返す *)
let balance (tree: ('a, 'b) rb_tree_t) = match tree with
    Node (zk, zv, Black, Node (yk, yv, Red, Node (xk, xv, Red, a, b), c), d)
  | Node (zk, zv, Black, Node (xk, xv, Red, a, Node (yk, yv, Red, b, c)), d)
  | Node (xk, xv, Black, a, Node (zk, zv, Red, Node (yk, yv, Red, b, c), d))
  | Node (xk, xv, Black, a, Node (yk, yv, Red, b, Node (zk, zv, Red, c, d)))
      -> Node (yk, yv, Red, Node (xk, xv, Black, a, b), Node (zk, zv, Black, c, d))
  | _ -> tree;;

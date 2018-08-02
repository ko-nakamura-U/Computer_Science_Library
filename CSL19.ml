(* #use "CSL19.ml";; *)
(* exit 0;; *)


(* 20.3 *)

(* 赤か黒を示す型 *)
type color_t = Red | Black

(* 木を表す型 *)
type ('a, 'b) rb_tree_t = Empty
                        | Node of ('a, 'b) rb_tree_t * 'a * 'b * color_t * ('a, 'b) rb_tree_t

(* 目的：rb_tree_t型の木を受け取ったらその木が図20.2の左側のような格好になっているか調べ、
なっていたら図の右側の木を返すような木を返し、なっていなかったらそのまま返す *)
(* balance : ('a, 'b) rb_tree_t -> ('a, 'b) rb_tree_t *)
let balance (tree: ('a, 'b) rb_tree_t) = match tree with
    Node (Node (Node (a, xa, xb, Red, b), ya, yb, Red, c), za, zb, Black, d)
  | Node (Node (a, xa, xb, Red, Node (b, ya, yb, Red, c)), za, zb, Black, d)
  | Node (a, xa, xb, Black, Node (Node (b, ya, yb, Red, c), za, zb, Red, d))
  | Node (a, xa, xb, Black, Node (b, ya, yb, Red, Node (c, za, zb, Red, d)))
      -> Node (Node (a, xa, xb, Black, b), ya, yb, Red, Node (c, za, zb, Black, d))
  | _ -> tree;;

(* 目的：赤黒木とキーの値を受け取ったら、それを挿入した赤黒木を返す *)
let insert (tree: ('a, 'b) rb_tree_t) (key: 'a) (value: 'b) =
  let rec insert_t tree = match tree with
      Empty -> Node (Empty, key, value, Red, Empty)
    | Node (l, k, v, c, r) ->
      if key = k then Node (l, key, value, c, r)
      else if key < k then balance (Node (insert_t l, k, v, c, r))
      else balance (Node (l, k, v, c, insert_t r)) in
  match insert_t tree with
      Empty -> assert false
    | Node (l, k, v, c, r) -> Node (l, k, v, Black, r);;

(* 20.3 tests *)
let test_20_3_1_data = Empty
let test_20_3_2_data = insert test_20_3_1_data 1 "x"
let test_20_3_3_data = insert test_20_3_2_data 2 "y"
let test_20_3_4_data = insert test_20_3_3_data 5 "z"

let test1 = test_20_3_2_data = Node (Empty, 1, "x", Black, Empty)
let test2 = test_20_3_3_data = Node (Empty, 1, "x", Black,
                               Node (Empty, 2, "y", Red, Empty))
let test3 = test_20_3_4_data = Node (Node (Empty, 1, "x", Black, Empty),
                               2, "y", Black,
                               Node (Empty, 5, "z", Black, Empty));;

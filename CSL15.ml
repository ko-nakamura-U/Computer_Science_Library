(* #use "CSL15.ml";; *)
(* exit 0;; *)


(* 木を表す型 *)
type tree_t = Empty                          (* 空の木 *)
            | Leaf of int                    (* 葉 *)
            | Node of tree_t * int * tree_t  (* 節 *)

(* 木の例 *)
let tree1 = Empty
let tree2 = Leaf (3)
let tree3 = Node (tree1, 4, tree2)
let tree4 = Node (tree2, 5, tree3);;

(* 17.5 *)
(* 目的：tree_t型の木を受け取ったら、節や葉に入っている値をすべて2倍にした木を返す *)
(* tree_double : tree_t -> tree_t *)
let rec tree_double (tree: tree_t) = match tree with
    Empty -> Empty
  | Leaf (n) -> Leaf (n * 2)
  | Node (t1, n, t2) -> Node (tree_double t1, n * 2, tree_double t2);;

(* test_17_5_1 *)
let test_17_5_1 = tree_double tree1 = Empty
let test_17_5_2 = tree_double tree2 = Leaf (6)
let test_17_5_3 = tree_double tree3 = Node (Empty, 8, Leaf 6)
let test_17_5_4 = tree_double tree4 = Node (Leaf 6, 10, Node (Empty, 8, Leaf 6));;



(* 17.6 *)
(* 目的：
int -> int型の関数 f と tree_t型の木を受け取ったら、
節や葉に入っている値すべてに f を適用した木を返す *)
(* tree_map : (int -> int) -> tree_t -> tree_t *)
let rec tree_map (f: (int -> int)) (tree: tree_t) = match tree with
    Empty -> Empty
  | Leaf (n) -> Leaf (f n)
  | Node (t1, n, t2) -> Node (tree_map f t1,
                              f n,
                              tree_map f t2);;

(* test_17_6_1 *)
let test_17_6_1 = tree_map (fun x -> x) tree1 = Empty
let test_17_6_2 = tree_map (fun x -> x) tree2 = Leaf (3)
let test_17_6_3 = tree_map (fun x -> x + 2) tree3 = Node (Empty, 6, Leaf 5)
let test_17_6_4 = tree_map (fun x -> x * 2) tree4 = Node (Leaf (6), 10, Node (Empty, 8, Leaf 6));;



(* 17.7 *)
(* 目的：
tree_t型の木を受け取ったら、節と葉が合計いくつあるかを返す *)
(* tree_length : tree_t -> int *)
let rec tree_length (tree: tree_t) = match tree with
    Empty -> 0
  | Leaf (n) -> 1
  | Node (t1, n, t2) -> tree_length t1 + 1 + tree_length t2;;

(* test_17_7_1 *)
let test_17_7_1 = tree_length tree1 = 0
let test_17_7_2 = tree_length tree2 = 1
let test_17_7_3 = tree_length tree3 = 2
let test_17_7_4 = tree_length tree4 = 4;;



(* 17.8 *)
(* 目的：tree_t型の木を受け取ったら、木の深さを返す *)
(* tree_depth : tree_t -> int *)
let rec tree_depth (tree: tree_t) = match tree with
    Empty -> 0
  | Leaf (n) -> 0
  | Node (t1, n, t2) -> max (tree_depth t1) (tree_depth t2) + 1;;

(* test_17_8_1 *)
let test_17_8_1 = tree_depth tree1 = 0
let test_17_8_2 = tree_depth tree2 = 0
let test_17_8_3 = tree_depth tree3 = 1
let test_17_8_4 = tree_depth tree4 = 2;;



(*
２分探索木

条件
・Rootから左側の木に格納されているデータはRootよりも小さい
・Rootから右側の木に格納されているデータはRootよりも大きい

（例）
           10
         /   \
        8    12
      /  \  /  \
     3   9 *   13
*)

(* 17.9 *)
(*
・型 -> int型
・なぜ多相型にならないのか? -> この関数には int しか使えない + が含まれているから。
*)

(* 17.3節 *)
(* 目的：tree に含まれる整数を全て加える *)
(* sum_tree : tree_t -> int *)
(* let rec sum_tree (tree: tree_t) = match tree with
    Empty -> 0
  | Leaf (n) -> 0
  | Node (t1, n, t2) -> 0;; *)

(* sum_tree : tree_t -> int *)
(* type ('a, 'b) = tree_t =
    Empty
  | Leaf of 'a * 'b
  | Node of ('a, 'b) tree_t * 'a * 'b ('a, 'b) tree_t *)

(* sum_tree : tree_t -> int *)
(* let rec sum_tree (tree: tree_t) = match tree with
    Empty -> 0
  | Leaf (n) -> n
  | Node (t1, n, t2) -> sum_tree t1 + n + sum_tree t2;; *)

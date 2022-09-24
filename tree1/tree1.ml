(* https://stackoverflow.com/questions/39128005/print-a-binary-tree-in-ocaml *)
(* 中序打印二叉的算法 *)

open Printf (* open是直接访问，像cpp中的use *)

(* 非空叶子节点二叉树 *)
type tree = Leaf of int
          | Branch of tree * int * tree (* 这里*号是元组语义, "|"为变体，类似union语义 *)

(* function本身就是单参模式匹配 *)
let rec print_tree_infix = function
  (* 第一个模式竖线也可以不写 *)
  | Leaf n -> printf "%d\n" n
  | Branch (left, n, right) ->
    (* 下面用的都是 ";", 代表部分语句 *)
    printf "%d\n" n;
    print_tree_infix left;
    print_tree_infix right
;;

(* 构建树 *)
let mytree = Branch(Branch(Leaf 6, 3, Leaf 9), 8, Branch(Leaf 7, 9, Leaf 2))
let () = print_tree_infix mytree (* 好像必须使用立即函数 *)
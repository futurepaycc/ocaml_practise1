(* 
模式匹配2: 语法表达式处理
来源: https://ocaml.org/learn/taste.html 
理解参考: https://ocaml.org/learn/tutorials/data_types_and_matching.zh.html

TODO: 
1. 配合calc1这个parser使用
2. 学习lex|yacc|menhir
*)


(* 变异: 相当于自定义了一堆类型 *)
type expression =
    | Num of int
    | Var of string
    | Let of string * expression * expression
    | Binop of string * expression * expression;;

(* 递归的 模式匹配 函数组合, 解析 表达式的ast:
   jsjs运行的疑问解决了： vm机器码的操作数 '字符' 可以parseInt、parseFloat然后运算啊

   TODO: 理解这个递归的解析过程， 函数、类...都会以些为基础
*)
let rec eval env = function (* function只能有1个参，fun可以有多个？ *)
    | Num i -> i
    | Var x -> List.assoc x env  (* assoc: 返回list of pair中，对应key的value *)
    | Let (x, e1, in_e2) ->         (* 1. 如果 是 let 表达式，递归解析到基本元素: Num,Var,Binop *)
       let val_x = eval env e1 in
       eval ((x, val_x) :: env) in_e2
    | Binop (op, e1, e2) ->         (* 2. 如果是 Binop, 进行四则运算求值 *)
       let v1 = eval env e1 in
       let v2 = eval env e2 in
       eval_op op v1 v2
  and eval_op op v1 v2 =
    match op with
    | "+" -> v1 + v2
    | "-" -> v1 - v2
    | "*" -> v1 * v2
    | "/" -> v1 / v2
    | _ -> failwith ("Unknown operator: " ^ op);;

let result = eval [] (Let ("x", Num 1, Binop ("+", Var "x", Var "x")));; (* NOTE: 这里的语法啥意思啊？ []()? : let x = 1 in x + x, 怎么分析出来的啊? *)
print_int result;;
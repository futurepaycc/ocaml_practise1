(* 
树递归操作展示
说明: 好像没有lexer过程，直接分析树
来源: https://github.com/polaron5/Calculator/blob/master/calc.ml
ocaml|utop str.cma calc2.ml
ocamlc str.cma calc2.ml -o calc2.exe
上面是个链接问题，加上open Str也不行

toplevel(ocaml|utop) 中执行还可以： load "str.cma";;

支持运算: 1 + 2 * 3
*)

type tree = 
    Tree of tree * op * tree 
  | Value of float

and op = float -> float -> float

type associativity = Left | Right

let rec eval = function
    Tree (l, op, r) -> op (eval l) (eval r)
  | Value e -> e

let to_op = function
  | '+' -> ( +. )
  | '-' -> ( -. )
  | '*' -> ( *. )
  | '/' -> ( /. )
  | '^' -> ( ** )
  | _   -> failwith "未知运算符"

let op_list = [('+', Left); ('-', Left); ('*', Left); ('/', Left); ('^', Right)] (* *运算符及其关联性（默认为左侧） *)

(* 依次查看表达式是否具有以下形式：
    - (expression) (1)
    - expression op expression (2)
    - nombre (3)
 *)
let rec analyze expr =
  let rec iter' = function (* 如果expr的格式不为（2），则返回None；否则，返回树 *)
    | [] -> None
    | x::xs -> let result = find_op expr x in
               if result = None then iter' xs else result in
  let p = pth expr in (* 我们首先测试（1） *)
  if p = None then
    let result = iter' op_list in (* 如果（1）失败，则测试（2）（有多个运算符按优先级进行测试） *)
    if result = None then number expr (* 如果（3）失败，则仅剩下（3）！ *)
    else result   
  else p

and pth expr = 
  try 
    if expr.[0] != '(' || expr.[(String.length expr)-1] != ')' then None
    else analyze (String.sub expr 1 ((String.length expr)-2)) (* 如果expr的格式为（expr'），则对expr'*进行递归分析 *)
  with Invalid_argument "String.sub" -> None 

and find_op expr (opt, a) =
  try
    let rec aux expr (opt, a) fol =
	  (* 如果opt在左侧是关联的，我们从索引fol寻找opt的第一个匹配项
         如果opt在右侧具有关联性，我们将在fol之前查找最后一个。 *)
      let i = (if a = Right then String.index_from expr fol opt else String.rindex_from expr fol opt) in
      let left = String.sub expr 0 i in (* 我们在左边和右边切割字符串 *)
      let right = String.sub expr (i+1) ((String.length expr)-(i+1)) in
      match (analyze left, analyze right) with (* 我们在左和右*上递归分析 *)
        | (None, _) -> aux expr (opt,a) (if a = Right then i+1 else i-1) (* 如果a =右，则i + 1否则，i-1）（*如果左或右无，则可能只是输入了一个括号无意间所以我们测试下一次出现 *)
        | (_, None) -> aux expr (opt,a) (if a = Right then i+1 else i-1)
        (* 但如果我们设法在两边都得到一棵树，则可以构建顶部节点 *)
        | (Some u, Some v) -> Some (Tree (u, (to_op opt), v))
    in aux expr (opt,a) (if a = Right then 0 else (String.length expr)-1)
  with (* *如果抛出异常之一，尤其是Not_found，则expr的形式不是expr'opt expr' *)
    Not_found -> None
  | Invalid_argument "String.index_from" -> None
  | Invalid_argument "String.sub" -> None

and number expr = (* 如果expr只是一个数字*，我们最终会测试 *)
  try Some (Value (float_of_string expr)) with Failure "float_of_string" -> None

let () =
  let remove_blanks = Str.global_replace (Str.regexp " +") "" in (* 就这点正则, 我们将从开头删除空格 *)
  (* let s = read_line () in *)
  let s = "1+2*3" in
  match analyze (remove_blanks s) with
    | None -> print_string "Expression invalide." (* 我们无法构建树，给定的表达式无效 *)
    | Some tree -> print_float (eval tree) 
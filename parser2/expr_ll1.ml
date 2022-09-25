(* 来源: https://www.varesano.net/a-simple-math-expression-calculator-in-ocaml/ 文章中有5种实现 *)

(* 
* 完整的 lexer - parser
* 递归下降LL(1)解析
* x::xs使用x代表前看1,xs代表remain状态
* 带有错误处理
*)

(*
这是第一种char list实现
解析函数每个都解处理 [1; 0;  ; +;  ; 2; *; 3] 这样的list, 不符合常规用法
ocamlc -g -o calc3_charlist.nc calc3_charlist.ml  # ctr+shift+b 编译
F5 debug
*)

(* 表达式文法
  expr_parser    = term_parser    | term_parser + expr
  term_parser    = factor_parser  | factor_parser * term_parser
  factor_parser  = number         | ( expr_parser )
*)

(* 字符串转char list: .[x]为下标访问，这里是字符串反向迭代，列表前面append的递归 *)
let str2list s =
  let rec loop acc = function
    | 0 -> s.[0] :: acc
    | x -> loop (s.[x] :: acc) (x - 1)
  in
  loop [] ( (String.length s) - 1)

(* char list转回string, String.make 1 char制作单字符串, ^为字符串拼接函数 *)
let rec list2str = function
  | [] -> ""
  | x :: xs -> String.make 1 x ^ list2str xs

(* 数字判断 *)
let is_digit x = x >= '0' && x <= '9'
(* 字符转int并转为0-9的值 *)
let int_of_digit x = int_of_char x - int_of_char '0'

(* 自定义异常 *)
exception SyntaxError of char list

(* 基本元素数字: 数字合并 "21"->'2''1'-> 2*10+1 *)
let number l =
  let rec loop acc = function
    (* 模式: 剩余list以数字开头 *)
    | x :: xs when is_digit x -> loop ( (10 * acc) + int_of_digit x) xs
    (* 其它情况: 这里的l代表剩余list整体 *)
    | l -> (acc, l)
  in
  loop 0 l

(* factor: 多位数字token 与 括号 *)
let rec factor_parser l =
  match l with
  (* 匹配基本数字token *)
  | x :: xs when is_digit x -> number l

  (* 嵌套模式: 匹配括号和内嵌表达式 *)
  | '(' :: xs ->
    let x, l = expr_parser xs in (* 这里与 expr_parser 交互递归 *)
    (* 嵌套表达式后面紧跟 ')'才合法 *)
    ( match l with
      | ')' :: xs -> x, xs
      | _ -> raise (SyntaxError l) 
    )
  
  (* 其它情况非法 *)
  | _ -> raise (SyntaxError l)

(* term: 乘法级别处理 *)
and term_parser l =
  (* 先进行高一级优先级处理 *)
  let x, l = factor_parser l in
  match l with
  (* 递归调用自身并求值 *)
  | '*' :: xs ->
    let y, l = term_parser xs in
    x * y, l

  | _ -> x, l

(* expr: 加法级别处理 *)
and expr_parser l =
  (* 先进行高一级优先级处理 *)
  let x, l = term_parser l in
  match l with
  (* 递归调用自身并求值 *)
  | '+' :: xs ->
    let y, l = expr_parser xs in
    x + y, l
  | _ -> x, l

let calc s =
  Printf.printf "%s = " s;
  try
    let l = str2list s in
    (* x为归约求值结果, l为剩余列表 *)
    let x, l = expr_parser l in
    match l with
    (* 剩余列表为空，代表正确处理完成 *)
    | [] -> Printf.printf "%d\n" x
    | _ -> raise (SyntaxError l)
  with SyntaxError l -> Printf.printf "Parse error at '%s'\n" (list2str l)

let _ =
  List.iter calc [ "1"; "1+1"; "2*3"; "(1)"; "1+2*3"; "2*(3+4)*5"; "2+3*4(5)" ]

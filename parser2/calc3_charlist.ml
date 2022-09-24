(* 来源: http://www.varesano.net/blog/fabio/simple%20math%20expression%20calculator%20ocaml 文章中有5种实现(已无法打开) *)

(* 完整的 lexer - parser *)

(*
这是第一种char list实现
解析函数每个都解处理 [1; 0;  ; +;  ; 2; *; 3] 这样的list, 不符合常规用法
ocamlc -g -o calc3_charlist.nc calc3_charlist.ml  # ctr+shift+b 编译
F5 debug
*)

(* 表达式文法
  expr      = plus_expr | plus_expr + expr
  plus_expr = mul_expr  | mul_expr * plus_expr
  mul_expr  = number    | ( expr )
*)

(* 字符串转char list: .[x]为下标访问，这里是字符串反向迭代，列表前面append的递归 *)
let explode s =
  let rec loop acc = function
    | 0 -> s.[0] :: acc
    | x -> loop (s.[x] :: acc) (x - 1)
  in
  loop [] ( (String.length s) - 1)

(* char list转回string, String.make 1 char制作单字符串, ^为字符串拼接函数 *)
let rec implode = function
  | [] -> ""
  | x :: xs -> String.make 1 x ^ implode xs

(* 数字判断 *)
let is_digit x = x >= '0' && x <= '9'
(* 字符转int并转为0-9的值 *)
let int_of_digit x = int_of_char x - int_of_char '0'

(* 自定义异常 *)
exception SyntaxError of char list

(* 基本元素数字: 数字合并 "21"->'2''1'-> 2*10+1 *)
let number l =
  let rec loop acc = function
    | x :: xs when is_digit x -> loop ( (10 * acc) + int_of_digit x) xs
    | l -> acc, l
  in
  loop 0 l

(* 乘法与括号处理 *)
let rec mul_expr l =
  match l with
  | x :: xs when is_digit x -> number l
  | '(' :: xs ->
    let x, l = expr xs in
    ( match l with
    | ')' :: xs -> x, xs
    | _ -> raise (SyntaxError l) )
  | _ -> raise (SyntaxError l)

(* 加法处理 *)
and plus_expr l =
  let x, l = mul_expr l in
  match l with
  | '*' :: xs ->
    let y, l = plus_expr xs in
    x * y, l
  | _ -> x, l

(* 解析入口 *)
and expr l =
  let x, l = plus_expr l in
  match l with
  | '+' :: xs ->
    let y, l = expr xs in
    x + y, l
  | _ -> x, l

let calc s =
  Printf.printf "%s = " s;
  try
    let l = explode s in
    let x, l = expr l in
    match l with
    | [] -> Printf.printf "%d\n" x
    | _ -> raise (SyntaxError l)
  with SyntaxError l -> Printf.printf "Parse error at '%s'\n" (implode l)

let _ =
  List.iter calc [ "1"; "1+1"; "2*3"; "(1)"; "1+2*3"; "2*(3+4)*5"; "2+3*4(5)" ]

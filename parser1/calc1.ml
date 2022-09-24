(* 
来源: https://github.com/galenweld/calculator/blob/master/calc.ml
ocaml -unsafe-string calc1.ml 
.merlin文件中加入: FLG -unsafe-string 解决本文件报错

功能说明：
只处理整数运算
局限：
token处里采用整数*10合并算法，不能处理自然语言

词法单函数测试说明:
rlwrap ocaml -unsafe-string (utop无此选项)
测试文件: calc1.ml.txt

整体测试方法:
rlwrap ocaml -unsafe-string
#use calc1.ml
let tokens = lex "10 + 201 * 3";;
let expr = parse tokens;;
eval expr;;

BUG: 已解决
parser代码有问题: 加上1+(2*3)会死循环: parse (lex "1 +  (2 * 3) ");;

TODO:
进行parser的各函数分析
使用python(有枚举和命名元组)|js解析形如右面的token串： [Int 1; Plus; OParen; Int 2; Times; Int 3; CParen] 
*)

(* 这里的*号是什么意思??? *)
type expr =
  | Val of int
  | Plus of expr * expr
  | Minus of expr * expr
  | Times of expr * expr

type token =
  | Int of int
  | Plus
  | Minus
  | Times
  | OParen
  | CParen

type token_stream = token list

(* lex "1 +  (2 * 3) " -> [Int 1; Plus; OParen; Int 2; Times; Int 3; CParen] *)
let lex (input : string) : token_stream =
  (* 尾递归处理: 反序单字符,含空格:  "10 + 201 * 302" -> [2; 0; 3;  ; *;  ; 1; 0; 2;  ; +;  ; 0; 1]*)
  let rec text_to_char_list (t : string) (acc : char list) : char list =
    match t with
    | "" -> acc
    | _ ->
      let len = String.length t in
      text_to_char_list (String.sub t 1 (len - 1)) (String.get t 0 :: acc)
  in

  (* raw token, 正序含类型，无空格: "10+201*302" -> [Int 1; Int 0; Plus; Int 2; Int 0; Int 1; Times; Int 3; Int 0; Int 2] *)
  (* NOTE: 下面这两个函数是lex计算的核心 *)
  let char_list_to_token_list (s : char list) : token list =
    let rec fold_helper l c =
      match c with
      | ' ' -> l
      | '(' -> OParen :: l
      | ')' -> CParen :: l
      | '+' -> Plus :: l
      | '-' -> Minus :: l
      | '*' -> Times :: l
      | x -> Int (int_of_string (String.make 1 x)) :: l
    in
    List.fold_left fold_helper [] s
  in

  (* token, 数字结合: "10+201*302" -> [Int 10; Plus; Int 201; Times; Int 302]  *)
  let rec fix_ints (s : token list) : token list =
    match s with
    | [] -> []
    | Int a :: Int b :: tl -> fix_ints (Int ((10 * a) + b) :: tl) (* FIXME: 局限，这里无法处理字符id *)
    | hd :: tl -> hd :: fix_ints tl
  in
  fix_ints (char_list_to_token_list (text_to_char_list input []))

(* and 关键字说明:
  1. 用于避免多个let? 2. 用于相互递归定义
  https://stackoverflow.com/questions/38884482/what-does-the-and-keyword-mean-in-ocaml/38884590

  parse结果：  "10 + 201 * 3" -> Plus (Val 10, Times (Val 201, Val 3))
  TODO: 下面的代码质量一般，好像都是list匹配
*)
let rec parse (s : token_stream) : expr =
  let expr, s' = parse_expr s in
  if s' = [] then expr else failwith "Invalid token stream."

  (* 1. 表达式解析入口和加法处理 *)
  and parse_expr (s : token_stream) : expr * token_stream =
    let term, s' = parse_term s in
      let rec termer (t : expr) (s' : token_stream) : expr * token_stream =
        match s' with
        | Plus :: tl ->
          let t', tl' = parse_term tl in
          termer (Plus (t, t')) tl'
        | Minus :: tl ->
          let t', tl' = parse_term tl in
          termer (Minus (t, t')) tl'
        | _ -> t, s'
      in
      termer term s'

  (* 2. 乘法处理 *)
  and parse_term (s : token_stream) : expr * token_stream =
    let factor, s' = parse_factor s in
      let rec factorer (f : expr) (s' : token_stream) : expr * token_stream =
        match s' with
        | Times :: tl ->
          let f', tl' = parse_factor tl in
          factorer (Times (f, f')) tl'
        | _ -> f, s'
      in
      factorer factor s'

  (* 3. 解析基本元素, BUG: 这里的括号处理会死循环
      和calc3.ml比较：
      calc3.ml的括号处理放在 乘法处理中
      而这里放在了基本元素解析里，理论上这里更合理
  *)
  and parse_factor (s : token_stream) : expr * token_stream =
    match s with
    | Int n :: tl -> Val n, tl
    | OParen :: tl ->
      let expr, s' = parse_expr tl in (* NOTE: 这里与calc3不一致，应该是tl *)
      ( match s' with
      | CParen :: tl' -> expr, tl'
      | _ -> failwith "Missing )." )
    | _ -> failwith "Not a factor.";;

let rec eval (e : expr) : int =
  match e with
  | Val x -> x
  | Plus (e1, e2) -> eval e1 + eval e2
  | Minus (e1, e2) -> eval e1 - eval e2
  | Times (e1, e2) -> eval e1 * eval e2

let calc (input : string) : int =
  let tokens = lex input in
  let expr = parse tokens in
  eval expr

(* 自己增加的调用示例, tip: 文件执行不用;;但需要换行, 单行尾注释也需要分号 *)
let result = calc "10 + 201 * 3";; (* FIXME: (1+2)*3 失败 *)

print_int result

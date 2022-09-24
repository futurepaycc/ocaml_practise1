let rec factorial n =
  if n = 0 then
    1
  else
    n * factorial (n - 1)

let fact_5 = factorial 5;;

print_int fact_5;;
print_newline

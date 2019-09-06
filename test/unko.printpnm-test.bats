#!/usr/bin/env bats

readonly TARGET_COMMAND="$(pwd)/../bin/unko.printpnm"

setup() {
  export RUN_TEST=true
  load "$TARGET_COMMAND"
}

@test "unko.printpnmのmax_stage_col関数は引数1のとき13を返す" {
  run max_stage_col 1
  [ "$status" -eq 0 ]
  [ "$output" -eq 13 ]
}

@test "unko.printpnmのmax_stage_row関数は引数1のとき8を返す" {
  run max_stage_row 1
  [ "$status" -eq 0 ]
  [ "$output" -eq 8 ]
}

@test "unko.printpnmのmax_value関数は引数の中からもっとも大きな値を返す" {
  run max_value 1 2 3
  [ "$status" -eq 0 ]
  [ "$output" -eq 3 ]
}

@test "unko.printpnmのmax_value関数は引数の中からもっとも大きな値を返す。並び順は関係ない" {
  run max_value 3 2 1
  [ "$status" -eq 0 ]
  [ "$output" -eq 3 ]
}

@test "unko.printpnmのmax_value関数は引数の中からもっとも大きな値を返す。2桁の整数に対しても" {
  run max_value 10 12 3
  [ "$status" -eq 0 ]
  [ "$output" -eq 12 ]
}

@test "unko.printpnmのrepeat関数は引数の数だけ1を連続して返す" {
  run repeat 3
  [ "$status" -eq 0 ]
  [ "$output" = 111 ]
}

@test "unko.printpnmのrepeat関数は引数の数だけ引数を連続して返す" {
  run repeat 3 0
  [ "$status" -eq 0 ]
  [ "$output" = 000 ]
}

@test "unko.printpnmのalign_center関数は与えられた文字列が奇数個の時、中央揃えして返す" {
  run align_center 0 <<< "$(echo -e '1\n111')"
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "010" ]
  echo "${lines[1]}"
  [ "${lines[1]}" = "111" ]
}

@test "unko.printpnmのalign_center関数は与えられた文字列が偶数個の時、右側を多く詰めて中央揃えして返す" {
  run align_center 0 <<< "$(echo -e '1\n1111')"
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "0100" ]
  echo "${lines[1]}"
  [ "${lines[1]}" = "1111" ]
}


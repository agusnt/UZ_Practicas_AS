#!/usr/bin/env bats
#
# Basic tests for exercise 4 from lab 2
#
# @author: Navarro Torres, Agustín
# @email: agusnt@unizar.es
#
# @version: 0.0.1

FILE="$(realpath "${BATS_TEST_DIRNAME}/../../src/Pr2/practica2_4.sh")"
load "../common.sh"

outputError() {
  # Generate output error for students
  echo "Error with input: $1, actual output: $2, expected output: $3"
}

@test "Script ($FILE) exists" {
  # Read the head
  [ -f "$FILE" ]
}

@test "Check the shellbang" {
  # Check if the shellbang is right
  run check_shellbang "$FILE"
  echo "$output"
  [ "$status" -eq 0 ] 
}

@test "Check students name" {
  # Read the head
  run check_students "$FILE"
  echo "$output"
  [ "$status" -eq 0 ] 
}

@test "Check lowercase letters" {
  input_data=$(printf "%s\n" {a..z})
  run bash "$FILE" <<< "$input_data"

  [ "$status" -eq 0 ]

  local i=0
  # Verify all letters
  for letter in {a..z}; do
    local regex="^[[:space:]]*${letter}.*[Ll]etra[[:space:]]*$"

    if [[ ! "${lines[$i]}" =~ $regex ]]; then
      outputError "$letter" "$letter es una letra" "${lines[$i]}"
      return 1
    fi
    i=$((i + 1))
  done
}
@test "Check upercase letters" {
  input_data=$(printf "%s\n" {A..Z})
  run bash "$FILE" <<< "$input_data"

  [ "$status" -eq 0 ]

  local i=0
  # Verify all letters
  for letter in {A..Z}; do
    local regex="^[[:space:]]*${letter}.*[Ll]etra[[:space:]]*$"

    if [[ ! "${lines[$i]}" =~ $regex ]]; then
      outputError "$letter" "$letter es una letra" "${lines[$i]}"
      return 1
    fi
    i=$((i + 1))
  done
}

@test "Check numbers" {
  input_data=$(printf "%s\n" {0..99})
  run bash "$FILE" <<< "$input_data"

  [ "$status" -eq 0 ]

  local i=0
  # Verify all letters
  for num in {0..99}; do
    local regex="^[[:space:]]*${num}.*[Nn][úu]mero[[:space:]]*$"

    if [[ ! "${lines[$i]}" =~ $regex ]]; then
      outputError "$num" "$num es un número" "${lines[$i]}"
      return 1
    fi
    i=$((i + 1))
  done
}

@test "Check special characters" {
  local charset=('@' '#' '$' '%' '&' '*' '+' '=' '[' ']' '.' ',' ' ')
  input_data=$(printf "%s\n" "${charset[@]}")
  run bash "$FILE" <<< "$input_data"

  [ "$status" -eq 0 ]

  local i=0
  # Verify all letters
  for char in "${charset[@]}"; do
    local escapedChar="$(printf '%s' "$char" | sed 's/[][\.*^$]/\\&/g')"
    local regex="^[[:space:]]*${escapedChar}.*[Cc]ar[áa]cter.*especial"

    if [[ ! "${lines[$i]}" =~ $regex ]]; then
      outputError "$escapedChar" "$escapedChar es un cáracter especial" "${lines[$i]}"
      return 1
    fi
    i=$((i + 1))
  done
}

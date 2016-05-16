#!/bin/bash

# @param: target, item1, ..., itemn
function is_in_array() {
  local target=$1; shift
  local item
  for item; do
    [ $item == $target ] && return 0
  done
  return 1
}

# @param: question, question_warning, allowed_answer1, ...allowed_answern
function ask_question() {
  local readonly question=$1; shift
  local readonly question_warning=${1:-$question}; shift
  local readonly allowed_answers=${@}
  local answer

  printf '%b ' 1>&2 $question
  read answer
  while ! $(is_in_array $answer $allowed_answers); do
    printf '%b ' 1>&2 $question_warning
    read answer
  done

  echo $answer
}

# @param: question, question_warning
function confirm() {
  local readonly question="$1 [Y/N]"
  local readonly question_warning="${2:-$1} [Y/N]"
  local readonly answer=$(ask_question "$question" "$question_warning" Y N)
  [ $answer == 'Y' ] && return 0 || return 1
}

#!/bin/bash
number=$(echo "" | walker --dmenu --placeholder "Fizzy #..." --width 200 --minheight 1 --maxheight 1 2>/dev/null)
if [[ -n "$number" ]]; then
  dir=(~/Code/*--fizzy-"$number"-*/)
  [[ -d ${dir[0]} ]] && kiro "${dir[0]}"
fi

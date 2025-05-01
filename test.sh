#!/bin/bash
 
hello() {
  echo "Hello, $1!"
}

read -p "your name > " name
hello $name


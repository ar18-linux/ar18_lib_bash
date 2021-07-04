#!/usr/bin/env bash
# ar18


function ar18.script._execute_with_sudo(){


  function ar18.script.execute_with_sudo() {
    #set -x
    # No wrapper parts for this function! 
    # The original command must be executed in its original environment!
    ar18.script.import script.obtain_sudo_password
    ar18.script.obtain_sudo_password
    IFS=' '
    local command
    command=""
    local arg
    for arg in "$@"; do
      command="${command} \"${arg}\""
    done
    #echo ""
    #echo "${ar18_sudo_password}" | eval "sudo -Sk $@"
    echo "${ar18_sudo_password}" | eval "sudo -Sk ${command}"
    #echo ""
  }
  export -f "ar18.script.execute_with_sudo"
  
   
}

type ar18.script.execute_with_sudo > /dev/null 2>&1 || ar18.script._execute_with_sudo

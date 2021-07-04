#!/usr/bin/env bash
# ar18


function ar18.script._execute_with_sudo(){


  function ar18.script.execute_with_sudo() {
    # Function template 2021-06-12.01
    local LD_PRELOAD_old
    LD_PRELOAD_old="${LD_PRELOAD}"
    LD_PRELOAD=
    local shell_options
    IFS=$'\n' shell_options=($(shopt -op))
    set -eu
    set -o pipefail
    local ret
    ret=0
    set +x
    ##############################FUNCTION_START#################################
    
    ar18.script.import script.obtain_sudo_password
    ar18.script.obtain_sudo_password
    set -x
    IFS=' '
    local command
    command=""
    local arg
    for arg in "$@"; do
      command="${command} \"${arg}\""
    done
    echo "foo3"
    echo "${ar18_sudo_password}" | eval "sudo -Sk ${command}"
    echo ""
    
    ###############################FUNCTION_END##################################
    set +x
    for option in "${shell_options[@]}"; do
      eval "${option}"
    done
    LD_PRELOAD="${LD_PRELOAD_old}"
    return "${ret}"
  }
  export -f "ar18.script.execute_with_sudo"
  
   
}

type ar18.script.execute_with_sudo > /dev/null 2>&1 || ar18.script._execute_with_sudo

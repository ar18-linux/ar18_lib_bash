#!/usr/bin/env bash


function ar18.script._version_check(){


  function ar18.script.version_check() {
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
    
    echo "version check"
    
    ###############################FUNCTION_END##################################
    set +x
    for option in "${shell_options[@]}"; do
      eval "${option}"
    done
    LD_PRELOAD="${LD_PRELOAD_old}"
    return "${ret}"
  }
  
   
}

type ar18.script.version_check > /dev/null 2>&1 || ar18.script._version_check

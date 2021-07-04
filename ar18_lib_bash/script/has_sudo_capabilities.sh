#!/usr/bin/env bash


function ar18.script._has_sudo_capabilities(){


  function ar18.script.has_sudo_capabilities() {
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
    
    local output
    set +e
    output="$(sudo -vn 2>&1)"
    ret=$?
    set -e
    if [ "${ret}" = "0" ];then
      ret=0
    else
      if [[ "${output}" =~ "sudo: a password is required" ]]; then
        ret=0
      elif [[ "${output}" =~ "Sorry, user" ]]; then
        ret=1
      else
        echo "[ERROR]: Could not determine sudo access from:"
        echo "${output}"
        exit 1
      fi
    fi
    
    ###############################FUNCTION_END##################################
    set +x
    for option in "${shell_options[@]}"; do
      eval "${option}"
    done
    LD_PRELOAD="${LD_PRELOAD_old}"
    return "${ret}"
  }
  
   
}

type ar18.script.has_sudo_capabilities > /dev/null 2>&1 || ar18.script._has_sudo_capabilities

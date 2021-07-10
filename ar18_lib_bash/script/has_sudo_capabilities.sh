#!/usr/bin/env bash
# ar18


function ar18.script._has_sudo_capabilities(){


  function ar18.script.has_sudo_capabilities() {
    # Prepare script environment
    {
      # Function template version 2021-07-10_11:24:30
      # Get old shell option values to restore later
      local shell_options
      shopt -s inherit_errexit
      IFS=$'\n' shell_options=($(shopt -op))
      # Set shell options for this script
      set +x
      set -o pipefail
      set -e
      local LD_PRELOAD_old
      LD_PRELOAD_old="${LD_PRELOAD}"
      set -u
      LD_PRELOAD=
      local ret
      ret=0
    }
    ##############################FUNCTION_START#################################
                    
    local silent
    set +u
    silent="${1}"
    set -u
    if [ "${silent}" = "" ]; then
      silent="0"
    fi
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
        if [ "${silent}" = "0" ]; then
          echo "[ERROR]: Could not determine sudo access from:"
          echo "${output}"
        fi
        exit 1
      fi
    fi
    
    ###############################FUNCTION_END##################################
    # Restore environment
    {
      set +x
      LD_PRELOAD="${LD_PRELOAD_old}"
      # Restore old shell values
      for option in "${shell_options[@]}"; do
        eval "${option}"
      done
    }
    
    return "${ret}"
    
  }
  export -f "ar18.script.has_sudo_capabilities"
  
   
}

type ar18.script.has_sudo_capabilities > /dev/null 2>&1 || ar18.script._has_sudo_capabilities

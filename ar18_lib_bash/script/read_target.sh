#!/usr/bin/env bash
# ar18


function ar18.script._read_target(){


  function ar18.script.read_target() {
    # Prepare script environment
    {
      # Function template version 2021-07-10_14:41:36
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
                                        
    if [ ! -v ar18_deployment_target ]; then
      local ar18_deployment_target2
      set +u
      ar18_deployment_target2="${1}"
      set -u
      if [ "${ar18_deployment_target2}" = "" ]; then
        if [ ! -f "/home/$(whoami)/.config/ar18/deploy/installed_target" ]; then
          read -p "[ERROR]: Cannot find file to determine installed_target"
          exit 1
        else
          ar18_deployment_target2="$(cat "/home/$(whoami)/.config/ar18/deploy/installed_target")"
          echo "${ar18_deployment_target2}"
        fi
      else
        echo "${ar18_deployment_target2}"
      fi
    else 
      echo "${ar18_deployment_target}"
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
  export -f "ar18.script.read_target"
  
   
}

type ar18.script.read_target > /dev/null 2>&1 || ar18.script._read_target

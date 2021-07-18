#!/usr/bin/env bash
# ar18


function ar18.script._kill_processes_by_user(){


  function ar18.script.kill_processes_by_user() {
    # Prepare script environment
    {
      # Function template version 2021-07-14_00:22:16
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
    
    ar18.script.import ar18.script.execute_with_sudo
    
    user_name_or_id="${1}"
    while ps -u "${user_name_or_id}"; do
      ar18.script.execute_with_sudo pkill -u "${user_name_or_id}"
    done
    
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
  export -f "ar18.script.kill_processes_by_user"
      
   
}

type ar18.script.kill_processes_by_user > /dev/null 2>&1 || ar18.script._kill_processes_by_user

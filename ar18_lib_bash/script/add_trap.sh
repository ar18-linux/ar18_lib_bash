#!/usr/bin/env bash
# ar18


function ar18.script._add_trap(){


  function ar18.script.add_trap() {
    # Prepare script environment
    {
      # Function template version 2021-07-11_19:04:49
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
                                                      
    local new_code
    new_code="${1}"
    local signal
    signal="${2}"
    local old_code
    old_code="$(trap -p "${signal}")"
    if [ "${old_code}" = "" ]; then
      eval "trap '${new_code}' ${signal}"
    else
      declare -a a_token
      IFS=$'\t '
      read -ra a_token <<< "${old_code}"
      local code_token
      code_token="${a_token[2]}"
      code_token="${code_token%\'}"
      code_token="${code_token#\'}"
      eval "trap '${new_code}; ${code_token}' ${signal}"
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
  export -f "ar18.script.add_trap"
  
   
}

type ar18.script.add_trap > /dev/null 2>&1 || ar18.script._add_trap

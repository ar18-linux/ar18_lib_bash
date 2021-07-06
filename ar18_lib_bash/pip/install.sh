#!/usr/bin/env bash
# ar18


function ar18.pip._install(){


  function ar18.pip.install() {
    # Prepare script environment
    {
      # Function template version 2021-07-05_23:34:18
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
    }
    ##############################FUNCTION_START#################################
    
    local packages
    packages="$1"
    pip3 install ${packages}
    
    ###############################FUNCTION_END##################################
    # Restore environment
    {
      set +x
      for option in "${shell_options[@]}"; do
        eval "${option}"
      done
      LD_PRELOAD="${LD_PRELOAD_old}"
    }
    
    return "${ret}"
    
  }
  export -f "ar18.pip.install"
      
   
}

type ar18.pip.install > /dev/null 2>&1 || ar18.pip._install

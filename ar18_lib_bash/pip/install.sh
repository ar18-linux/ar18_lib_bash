#!/usr/bin/env bash
# ar18


function ar18.pip._install(){


  function ar18.pip.install() {
    # Prepare script environment
    {
      # Function template version 2021-07-10_13:50:26
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
                            
    local packages
    packages="$1"
    pip3 install ${packages}
    
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
  export -f "ar18.pip.install"
      
   
}

type ar18.pip.install > /dev/null 2>&1 || ar18.pip._install

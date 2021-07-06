#!/usr/bin/env bash
# ar18


function ar18.script._import_vars(){


  function ar18.script.import_vars() {
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
    
    local is_init
    set +u
    is_init="${1}"
    set -u
    if [ "${is_init}" = "1" ]; then
      [ -f "${script_dir}/config/vars" ] && . "${script_dir}/config/vars"
    else
      local module_name
      module_name="$(basename "$(echo "$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )")")"
      if [ ! -f "/home/$(whoami)/.config/ar18/${module_name}/vars" ]; then
        [ -f "${script_dir}/config/vars" ] && . "${script_dir}/config/vars"
      else 
        [ -f "/home/$(whoami)/.config/ar18/${module_name}/vars" ] && . "/home/$(whoami)/.config/ar18/${module_name}/vars"
      fi  
    fi
    
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
  export -f "ar18.script.import_vars"
      
   
}

type ar18.script.import_vars > /dev/null 2>&1 || ar18.script._import_vars

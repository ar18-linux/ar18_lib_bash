#!/usr/bin/env bash
# ar18


function ar18.script._import(){


  function ar18.script.import() {
    # Prepare script environment
    {
      # Function template version 2021-07-06_08:05:30
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
      
    local to_import
    to_import="${1}"
    if [ ! -v import_map ]; then
      declare -Ag import_map
    fi
    if [ ! -v import_map["${to_import}"] ]; then
      import_map["${to_import}"]=1
      local old_cwd="${PWD}"
      local to_import_transformed
      to_import_transformed="${to_import/ar18./}"
      to_import_transformed="${to_import_transformed/./\/}"
      local target_path
      # Check if lib is installed locally
      if [ ! -f "/home/$(whoami)/.config/ar18/ar18_lib_bash/INSTALL_DIR" ]; then
        target_path="/tmp/${ar18_parent_process}/ar18_lib_bash/${to_import_transformed}.sh"
        mkdir -p "$(dirname "${target_path}")"
        cd "$(dirname "${target_path}")"
        curl -O "https://raw.githubusercontent.com/ar18-linux/ar18_lib_bash/master/ar18_lib_bash/${to_import_transformed}.sh" > /dev/null 2>&1
        cd "${old_cwd}" 
        . "${target_path}"
      else
        target_path="$(cat "/home/$(whoami)/.config/ar18/ar18_lib_bash/INSTALL_DIR")/ar18_lib_bash/${to_import_transformed}.sh"
        . "${target_path}"
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
  export -f "ar18.script.import"
      
   
}

type ar18.script.import > /dev/null 2>&1 || ar18.script._import

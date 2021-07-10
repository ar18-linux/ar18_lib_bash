#!/usr/bin/env bash
# ar18


function ar18.script._source_or_execute_config(){


  function ar18.script.source_or_execute_config() {
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
                                    
    ar18.script.import ar18.script.obtain_sudo_password
    ar18.script.import ar18.script.execute_with_sudo
    
    local action
    action="${1}"
    local module_name
    module_name="${2}"
    local ar18_deployment_target
    set +u
    ar18_deployment_target="${3}"
    set -u
    if [ "${ar18_deployment_target}" = "" ]; then
      if [ ! -f "/home/$(whoami)/.config/ar18/deploy/installed_target" ]; then
        read -p "[ERROR]: Cannot find file to determine installed_target"
        exit 1
      else
        ar18_deployment_target="$(cat "/home/$(whoami)/.config/ar18/deploy/installed_target")"
        if [ ! -f "/home/$(whoami)/.config/ar18/${module_name}/${ar18_deployment_target}" ]; then
          read -p "[ERROR]: Cannot find configuration file for [${ar18_deployment_target}]"
          exit 1
        else
          if [ "${action}" = "source" ]; then
            echo "sourcing /home/$(whoami)/.config/ar18/${module_name}/${ar18_deployment_target}"
            . "/home/$(whoami)/.config/ar18/${module_name}/${ar18_deployment_target}"
          elif [ "${action}" = "execute" ]; then
            ar18.script.obtain_sudo_password
            ar18.script.execute_with_sudo chmod +x "/home/$(whoami)/.config/ar18/${module_name}/${ar18_deployment_target}"
            "/home/$(whoami)/.config/ar18/${module_name}/${ar18_deployment_target}"
          fi
        fi
      fi
    else
      if [ -f "/home/$(whoami)/.config/ar18/${module_name}/${ar18_deployment_target}" ]; then
        if [ "${action}" = "source" ]; then
          echo "sourcing /home/$(whoami)/.config/ar18/${module_name}/${ar18_deployment_target}"
          . "/home/$(whoami)/.config/ar18/${module_name}/${ar18_deployment_target}"
        elif [ "${action}" = "execute" ]; then
          ar18.script.obtain_sudo_password
          ar18.script.execute_with_sudo chmod +x "/home/$(whoami)/.config/ar18/${module_name}/${ar18_deployment_target}"
          "/home/$(whoami)/.config/ar18/${module_name}/${ar18_deployment_target}"
        fi
      else
        if [ ! -f "${script_dir}/config/${ar18_deployment_target}" ]; then
          read -p "[ERROR]: Cannot find configuration file for [${ar18_deployment_target}]"
          exit 1
        else
          if [ "${action}" = "source" ]; then
            echo "sourcing ${script_dir}/config/${ar18_deployment_target}"
            . "${script_dir}/config/${ar18_deployment_target}"
          elif [ "${action}" = "execute" ]; then
            ar18.script.obtain_sudo_password
            ar18.script.execute_with_sudo chmod +x "${script_dir}/config/${ar18_deployment_target}"
            "${script_dir}/config/${ar18_deployment_target}"
          fi
        fi
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
  export -f "ar18.script.source_or_execute_config"
  
   
}

type ar18.script.source_or_execute_config > /dev/null 2>&1 || ar18.script._source_or_execute_config

#!/usr/bin/env bash
# ar18


function ar18.script._version_check(){


  function ar18.script.version_check() {
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
        
    ar18_version_checker_caller="$(caller | cut -d ' ' -f2-)"
    ar18_version_checker_caller="$(realpath "${ar18_version_checker_caller}")"
    ar18_version_checker_dir_name="$(dirname "${ar18_version_checker_caller}")"
    ar18_version_checker_module_name="$(basename "${ar18_version_checker_dir_name}")"
    if [ -f "${ar18_version_checker_dir_name}/VERSION" ]; then
      ar18_version_checker_module_version_local="$(cat "${ar18_version_checker_dir_name}/VERSION")"
      ar18.script.obtain_sudo_password
      ar18.script.execute_with_sudo rm -f /tmp/VERSION
      wget "https://raw.githubusercontent.com/ar18-linux/${ar18_version_checker_module_name}/master/${ar18_version_checker_module_name}/VERSION" -P /tmp
      ar18_version_checker_module_version_remote="$(cat "/tmp/VERSION")"
      echo "local version is ${ar18_version_checker_module_version_local}"
      echo "remote version is ${ar18_version_checker_module_version_remote}"
      if [[ "${ar18_version_checker_module_version_remote}" > "${ar18_version_checker_module_version_local}" ]]; then
        echo "new version available"
        ar18.script.obtain_sudo_password
        if [ -f "/home/$(whoami)/.config/ar18/${ar18_version_checker_module_name}/INSTALL_DIR" ]; then
          echo "reinstalling"
          echo "${ar18_version_checker_caller}"
          . "${ar18_version_checker_caller}"
        else
          echo "replacing"
          ar18.script.execute_with_sudo rm -rf "/tmp/${ar18_version_checker_module_name}"
          mkdir -p "/tmp/${ar18_version_checker_module_name}"
          old_cwd="${PWD}"
          cd "/tmp/${ar18_version_checker_module_name}"
          git clone "http://github.com/ar18-linux/${ar18_version_checker_module_name}"
          ar18.script.execute_with_sudo cp -raf "/tmp/${ar18_version_checker_module_name}/${ar18_version_checker_module_name}/${ar18_version_checker_module_name}/." "${ar18_version_checker_dir_name}/"
          cd "${old_cwd}"
          . "${ar18_version_checker_caller}"
        fi
        # Return or exit depending on whether the script was sourced or not
        if [ "${ar18_sourced_map["${ar18_version_checker_caller}"]}" = "1" ]; then
          return "${ar18_exit_map["${ar18_version_checker_caller}"]}"
        else
          exit "${ar18_exit_map["${ar18_version_checker_caller}"]}"
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
  
   
}

type ar18.script.version_check > /dev/null 2>&1 || ar18.script._version_check

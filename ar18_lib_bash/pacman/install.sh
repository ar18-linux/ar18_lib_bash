#!/usr/bin/env bash
# ar18


function ar18.pacman._install(){


  function ar18.pacman.install() {
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
      
    ar18.script.import ar18.script.obtain_sudo_password
    ar18.script.import ar18.script.execute_with_sudo
    
    ar18.script.obtain_sudo_password
    if [ ! -v ar18_pacman_cache_updated ]; then
      ar18.script.execute_with_sudo pacman -Syu --noconfirm
      export ar18_pacman_cache_updated=1
    fi
    ar18.script.execute_with_sudo pacman -S expect --noconfirm --needed
    local install_dir
    if [ -f "/home/$(whoami)/.config/ar18_lib_bash/INSTALL_DIR" ]; then
      install_dir="$(cat "/home/$(whoami)/.config/ar18_lib_bash/INSTALL_DIR")"
    else
      install_dir="/tmp/${ar18_parent_process}/ar18_lib_bash"
      # Get expect script
      if [ ! -f "${install_dir}/pacman/expect_pacman.tcl" ]; then
        mkdir -p "${install_dir}/pacman"
        local old_cwd
        old_cwd="${PWD}"
        cd "${install_dir}/pacman"
        curl -O https://raw.githubusercontent.com/ar18-linux/ar18_lib_bash/master/ar18_lib_bash/pacman/expect_pacman.tcl > /dev/null 2>&1
        cd "${old_cwd}"
      fi
    fi
    ar18.script.execute_with_sudo chmod +x "${install_dir}/pacman/expect_pacman.tcl"
    for arg in "$@"; do
      ar18.script.execute_with_sudo "${install_dir}/pacman/expect_pacman.tcl" "${arg}"
    done
    
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
  export -f "ar18.pacman.install"
      
   
}

type ar18.pacman.install > /dev/null 2>&1 || ar18.pacman._install
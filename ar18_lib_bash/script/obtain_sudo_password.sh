#!/usr/bin/env bash


function ar18.script._obtain_sudo_password(){


  function ar18.script.obtain_sudo_password() {
    # Function template 2021-06-12.01
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
    ##############################FUNCTION_START#################################
    ar18.script.import script.has_sudo_capabilities
    
    if [ "$(whoami)" = "root" ]; then
      read -p "[ERROR]: Must not be root!"
      exit 1
    fi
    if [ ! -v ar18_sudo_password ]; then
      echo "Testing for sudo capabilities..."
      
      if $(ar18.script.has_sudo_capabilities); then
        echo "Sudo rights have been asserted"
      else
         read -p "[ERROR]: User $(whoami) does not have sudo rights, aborting"; 
         exit 1
      fi
      local sudo_passwd
      read -s -p "Enter your password: " sudo_passwd
      echo ""
      echo "Testing the password with 'sudo -Sk id'"
      if [ ! "$(echo "${sudo_passwd}" | sudo -Sk id)" ]; then
        read -p "[ERROR]: Password is wrong (keyboard layout wrong, CAPS lock on?), or maybe your account is locked due to too many wrong password attempts. In this case, reset the counter with '#faillock --reset'"; 
        exit 1
      fi
      export ar18_sudo_password="${sudo_passwd}"
    fi
    
    ###############################FUNCTION_END##################################
    set +x
    for option in "${shell_options[@]}"; do
      eval "${option}"
    done
    LD_PRELOAD="${LD_PRELOAD_old}"
    return "${ret}"
  }
  export -f "ar18.script.obtain_sudo_password"
  
   
}

type ar18.script.obtain_sudo_password > /dev/null 2>&1 || ar18.script._obtain_sudo_password

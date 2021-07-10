#!/usr/bin/env bash
# ar18


function ar18.script._obtain_sudo_password(){


  function ar18.script.obtain_sudo_password() {
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
                                        
    ar18.script.import script.has_sudo_capabilities
    
    local silent
    set +u
    silent="${1}"
    set -u
    if [ "${silent}" = "" ]; then
      silent="0"
    fi
    
    if [ "$(whoami)" = "root" ]; then
      if [ "${silent}" = "0" ]; then 
        read -p "[ERROR]: Must not be root!"
        echo ""
      fi
      exit 1
    fi
    if [ ! -v ar18_sudo_password ]; then
      if [ "${silent}" = "0" ]; then
        echo "Testing for sudo capabilities..."
      fi
      
      if $(ar18.script.has_sudo_capabilities "${silent}"); then
        if [ "${silent}" = "0" ]; then
          echo "Sudo rights have been asserted"
        fi
      else
        if [ "${silent}" = "0" ]; then
          read -p "[ERROR]: User $(whoami) does not have sudo rights, aborting"
          echo ""
        fi
         exit 1
      fi
      local sudo_passwd
      if [ "${silent}" = "0" ]; then
        read -s -p "Enter your password: " sudo_passwd
        echo ""
      else
        read -s -p "" sudo_passwd
      fi
      if [ "${silent}" = "0" ]; then
        echo "Testing the password with 'sudo -Sk id'"
      fi
      if [ ! "$(echo "${sudo_passwd}" | sudo -Sk -p ' ' id)" ]; then
        if [ "${silent}" = "0" ]; then
          read -p "[ERROR]: Password is wrong (keyboard layout wrong, CAPS lock on?), or maybe your account is locked due to too many wrong password attempts. In this case, reset the counter with '#faillock --reset'"
          echo ""         
        fi
        exit 1
      fi
      export ar18_sudo_password="${sudo_passwd}"
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
  export -f "ar18.script.obtain_sudo_password"
  
   
}

type ar18.script.obtain_sudo_password > /dev/null 2>&1 || ar18.script._obtain_sudo_password

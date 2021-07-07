#!/usr/bin/env bash
# ar18


function ar18.aur._install(){


  function ar18.aur.install() {
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
    ar18.script.import ar18.pacman.install
    ar18.script.import ar18.script.execute_with_sudo
    
    ar18.script.obtain_sudo_password
    ar18.pacman.install fakeroot binutils
    for package in "$@"; do
      local name
      name="${package}"
      ar18.script.execute_with_sudo rm -rf "/tmp/build" 
      mkdir "/tmp/build"
      cd "/tmp/build"
      git clone "https://aur.archlinux.org/${name}.git"
      cd "/tmp/build/${name}"
      set +e
      LD_PRELOAD= makepkg -m --noconfirm
      if [ "$?" != "0" ]; then
        out="$(LD_PRELOAD= makepkg -m --noconfirm)"
        echo "${out}" | grep "Missing dependencies"
        if [ "$?" = "0" ]; then
          out="$(echo "${out}" | grep '\->')"
          declare -a arr
          arr=(echo ${out})
          for item in "${arr[@]}"; do
            if [ "${item}" != "->" ] && [ "${item}" != "" ]; then
              clean="$(echo "${item}" | sed -e 's/>=.*//g')"
              clean="$(echo "${clean}" | sed -e 's/->//g' | xargs)"
              ar18.pacman.install "${clean}"
            fi
          done
        fi
        LD_PRELOAD= makepkg --noconfirm
      fi
      set -e
      ar18.script.execute_with_sudo pacman -U --noconfirm --asdep ./*zst
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
  export -f "ar18.aur.install"
      
   
}

type ar18.aur.install > /dev/null 2>&1 || ar18.aur._install
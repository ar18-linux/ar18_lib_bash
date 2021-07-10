#!/usr/bin/env bash
# ar18


function ar18.script._install(){


  function ar18.script.install() {
    # Prepare script environment
    {
      # Function template version 2021-07-10_13:35:39
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
                      
    ar18.script.import ar18.script.execute_with_sudo
    ar18.script.import ar18.script.obtain_sudo_password
  
    local install_dir
    install_dir="$1"
    local module_name
    module_name="$2"
    local script_dir
    script_dir="$3"
    
    ar18.script.obtain_sudo_password
    
    ar18.script.execute_with_sudo mkdir -p "${install_dir}"
    ar18.script.execute_with_sudo rm -rf "${install_dir}/${module_name}"
    ar18.script.execute_with_sudo cp -rf "${script_dir}/${module_name}" "${install_dir}/${module_name}"
    ar18.script.execute_with_sudo chmod +x "${install_dir}/${module_name}/"* -R
    
    if [ ! -v user_name ]; then
      user_name="$(whoami)"
    fi
    
    if [ -f "${script_dir}/${module_name}/vars" ]; then
      read -p "fix ${module_name}"
      exit 66
      mkdir -p "/home/${user_name}/.config/ar18/${module_name}"
      ar18.script.execute_with_sudo chown "${user_name}:${user_name}" "/home/${user_name}/.config/ar18/${module_name}"
      if [ ! -f "/home/${user_name}/.config/ar18/${module_name}/vars" ]; then
        cp ${script_dir}/${module_name}/vars /home/${user_name}/.config/ar18/${module_name}/vars
        ar18.script.execute_with_sudo chown "${user_name}:${user_name}" "/home/${user_name}/.config/ar18/${module_name}/vars"
      fi
    fi
    
    mkdir -p "/home/${user_name}/.config/ar18/${module_name}"
    ar18.script.execute_with_sudo chown "${user_name}:${user_name}" "/home/${user_name}/.config/ar18/${module_name}"
    echo "${install_dir}" > "/home/${user_name}/.config/ar18/${module_name}/INSTALL_DIR"
    
    if [ -d "${script_dir}/${module_name}/config" ]; then
      local base_name  
      for filename in "${script_dir}/${module_name}/config/"*; do
        base_name="$(basename "${filename}")"
        if [ ! -f "/home/${user_name}/.config/ar18/${module_name}/${base_name}" ]; then
          cp "${filename}" "/home/${user_name}/.config/ar18/${module_name}/${base_name}"
          ar18.script.execute_with_sudo chown "${user_name}:${user_name}" "/home/${user_name}/.config/ar18/${module_name}/${base_name}"
        fi
      done
    fi
    
    if [ -f "${script_dir}/${module_name}/${module_name}.service" ]; then
      ar18.script.execute_with_sudo sed -i "s^{{INSTALL_DIR}}^${install_dir}^g" "${install_dir}/${module_name}/${module_name}.service"
      ar18.script.execute_with_sudo chmod 644 "${install_dir}/${module_name}/${module_name}.service"
      ar18.script.execute_with_sudo rm -rf "/etc/systemd/system/${module_name}.service"
      ar18.script.execute_with_sudo ln -s "${install_dir}/${module_name}/${module_name}.service" "/etc/systemd/system/${module_name}.service"
      ar18.script.execute_with_sudo systemctl enable "${module_name}.service"
      ar18.script.execute_with_sudo systemctl start "${module_name}.service"
    fi
    
    if [ -f "${install_dir}/${module_name}/autostart.sh" ]; then
      if [ ! -d "/home/${user_name}/.config/ar18/autostarts" ]; then
        mkdir -p "/home/${user_name}/.config/ar18/autostarts"
      fi
      auto_start="/home/${user_name}/.config/ar18/autostarts/${module_name}.sh"
      ar18.script.execute_with_sudo cp "${script_dir}/${module_name}/autostart.sh" "${auto_start}"
      ar18.script.execute_with_sudo chmod 4750 "${auto_start}"
      ar18.script.execute_with_sudo chown "root:${user_name}" "${auto_start}"
      ar18.script.execute_with_sudo sed -i "s~{{INSTALL_DIR}}~${install_dir}~g" "${auto_start}"
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
  export -f "ar18.script.install"
      
   
}

type ar18.script.install > /dev/null 2>&1 || ar18.script._install

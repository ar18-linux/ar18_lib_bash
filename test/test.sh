#!/bin/bash
# ar18

# Prepare script environment
{
  # Script template version 2021-07-04_12:24:18
  # Make sure some modification to LD_PRELOAD will not alter the result or outcome in any way
  LD_PRELOAD_old="${LD_PRELOAD}"
  LD_PRELOAD=
  # Determine the full path of the directory this script is in
  script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
  script_path="${script_dir}/$(basename "${0}")"
  #Set PS4 for easier debugging
  export PS4='\e[35m${BASH_SOURCE[0]}:${LINENO}: \e[39m'
  # Determine if this script was sourced or is the parent script
  if [ ! -v ar18_sourced_map ]; then
    declare -A -g ar18_sourced_map
  fi
  if [[ "${BASH_SOURCE[0]}" != "${0}" ]]; then
    ar18_sourced_map["${script_path}"]=1
  else
    ar18_sourced_map["${script_path}"]=0
  fi
  # Initialise exit code
  if [ -z "${ar18_exit_map+x}" ]; then
    declare -A -g ar18_exit_map
  fi
  ar18_exit_map["${script_path}"]=0
  # Get old shell option values to restore later
  shopt -s inherit_errexit
  IFS=$'\n' shell_options=($(shopt -op))
  # Set shell options for this script
  set -o pipefail
  set -eu
  cwd="${PWD}"
  cd /tmp
  curl -O https://raw.githubusercontent.com/ar18-linux/ar18_lib_bash/master/ar18_lib_bash/script/import.sh && . "/tmp/import.sh"
  cd "${cwd}"
}
#################################SCRIPT_START##################################
{
  #. "${script_dir}/../ar18_lib_bash/script/import.sh"
  ar18.script.import script.obtain_sudo_password
  ar18.script.obtain_sudo_password
  echo "${ar18_sudo_password}" | sudo -Sk whoami
}
#ar18.script.version_check

##################################SCRIPT_END###################################
# Restore environment
{
  # Restore old shell values
  set +x
  for option in "${shell_options[@]}"; do
    eval "${option}"
  done
  # Restore LD_PRELOAD
  LD_PRELOAD="${LD_PRELOAD_old}"
}
# Return or exit depending on whether the script was sourced or not
{
  if [ "${ar18_sourced_map["${script_path}"]}" = "1" ]; then
    return "${ar18_exit_map["${script_path}"]}"
  else
    exit "${ar18_exit_map["${script_path}"]}"
  fi
}
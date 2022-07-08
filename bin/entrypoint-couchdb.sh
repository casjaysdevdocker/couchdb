#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version           :  202207080823-git
# @Author            :  Jason Hempstead
# @Contact           :  jason@casjaysdev.com
# @License           :  LICENSE.md
# @ReadME            :  entrypoint-couchdb.sh --help
# @Copyright         :  Copyright: (c) 2022 Jason Hempstead, Casjays Developments
# @Created           :  Friday, Jul 08, 2022 08:23 EDT
# @File              :  entrypoint-couchdb.sh
# @Description       :
# @TODO              :
# @Other             :
# @Resource          :
# @sudo/root         :  no
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
APPNAME="$(basename "$0" 2>/dev/null)"
VERSION="202207080823-git"
HOME="${USER_HOME:-$HOME}"
USER="${SUDO_USER:-$USER}"
RUN_USER="${SUDO_USER:-$USER}"
SRC_DIR="${BASH_SOURCE%/*}"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Set bash options
if [[ "$1" == "--debug" ]]; then shift 1 && set -xo pipefail && export SCRIPT_OPTS="--debug" && export _DEBUG="on"; fi
trap 'exitCode=${exitCode:-$?}' EXIT

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -'
__exec_bash() { [ $# -ne 0 ] && exec "${*:-bash -l}" || exec /bin/bash -l; }
__find() { ls -A "$*" 2>/dev/null; }
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
DATA_DIR="$(__find /data/ 2>/dev/null | grep '^' || false)"
CONFIG_DIR="$(__find /config/ 2>/dev/null | grep '^' || false)"
export TZ="${TZ:-America/New_York}"
export HOSTNAME="${HOSTNAME:-casjaysdev-couchdb}"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if [[ -n "${TZ}" ]]; then
  echo "${TZ}" >/etc/timezone
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if [[ -f "/usr/share/zoneinfo/${TZ}" ]]; then
  ln -sf "/usr/share/zoneinfo/${TZ}" "/etc/localtime"
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if [[ -n "${HOSTNAME}" ]]; then
  echo "${HOSTNAME}" >/etc/hostname
  echo "127.0.0.1 $HOSTNAME localhost" >/etc/hosts
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
case "$1" in
--help)
  curl -q -LSsf http://127.0.0.1:5984 | jq '.version' | grep -q '^'
  exit $?
  ;;
healthcheck)
  echo 'OK'
  ;;
bash | shell | sh)
  shift 1
  __exec_bash "$@"
  ;;
*)
  __exec_bash "$@"
  ;;
esac
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#end

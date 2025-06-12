#!/bin/bash

GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
RESET="\e[0m"

usage() {
  echo -e "${YELLOW}Usage: $0 -d <log-directory>${RESET}"
  exit 1
}

while getopts ":d:" opt; do
  case ${opt} in
    d )
      LOG_DIR=$OPTARG
      ;;
    \? )
      echo -e "${RED}Invalid option: -$OPTARG${RESET}" >&2
      usage
      ;;
    : )
      echo -e "${RED}Option -$OPTARG requires an argument.${RESET}" >&2
      usage
      ;;
  esac
done

if [ -z "$LOG_DIR" ]; then
  echo -e "${RED}Error: Log directory is required.${RESET}"
  usage
fi

echo -e "${GREEN}Log directory received: $LOG_DIR${RESET}"


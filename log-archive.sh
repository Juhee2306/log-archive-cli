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

ARCHIVE_DIR="./archives"
mkdir -p "$ARCHIVE_DIR"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
ARCHIVE_NAME="logs_archive_${TIMESTAMP}.tar.gz"
tar -czf"$ARCHIVE_NAME" -C "$(dirname "$LOG_DIR")" "$(basename "$LOG_DIR")"
mv "$ARCHIVE_NAME" "$ARCHIVE-DIR/"
echo -e "${GREEN}Logs compressed successfully into: $AECHIVE_DIR/$ARCHIVE_NAME${RESET}"

HISTORY_LOG="./archive_history.txt"
{
  echo "---------------------------------------------"
  echo "Date:        $(date)"
  echo "Directory:   $LOG_DIR"
  echo "Archive:     $ARCHIVE_DIR/$ARCHIVE_NAME"
} >> "$HISTORY_LOG"

echo -e "${YELLOW}Archive history logged to $HISTORY_LOG${RESET}"

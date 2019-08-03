#!/bin/bash

API_EXPLORER_PATH="API-Explorer/"
#SOCIAL_FINANCE_PATH="Social-Finance/"
#OBP_API_PATH="OBP-API/"

API_EXPLORER_RUN="sh run.sh"
#SOCIAL_FINANCE_RUN="sh run.sh"
#OBP_API_RUN="sh run.sh"

function main() {
	run_server "Api Explorer" "$API_EXPLORER_PATH" "$API_EXPLORER_RUN"
	#run_server "Social Finance" "$SOCIAL_FINANCE_PATH" "$SOCIAL_FINANCE_RUN"
	#run_server "Obp_Api" "$OBP_API_PATH" "$OBP_API_RUN"
}

main

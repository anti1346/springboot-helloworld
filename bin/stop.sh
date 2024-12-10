#!/bin/bash

# 설정: 인스턴스 디렉토리, 포트, 로그 파일 이름
INSTANCE_DIR="/app/instance"
INSTANCE_PORT="8080"
LOG_FILE="${INSTANCE_PORT}.log"

# 인스턴스 경로
INSTANCE_PATH="${INSTANCE_DIR}/${INSTANCE_PORT}"

# 디렉토리 이동
if ! cd "${INSTANCE_PATH}"; then
    echo "Error: Failed to navigate to ${INSTANCE_PATH}"
    exit 1
fi
echo "Navigated to instance directory: ${INSTANCE_PATH}"

# 애플리케이션 프로세스 확인
APP_PID=$(ps -ef | grep "[j]ava.*--server.port=${INSTANCE_PORT}" | awk '{print $2}')

# 프로세스 종료 & 프로세스 ID 출력
echo "No application is running on port ${INSTANCE_PORT}."
echo "Logs available at: ${INSTANCE_PATH}/${LOG_FILE}"
echo "Stopping application with PID: ${APP_PID}..."
kill "${APP_PID}"

if [[ $? -eq 0 ]]; then
    echo "Application stopped successfully."
else
    echo "Error: Failed to stop application."
    exit 1
fi

exit 0

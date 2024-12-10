#!/bin/bash

# 설정
INSTANCE_DIR="/app/instance"
INSTANCE_PORT="8080"
LOG_FILE="app.log"

# 인스턴스 경로
INSTANCE_PATH="${INSTANCE_DIR}/${INSTANCE_PORT}"

# 인스턴스 디렉토리로 이동
echo "Navigating to instance directory: ${INSTANCE_PATH}"
cd "${INSTANCE_PATH}" || { echo "Error: Failed to navigate to ${INSTANCE_PATH}"; exit 1; }

# 실행 중인 애플리케이션 프로세스 확인
APP_PID=$(ps -ef | grep "[j]ava.*--server.port=${INSTANCE_PORT}" | awk '{print $2}')

if [[ -z "${APP_PID}" ]]; then
  echo "No application is running on port ${INSTANCE_PORT}."
  exit 0
fi

# 프로세스 종료
echo "Stopping application with PID: ${APP_PID}..."
kill "${APP_PID}"

# 종료 확인
if [[ $? -eq 0 ]]; then
  echo "Application stopped successfully."
else
  echo "Error: Failed to stop application."
  exit 1
fi

# 로그 출력
echo "Logs available at: ${INSTANCE_PATH}/${LOG_FILE}"

exit 0

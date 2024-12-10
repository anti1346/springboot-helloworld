#!/bin/bash

# 설정: 인스턴스 디렉토리 및 포트
INSTANCE_DIR="/app/instance"
INSTANCE_PORT="8080"
JAR_FILE="demo-0.0.1-SNAPSHOT.jar"
LOG_FILE="app.log"

# 인스턴스 경로 설정
INSTANCE_PATH="${INSTANCE_DIR}/${INSTANCE_PORT}"

# 인스턴스 디렉토리로 이동
echo "Navigating to instance directory: ${INSTANCE_PATH}"
cd "${INSTANCE_PATH}" || { echo "Error: Failed to navigate to ${INSTANCE_PATH}"; exit 1; }

# 로그 파일 백업
if [[ -f "${LOG_FILE}" ]]; then
    TIMESTAMP=$(date "+%Y%m%d_%H%M%S")
    mv "${LOG_FILE}" "${LOG_FILE}_${TIMESTAMP}"
    echo "Existing log file backed up as ${LOG_FILE}_${TIMESTAMP}"
fi

# 애플리케이션 시작
echo "Starting application with port ${INSTANCE_PORT}"
nohup java -jar "${JAR_FILE}" --server.port="${INSTANCE_PORT}" > "${LOG_FILE}" 2>&1 &

# 프로세스 ID 출력
APP_PID=$!
echo "Application started successfully with PID: ${APP_PID}"
echo "Logs: ${INSTANCE_PATH}/${LOG_FILE}"

exit 0
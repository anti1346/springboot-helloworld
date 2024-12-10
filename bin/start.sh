#!/bin/bash

# 설정: 인스턴스 디렉토리, 포트, JAR 파일 경로, 로그 파일 이름
INSTANCE_DIR="/app/instance"
INSTANCE_PORT="8080"
JAR_DIR="../demo/build/libs"
JAR_FILE="demo-0.0.1-SNAPSHOT.jar"
LOG_FILE="${INSTANCE_PORT}.log"

# 인스턴스 경로
INSTANCE_PATH="${INSTANCE_DIR}/${INSTANCE_PORT}"

# 디렉토리 이동
if ! cd "${INSTANCE_PATH}"; then
    echo "Error: Failed to navigate to ${INSTANCE_PATH}"
    exit 1
fi
echo "Navigated to instance directory: ${INSTANCE_PATH}"

# 로그 파일 백업
if [[ -f "${LOG_FILE}" ]]; then
    TIMESTAMP=$(date "+%Y%m%d_%H%M%S")
    mv "${LOG_FILE}" "${LOG_FILE}_${TIMESTAMP}"
    echo "Existing log file backed up as ${LOG_FILE}_${TIMESTAMP}"
fi

# 애플리케이션 시작
echo "Starting application on port ${INSTANCE_PORT}..."
nohup java -jar "${JAR_DIR}/${JAR_FILE}" --server.port="${INSTANCE_PORT}" > "${LOG_FILE}" 2>&1 &
APP_PID=$!

# 프로세스 ID 출력
echo "Application started successfully with PID: ${APP_PID}"
echo "Logs available at: ${INSTANCE_PATH}/${LOG_FILE}"

exit 0

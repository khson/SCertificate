#!/bin/bash

SUPPORTED_PLATFORMS="iphoneos iphonesimulator"
PROJECT_NAME="SCertificate"
CURRENT_WORKING_DIR=`pwd`
BUILD_DIR="${CURRENT_WORKING_DIR}/build"

cp -R "${BUILD_DIR}/iphoneos/${PROJECT_NAME}.framework" "${BUILD_DIR}/"
 
lipo -create -output "${BUILD_DIR}/${PROJECT_NAME}.framework/${PROJECT_NAME}" \
  "${BUILD_DIR}/iphoneos/${PROJECT_NAME}.framework/${PROJECT_NAME}" \
  "${BUILD_DIR}/iphonesimulator/${PROJECT_NAME}.framework/${PROJECT_NAME}"
 
echo "Fat Framework Built : ${BUILD_DIR}/${PROJECT_NAME}.framework"
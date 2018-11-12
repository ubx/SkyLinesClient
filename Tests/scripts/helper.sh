#!/usr/bin/env bash

adb=/home/andreas/opt/android-sdk-linux2/platform-tools/adb

DEVICE="192.168.58.101:5555"
PROJECT_DIR="/home/andreas/IdeaProjects/SkyLinesTracker3"
TEST_DIR="${PROJECT_DIR}/Tests"
IP=$(hostname -I | awk '{print $1}')
INT=2
KEY="ABCD1234"

cd ${TEST_DIR}/scripts
rm -rf sim-test*.out
rm -rf rcv-test*.out
pkill -f UDP-Receiver.jar
pkill -f gps_simulator.py

set_internet_connection() {
  $adb -s ${DEVICE} shell svc data $1
  $adb -s ${DEVICE} shell svc wifi $1
}

shutdown() {
  $adb -s ${DEVICE} shell am force-stop ch.luethi.skylinestracker
  $adb -s ${DEVICE} emu kill
  sh stopEmulator.sh
}
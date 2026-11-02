#!/bin/bash

IFACE="${1:-can0}"
BITRATE="${2:-1000000}"

echo "=== CAN activate: ${IFACE} ${BITRATE} ==="

# 1. CANを有効化
bash can_activate.sh "$IFACE" "$BITRATE"

if [ $? -ne 0 ]; then
    echo "ERROR: CANの有効化に失敗しました"
    exit 1
fi

# 2. bus-infoを取得
BUS_INFO=$(sudo ethtool -i "$IFACE" | awk '/bus-info:/ {print $2}')

if [ -z "$BUS_INFO" ]; then
    echo "ERROR: bus-infoを取得できませんでした"
    exit 1
fi

echo "bus-info: $BUS_INFO"

# 3. bus-infoを指定して再度CANを有効化
bash can_activate.sh "$IFACE" "$BITRATE" "$BUS_INFO"

if [ $? -ne 0 ]; then
    echo "ERROR: bus-info指定でのCAN有効化に失敗しました"
    exit 1
fi

echo "CAN setup completed: $IFACE ($BUS_INFO)"

#!/usr/bin/env python3
import os
import json
import time
from datetime import datetime

log_dir = "/var/log"
log_file = f"{datetime.now():%Y-%m-%d}-awesome-monitoring.log"
log_path = os.path.join(log_dir, log_file)

def cpu_utilization():
    with open("/proc/stat") as f:
        cpu_line = f.readline().strip()
    fields = cpu_line.split()
    values = list(map(float, fields[1:]))
    idle = values[3]
    total = sum(values)
    return idle, total

def cpu_usage(interval=1):
    idle1, total1 = cpu_utilization()
    time.sleep(interval)
    idle2, total2 = cpu_utilization()
    total_delta = total2 - total1
    if total_delta == 0:
        return 0
    usage = (1 - (idle2 - idle1) / total_delta) * 100
    return round(usage, 2)

def ram_usage():
    meminfo = {}
    with open("/proc/meminfo") as f:
        for line in f:
            key, value = line.split(":")
            meminfo[key] = int(value.strip().split()[0])
    total = meminfo["MemTotal"]
    available = meminfo.get("MemAvailable", meminfo["MemFree"])
    used_percent = (1 - available / total) * 100
    return round(used_percent, 2)

def network_utilization():
    net_data = {}
    with open("/proc/net/dev") as f:
        lines = f.readlines()[2:]
    for line in lines:
        if ":" not in line:
            continue
        iface, data = line.strip().split(":", 1)
        fields = data.split()
        if len(fields) < 9:
            continue
        net_data[iface.strip()] = {
            "rx_bytes": int(fields[0]),
            "tx_bytes": int(fields[8]),
        }
    return net_data

def network_datarate(interval=1):
    start = network_utilization()
    time.sleep(interval)
    end = network_utilization()
    datarate = {}
    for iface in start:
        rx_diff = end[iface]["rx_bytes"] - start[iface]["rx_bytes"]
        tx_diff = end[iface]["tx_bytes"] - start[iface]["tx_bytes"]
        datarate[iface] = {
            "rx_Mbps": ((rx_diff * 8) / 1_000_000 / interval, 2),
            "tx_Mbps": ((tx_diff * 8) / 1_000_000 / interval, 2),
        }
    return datarate

def disk_usage():
    statvfs = os.statvfs("/")
    total = statvfs.f_blocks * statvfs.f_frsize
    available = statvfs.f_bavail * statvfs.f_frsize
    used_percent = (1 - available / total) * 100
    return round(used_percent, 2)

def disk_utilization():
    disks = {}
    with open("/proc/diskstats") as f:
        for line in f:
            parts = line.split()
            if len(parts) < 14:
                continue
            dev_name = parts[2]
            if dev_name.startswith(("loop", "ram", "dm-", "sr")):
                continue
            reads = int(parts[3])
            writes = int(parts[7])
            io_time = int(parts[12])
            disks[dev_name] = {
                "reads_completed": reads,
                "writes_completed": writes,
                "io_time_ms": io_time,
            }
    return disks

def cpu_temperature():
    thermal_base = "/sys/class/thermal"
    temps = []
    for entry in os.listdir(thermal_base):
        type_path = os.path.join(thermal_base, entry, "type")
        temp_path = os.path.join(thermal_base, entry, "temp")
        if os.path.exists(type_path) and os.path.exists(temp_path):
            with open(temp_path) as tf:
                temp = int(tf.read().strip()) / 1000.0
                temps.append(temp)
    return round(sum(temps) / len(temps), 1) if temps else None

def collect_metrics():
    metrics = {
        "timestamp": int(time.time()),
        "cpu_usage_percent": cpu_usage(),
        "ram_usage_percent": ram_usage(),
        "network": network_datarate(),
        "disk_usage_percent": disk_usage(),
        "disk_io": disk_utilization(),
        "cpu_temperature_c": cpu_temperature(),
    }
    return metrics

def write_metrics(metrics):
    os.makedirs(log_dir, exist_ok=True)
    with open(log_path, "a") as f:
        json.dump(metrics, f, ensure_ascii=False)
        f.write("\n")

def main():
    metrics = collect_metrics()
    write_metrics(metrics)

if __name__ == "__main__":
    main()

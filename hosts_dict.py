hosts = {
    "bb1": {
        "mgmt_ip": "192.168.0.1",
        "mgmt_mask": "24",
        "loopback0": "198.18.255.1",
        "role": "bb",
        "uplinks": {
            "ethernet1": "198.18.0.0/31",
            "ethernet2": "198.18.0.4/31",
        },
    },
    "bb2": {
        "mgmt_ip": "192.168.0.2",
        "mgmt_mask": "24",
        "loopback0": "198.18.255.2",
        "role": "bb",
    },
    "bb3": {
        "mgmt_ip": "192.168.0.3",
        "mgmt_mask": "24",
        "loopback0": "198.18.255.3",
        "role": "bb",
    },
    "bb4": {
        "mgmt_ip": "192.168.0.4",
        "mgmt_mask": "24",
        "loopback0": "198.18.255.4",
        "role": "bb",
    },
    "bb5": {
        "mgmt_ip": "192.168.0.5",
        "mgmt_mask": "24",
        "loopback0": "198.18.255.5",
        "role": "headend",
    },
    "bb6": {
        "mgmt_ip": "192.168.0.6",
        "mgmt_mask": "24",
        "loopback0": "198.18.255.6",
        "role": "headend",
    },
    "m7": {
        "mgmt_ip": "192.168.0.7",
        "mgmt_mask": "24",
        "loopback0": "198.18.255.7",
        "headend": "bb5",
    },
    "m8": {
        "mgmt_ip": "192.168.0.8",
        "mgmt_mask": "24",
        "loopback0": "198.18.255.8",
        "headend": "bb5",
    },
    "m9": {
        "mgmt_ip": "192.168.0.9",
        "mgmt_mask": "24",
        "loopback0": "198.18.255.9",
        "headend": "bb5",
    },
    "m10": {
        "mgmt_ip": "192.168.0.10",
        "mgmt_mask": "24",
        "loopback0": "198.18.255.10",
        "headend": "bb6",
    },
    "m11": {
        "mgmt_ip": "192.168.0.11",
        "mgmt_mask": "24",
        "loopback0": "198.18.255.11",
        "headend": "bb6",
    },
    "m12": {
        "mgmt_ip": "192.168.0.12",
        "mgmt_mask": "24",
        "loopback0": "198.18.255.12",
        "headend": "bb6",
    },
    "dc13": {
        "mgmt_ip": "192.168.0.13",
        "mgmt_mask": "24",
        "loopback0": "198.18.255.13",
    },
    "sw14": {
        "mgmt_ip": "192.168.0.14",
        "mgmt_mask": "24",
        "loopback0": "198.18.255.14",
    },
    "sw15": {
        "mgmt_ip": "192.168.0.15",
        "mgmt_mask": "24",
        "loopback0": "198.18.255.15",
    },
    "ce16": {
        "mgmt_ip": "192.168.0.16",
        "mgmt_mask": "24",
        "loopback0": "198.18.255.16",
    },
    "ce17": {
        "mgmt_ip": "192.168.0.17",
        "mgmt_mask": "24",
        "loopback0": "198.18.255.17",
    },
    "ce18": {
        "mgmt_ip": "192.168.0.18",
        "mgmt_mask": "24",
        "loopback0": "198.18.255.18",
    },
    "rr19": {
        "mgmt_ip": "192.168.0.19",
        "mgmt_mask": "24",
        "loopback0": "198.18.255.19",
    },
    "rr20": {
        "mgmt_ip": "192.168.0.20",
        "mgmt_mask": "24",
        "loopback0": "198.18.255.20",
    },
    "pe21": {
        "mgmt_ip": "192.168.0.21",
        "mgmt_mask": "24",
        "loopback0": "198.18.255.21",
    },
    "pe22": {
        "mgmt_ip": "192.168.0.22",
        "mgmt_mask": "24",
        "loopback0": "198.18.255.22",
    },
    "c23": {
        "mgmt_ip": "192.168.0.23",
        "mgmt_mask": "24",
        "loopback0": "198.18.255.23",
    },
    "c24": {
        "mgmt_ip": "192.168.0.24",
        "mgmt_mask": "24",
        "loopback0": "198.18.255.24",
    },
    "t25": {
        "mgmt_ip": "192.168.0.25",
        "mgmt_mask": "24",
        "loopback0": "198.18.255.25",
    },
    "t26": {
        "mgmt_ip": "192.168.0.26",
        "mgmt_mask": "24",
        "loopback0": "198.18.255.26",
    },
}

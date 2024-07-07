from jinja2 import Template
from hosts_dict import hosts
import os

root_dir = os.path.abspath(".")
startup_config_dir = os.path.join(root_dir, "startup_config")
os.makedirs(startup_config_dir, exist_ok=True)


def generate_startup_config(k, v):
    template = """\
username admin privilege 15 role network-admin secret sha512 $6$YgdUYiepMhT874b3$SrtLmDXpd6tcCaNNFsQvmHdDQdiGIfAPoD/dp7L0kQ0fJ8L28Na69W1AIZI./m8t1n9woqMI2qRXRRwuoC5Et/
!
switchport default mode routed
!
service routing protocols model multi-agent
!
hostname {{ k | upper }}
!
management api http-commands
   no shutdown
!
interface Management0
   ip address {{ v.mgmt_ip }}/{{ v.mgmt_mask }}
!
"""
    config = Template(template).render(k=k, v=v)
    return config


def save_startup_config(host, content):
    with open("{}/{}.conf".format(startup_config_dir, host), "w") as f:
        f.writelines(content)


if __name__ == "__main__":
    for k, v in hosts.items():
        startup_config_content = generate_startup_config(k, v)
        save_startup_config(host=k, content=startup_config_content)

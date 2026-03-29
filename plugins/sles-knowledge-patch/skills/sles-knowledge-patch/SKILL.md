---
name: sles-knowledge-patch
description: SLES changes since training cutoff (latest: 16.0) — Agama installer replaces YaST, SELinux enforcing by default, NetworkManager-only, /usr-merge defaults, cgroups v2, Wayland-only. Load before working with SLES.
license: MIT
metadata:
  author: Nevaberry
  version: "16.0"
---

# SUSE Linux Enterprise 16+ Knowledge Patch

Claude's baseline knowledge covers SUSE Linux Enterprise Server through SLES 15 SP6. This skill provides changes from SLES 16.0 (2025-11-01) onwards.

**Rebranding**: "SUSE Linux Enterprise Server" is now "SUSE Linux". Minor releases (16.0, 16.1, ...) replace service packs.

## Breaking Changes Quick Reference

| What Changed | Old (SLES 15) | New (SLES 16+) |
|--------------|---------------|-----------------|
| Installer | YaST / AutoYaST | Agama (web UI + CLI + HTTP API) |
| Security framework | AppArmor | SELinux (enforcing, 400+ modules) |
| Network stack | wicked | NetworkManager only |
| Config locations | Mixed `/etc` | Defaults in `/usr`; `/etc` for overrides only |
| `/tmp` | Persistent on disk | tmpfs (RAM-backed, cleared on reboot) |
| SSH root login | Password allowed | Password disabled; key-only |
| User groups | Shared `users` group | Per-user primary groups |
| Cgroups | v1 + v2 | v2 only |
| Hypervisor | Xen + KVM | KVM only |
| Display server | Xorg + Wayland | Wayland only (XWayland for compat) |
| Init system | systemd + SysV compat | systemd only (no SysV scripts) |
| Python | 3.6/3.11 | 3.13 |
| CPU minimum | x86-64 | x86-64-v2 |
| DHCP server | ISC DHCP | Kea DHCP |
| Name service | NIS available | NIS removed → LDAP |

## Agama Installer (Replaces YaST)

YaST and AutoYaST are fully removed. Agama provides:

- **Web UI** for interactive installs
- **CLI** (`agama`) for scripted installs
- **HTTP API** for automation
- **Profiles** (JSON/Jsonnet) replace AutoYaST XML for unattended installs

```bash
# Unattended install with Agama profile
agama profile import profile.json
agama install
```

For remote management, use **Cockpit** (replaces YaST remote modules). For configuration management, use **Salt** or **Ansible**.

See [references/installer-and-management.md](references/installer-and-management.md) for details.

## SELinux (Replaces AppArmor)

SELinux is enforcing by default with policies for 400+ modules. AppArmor is no longer the default.

```bash
# Check status
sestatus
getenforce # returns "Enforcing"

# Temporarily set to permissive (for debugging)
setenforce 0

# View/manage booleans
getsebool -a
setsebool -P httpd_can_network_connect on

# Troubleshoot denials
ausearch -m AVC -ts recent
audit2allow -a # generate policy from denials
```

See [references/security-and-networking.md](references/security-and-networking.md) for SELinux details.

## NetworkManager Only (wicked Removed)

`wicked` is removed. NetworkManager is the sole network stack. Interface names use systemd predictable naming.

```bash
# Configure network via CLI
nmcli connection show
nmcli connection add type ethernet con-name eth0 ifname enp0s3 ipv4.method manual ipv4.addresses 192.168.1.10/24

# For complex naming, use systemd.link
# /etc/systemd/network/10-custom.link
```

See [references/security-and-networking.md](references/security-and-networking.md) for networking details.

## System Defaults Moved to /usr

Default configs now live in `/usr`; `/etc` is for admin overrides only.

```bash
# Customize systemd settings — create drop-in snippets
mkdir -p /etc/systemd/system/myservice.service.d/
cat >/etc/systemd/system/myservice.service.d/override.conf <<EOF
[Service]
LimitNOFILE=65536
EOF

# Restore a default: remove the /etc override
rm /etc/systemd/system/myservice.service.d/override.conf
```

See [references/system-defaults.md](references/system-defaults.md) for full details.

## SSH Root Password Login Disabled

New installs disable password-based SSH for root. If no SSH key is provided during install, sshd won't be enabled.

```bash
# Restore password login (not recommended)
zypper install openssh-server-config-rootlogin
```

## /tmp Is Now tmpfs

`/tmp` uses tmpfs (RAM-backed), cleared on every reboot. Applications writing persistent temporary data must use `/var/cache`, `/var/tmp`, or another persistent location.

## Key Version Changes

| Component | Version | Notes |
|-----------|---------|-------|
| Python | 3.13 | `/usr/bin/python3` — may bump in minor releases |
| Kernel compiler | gcc 13 | Install `gcc13`, invoke as `gcc-13` for module builds |
| CPU requirement | x86-64-v2 | QEMU needs `-cpu host` or v2-capable model |
| Cgroups | v2 only | v1 no longer available |

## Major Removals

| Removed | Replacement | Notes |
|---------|-------------|-------|
| YaST / AutoYaST | Agama, Cockpit, Salt/Ansible | Full removal |
| wicked | NetworkManager | Sole network stack |
| AppArmor (default) | SELinux (enforcing) | 400+ policy modules |
| Xen hypervisor | KVM | HVM/PVH guests still work |
| Xorg | Wayland + XWayland | X11 apps via XWayland |
| SysV init scripts | systemd units | `rc<service>` shortcuts removed |
| NIS (`ypserv`) | LDAP | Full removal |
| ISC DHCP server | Kea DHCP | |
| 32-bit support | — | `ia32_emulation` kernel param on x86_64 |
| `/etc/services` | — | Dummy file, being phased out |
| `libnsl.so.1` | — | `libnsl-stub1` temporary workaround |
| `nscd` | — | Removed |
| `crun` | `runc` | |
| `sapconf` | `saptune` | |
| `dovecot` 2.3 | 2.4 | Incompatible config format, manual migration |

See [references/removals-and-migrations.md](references/removals-and-migrations.md) for migration guidance.

## Per-User Primary Groups

`USERGROUPS_ENAB` is enabled: each new user gets their own primary group instead of the shared `users` group. Scripts relying on `@users` in sudoers or similar need updating.

## mountfd API in util-linux

`mount` uses the new kernel mountfd API. For read-only mounts where you need the physical layer read-write:

```bash
mount -oro=vfs    # instead of: mount -oro
```

## Reference Files

| File | Contents |
|------|----------|
| [installer-and-management.md](references/installer-and-management.md) | Agama installer, profiles, Cockpit, Salt/Ansible replacements |
| [security-and-networking.md](references/security-and-networking.md) | SELinux setup, NetworkManager migration, SSH hardening |
| [system-defaults.md](references/system-defaults.md) | /usr defaults, /tmp tmpfs, cgroup v2, per-user groups, mountfd API, Python 3.13, gcc13 |
| [removals-and-migrations.md](references/removals-and-migrations.md) | Full removal list with migration paths for each component |

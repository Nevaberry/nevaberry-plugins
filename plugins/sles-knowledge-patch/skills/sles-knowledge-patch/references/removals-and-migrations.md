# Removals & Migration Paths

Complete list of major removals in SLES 16 with migration guidance.

## Installer & Management

| Removed | Replacement | Migration |
|---------|-------------|-----------|
| YaST (all modules) | Agama (install), Cockpit (mgmt) | Rewrite AutoYaST XML as Agama JSON/Jsonnet profiles |
| AutoYaST | Agama profiles | No 1:1 mapping; profiles must be rewritten |

## Security & Networking

| Removed | Replacement | Migration |
|---------|-------------|-----------|
| AppArmor (as default) | SELinux (enforcing) | Learn SELinux policy management; 400+ modules pre-configured |
| wicked | NetworkManager | Convert wicked ifcfg configs to `nmcli` connections |
| NIS (`ypserv`, NIS client) | LDAP | Migrate to LDAP/SSSD for user/group lookup |
| `nscd` | — | Name service caching removed; SSSD provides its own cache |

## Virtualization & Display

| Removed | Replacement | Migration |
|---------|-------------|-----------|
| Xen hypervisor | KVM | HVM/PVH guests still run under KVM; Xen-specific tooling removed |
| Xorg | Wayland + XWayland | X11 apps run via XWayland; Xorg-only apps need testing |

## Init System

| Removed | Replacement | Migration |
|---------|-------------|-----------|
| SysV init scripts | systemd units | Convert all `/etc/init.d/` scripts to `.service` units |
| `rc<service>` shortcuts | `systemctl` | Use `systemctl start/stop/restart <service>` |

## Services

| Removed | Replacement | Migration |
|---------|-------------|-----------|
| ISC DHCP server | Kea DHCP | Rewrite `dhcpd.conf` in Kea JSON format |
| `sapconf` | `saptune` | Replace `sapconf` with `saptune` for SAP tuning |
| `dovecot` 2.3 config | dovecot 2.4 | Incompatible config format; manual migration required |

## Libraries & Utilities

| Removed | Replacement | Migration |
|---------|-------------|-----------|
| `libnsl.so.1` | — | Use `libnsl-stub1` as temporary workaround; port code to modern APIs |
| `/etc/services` | — | Being phased out (dummy file remains); use `getent services` or hardcode ports |
| `crun` | `runc` | Switch container runtime to `runc` |

## Architecture

| Removed | Notes |
|---------|-------|
| 32-bit support | x86-64-v2 minimum required; `ia32_emulation` kernel parameter available on x86_64 for legacy 32-bit binaries |

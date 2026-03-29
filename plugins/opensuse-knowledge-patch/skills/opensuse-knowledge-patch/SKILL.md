---
name: opensuse-knowledge-patch
description: openSUSE Leap changes since training cutoff (latest: 15.6) — Cockpit web console, NVIDIA SUSE Prime, Bumblebee removal, 4096-bit signing key. Load before working with openSUSE.
license: MIT
metadata:
  author: Nevaberry
  version: "15.6"
---

# openSUSE Knowledge Patch

Claude's baseline knowledge covers openSUSE Leap 15.5. This skill provides changes in Leap 15.6 (June 2024).

## Breaking Changes Quick Reference

| Change | Impact | Details |
|--------|--------|---------|
| Bumblebee removed | Use NVIDIA SUSE Prime instead | [leap-15.6-changes](references/leap-15.6-changes.md) |
| Cockpit new (root disabled) | Edit disallowed-users to enable root | [leap-15.6-changes](references/leap-15.6-changes.md) |
| 4096-bit signing key | Manual import needed from pre-15.4 | [leap-15.6-changes](references/leap-15.6-changes.md) |

## Bumblebee Removed

Packages `bbswitch`, `bumblebee`, `bumblebee-status`, and `primus` are removed. Replaced by [NVIDIA SUSE Prime](https://en.opensuse.org/SDB:NVIDIA_SUSE_Prime) for hybrid graphics switching.

## Cockpit Web Console

Cockpit is newly included in Leap 15.6. Root password login is disabled by default (similar to sshd).

To enable root login:

```bash
# Edit /etc/cockpit/disallowed-users and remove 'root'
systemctl restart cockpit.socket
```

## NVIDIA GPU Drivers

The `nouveau` driver is disabled by default for Turing and Ampere GPUs (experimental).

Recommended: Install NVIDIA's open GPU driver:

```bash
zypper install nvidia-open-driver-G06-signed-kmp-default kernel-firmware-nvidia-gsp-G06
```

Then uncomment in `/etc/modprobe.d/50-nvidia-default.conf`:

```
options nvidia NVreg_OpenRmEnableUnsupportedGpus=1
```

To force `nouveau` instead: add `nouveau.force_probe=1` to kernel boot parameters.

## python-podman

Now based on `podman-py` project (was `python-podman`).

## 4096-bit RSA Signing Key

RPM and repository signing switched from 2048-bit to 4096-bit RSA. Introduced in 15.4 maintenance update. Users upgrading from older releases must import manually per [upgrade documentation](https://en.opensuse.org/SDB:System_upgrade#0._New_4096_bit_RSA_signing_key).

## Reference Files

| File | Contents |
|------|----------|
| [leap-15.6-changes.md](references/leap-15.6-changes.md) | Full details on openSUSE Leap 15.6 changes |

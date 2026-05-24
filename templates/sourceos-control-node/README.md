# SourceOS control-node template

This template creates a local-first SourceOS operator/control-node Home Manager flake built on `nix-openclaw`.

## Use

```bash
mkdir -p ~/code/sourceos-control-node
cd ~/code/sourceos-control-node
nix flake init -t github:SourceOS-Linux/nix-openclaw#sourceos-control-node
```

Then edit `flake.nix` placeholders:

- `<system>`
- `<user>`
- `<homeDir>`
- `<gatewayToken>`
- `<tokenPath>`
- `<allowFrom>`

## Repo authority split

This template is downstream packaging only.

- contracts: `SourceOS-Linux/sourceos-spec`
- runtime: `SocioProphet/prophet-platform`
- execution/evidence: `SocioProphet/agentplane`
- workstation/bootstrap: `SociOS-Linux/source-os`

## Local-first posture

Default execution order:

1. local operator host
2. trusted private executor
3. attested fog executor
4. burst cloud only by explicit policy

# SourceOS operator-node role in nix-openclaw

## Purpose

This note records how `nix-openclaw` fits into the broader SourceOS / SociOS / SocioProphet control-node program.

## Repo role

`nix-openclaw` is a **downstream declarative packaging and operator-node deployment lane**.

It is **not** the canonical home for:
- SourceOS typed contracts
- Node Commander contract semantics
- execution/evidence ownership
- promotion policy authority

Those remain elsewhere:
- contracts: `SourceOS-Linux/sourceos-spec`
- runtime implementation: `SocioProphet/prophet-platform`
- execution/evidence: `SocioProphet/agentplane`
- workstation/bootstrap: `SociOS-Linux/source-os`

## Why this repo still matters

This repo is useful when the operator/control-node lane needs:
- declarative packaging
- stable pinned builds
- Home Manager or Darwin/Home Manager application
- controlled rollout and rollback for OpenClaw-derived operator surfaces

## Current expected use

For the current program, `nix-openclaw` should be treated as:
- a downstream packaging/reference lane for declarative operator-node deployment
- a place to capture deployment shapes, not contract canon
- an adaptor surface that can consume the upstream control-node/runtime work once it stabilizes

## Non-goals

This repo should not become a second standards home.
It should not redefine the control-node or promotion-gate meanings already reserved upstream.

## Follow-on

Once the SourceOS control-node runtime stabilizes, this repo is a candidate home for:
- declarative packaging examples
- operator-node deployment recipes
- pinned runtime rollout patterns for local-first control nodes

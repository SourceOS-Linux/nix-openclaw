#!/usr/bin/env python3
from __future__ import annotations

from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
FLAKE = ROOT / "flake.nix"

REQUIRED_TEMPLATES = {
    "agent-first": [
        "flake.nix",
    ],
    "sourceos-control-node": [
        "flake.nix",
        "README.md",
        "documents/AGENTS.md",
        "documents/SOUL.md",
    ],
}


def fail(message: str) -> None:
    raise SystemExit(f"ERR: {message}")


def main() -> int:
    if not FLAKE.exists():
        fail("flake.nix not found")
    flake_text = FLAKE.read_text(encoding="utf-8")
    if "templates =" not in flake_text:
        fail("flake.nix does not export a templates set")

    for template_name, required_files in REQUIRED_TEMPLATES.items():
        if template_name not in flake_text:
            fail(f"flake.nix missing template export: {template_name}")
        template_dir = ROOT / "templates" / template_name
        if not template_dir.is_dir():
            fail(f"template directory missing: templates/{template_name}")
        for rel in required_files:
            path = template_dir / rel
            if not path.is_file():
                fail(f"template required file missing: templates/{template_name}/{rel}")

    sourceos_flake = ROOT / "templates" / "sourceos-control-node" / "flake.nix"
    sourceos_text = sourceos_flake.read_text(encoding="utf-8")
    expected_markers = [
        "SourceOS-Linux/sourceos-spec",
        "SocioProphet/prophet-platform",
        "SocioProphet/agentplane",
        "SociOS-Linux/source-os",
    ]
    for marker in expected_markers:
        if marker not in sourceos_text:
            fail(f"sourceos-control-node template missing authority marker: {marker}")

    print("template surface: OK")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

#!/usr/bin/env python3
"""Small dependency-free integrity check for the published snapshot."""

import json
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]


def load(name: str):
    path = ROOT / name
    with path.open() as handle:
        return json.load(handle)


def main() -> None:
    results = load("data/results.json")
    manifest = load("videos/manifest.json")
    overall = {item["system"]: item for item in results["overall"]["results"]}
    assert overall["Jev Browser"]["successes"] == 18
    assert overall["Jev Browser"]["total"] == 52
    assert overall["Hybrid"]["successes"] == 54
    assert overall["Hybrid"]["total"] == 57
    assert results["lanes"]["simple_browser"]["results"][0]["successes"] == 42
    assert results["browser_tools_probe"]["supported_upload_control"]["successes"] == 3
    assert results["browser_tools_probe"]["supported_upload_control"]["total"] == 3
    assert results["browser_tools_probe"]["luna_normal_chrome_targeted_upload"]["successes"] == 3
    assert results["browser_tools_probe"]["luna_normal_chrome_targeted_upload"]["total"] == 3
    hybrid_upload = results["browser_tools_probe"]["hybrid_normal_chrome_targeted_upload"]
    assert hybrid_upload["successes"] == 3
    assert hybrid_upload["total"] == 3
    assert (ROOT / "data/hybrid-upload-attempts.json").exists()
    assert (ROOT / "data/luna-upload-trace.json").exists()
    for item in manifest["bundled"]:
        assert (ROOT / item["path"]).exists(), item["path"]
    assert (ROOT / "report.html").exists()
    print("snapshot verified: corrected results, upload control, report, and bundled videos")


if __name__ == "__main__":
    main()

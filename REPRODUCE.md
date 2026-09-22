# Reproduction notes

This repository contains the safe, inspectable result snapshot. It does not contain the private authenticated browser profiles, API keys, account cookies, or the 2.6 GB local recording directory.

## Safe inspection

```bash
python3 -m json.tool data/results.json
python3 -m json.tool data/evidence.json
python3 scripts/verify_results.py
python3 -m http.server 8000 --directory .
# then open http://127.0.0.1:8000/report.html in another terminal or browser
```

The first three commands are the complete dependency-free verification. The
HTTP server is only needed when viewing the standalone report with relative
links. Stop it with Ctrl-C.

## What a full rerun needs

1. A macOS machine with the required native apps and Accessibility/Screen Recording permissions.
2. A clean browser profile for the public/demo tasks.
3. Explicitly authorized private test accounts for any authenticated task.
4. A Jev API key supplied through the runner's environment variable. Never commit it.
5. A Luna computer-use adapter with screenshots, pointer/keyboard actions, and an explicit postcondition verifier.
6. A file-picker or file-input action if the upload fixture is included.

The original private runner used separate adapters for browser Jev, the Jev Ultrafast CDP path, native `arc-cua` Jev, and visible Codex CUA for Luna. They should not be silently treated as one identical browser surface.

## Fair comparison rules

- Keep the same task text, starting state, timeout, and stopping boundary across approaches.
- Score only verified postconditions, not movement or a self-reported completion message.
- Keep deterministic JS probes separate from model-controlled Luna scores.
- Treat the 3/3 file-input upload result as a harness control, not as a Luna score.
- Report public discovery flows separately from the strict ten-task real-world denominator.
- Report token/API estimates as estimates, not provider invoices.
- Review sampled frames before linking a recording as evidence.

The private local report also contains short Jev authenticated-app stop clips,
window-scoped native clips, a long Luna five-app walkthrough, and a clearly
marked stitched Composite/N/A companion. They are listed in the local report
and generated manifest, but authenticated raw clips are intentionally not
copied into this public snapshot because they contain private account state.

The headline Jev Browser denominator is 52: 42 simple tasks plus 10 strict
real-world browser tasks. It does not include native desktop tasks. Jev
Ultrafast's denominator is 51 because it was not run on native desktop.

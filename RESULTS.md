# Results

Run date: 2026-09-21

The benchmark sorts by success rate first, then estimated cost per successful task. Timing is separate so a fast failure does not look like a good result.

## Overall aggregate

| Rank | Approach | Successes | Rate | Average time | Cost / success |
| ---: | --- | ---: | ---: | ---: | ---: |
| 1 | Hybrid | 51/57 | 89.5% | 29.68 s | $0.4573 total / $0.0090 per success |
| 2 | Luna | 51/57 | 89.5% | 44.57 s | $0.6521 total / $0.0128 per success |
| 3 | Jev Ultrafast | 19/51* | 37.3% | 1.07 s | $0.0224 total / $0.0012 per success |
| 4 | Jev Browser | 18/52 | 34.6% | 3.62 s | $0.01125 total / $0.000625 per success |

\* Jev Ultrafast was not measured on native desktop computer use.

## Per-lane results

| Approach | Simple browser | Real-world browser | Computer use |
| --- | ---: | ---: | ---: |
| Hybrid | 39/42 - 92.9% | 7/10 - 70%* | 5/5 - 100% |
| Luna | 39/42 - 92.9% | 7/10 - 70% | 5/5 - 100% |
| Jev Browser | 18/42 - 42.9% | 0/10 - 0% | 1/5 - 20% |
| Jev Ultrafast | 18/42 - 42.9% | 1/9 - 11.1%** | not measured |

\* Staged recorded fallback comparison.

\*\* Separate public nine-flow discovery lane.

## Native computer use detail

The five tasks were Spotify search/play, Pages drafting, TextEdit exact text, Keynote two-slide editing, and Numbers six-cell editing.

| Approach | Passes | Average time | Cost / success | Observation |
| --- | ---: | ---: | ---: | --- |
| Luna | 5/5 | 37.82 s | ~$0.0091 proxy | Completed all five visual workflows. |
| Hybrid | 5/5 | ~36.11 s | ~$0.0126 proxy | Paid for Jev first, then Luna recovery on richer tasks. |
| Jev | 1/5 | 10.85 s | ~$0.0282 | Passed clean TextEdit entry; synchronized Keynote and Numbers reruns ended without the requested content. |

The original Jev native screen recordings were excluded after review because they showed the wrong window or were not paired with their traces. Synchronized reruns reproduced the same qualitative failures: Keynote ended with blank placeholders after a reported completion, and Numbers stopped at an empty table. The headline native result is therefore specifically for the local `arc-cua-typesafe-jev` macOS accessibility/OCR adapter, not a claim about every Jev or computer-use harness. The score is trace-verified, but no misleading Jev desktop clip is linked here.

The interesting native result is that Hybrid was not cheaper than Luna. Jev helped only on the easy TextEdit case, while the Keynote and Numbers tasks still needed the Luna path. The extra Jev attempt and verification cost remained in the Hybrid total.

### Separate Accessibility-driver control

We also tested `mac-cua`, an open MCP driver that exposes a macOS Accessibility tree plus screenshots. This is a driver-only control, not another Jev model run, so it is excluded from the leaderboard.

| Driver | Task | Result | Finding |
| --- | --- | --- | --- |
| mac-cua | Pages draft | PASS | Background typing produced both requested lines, verified in the final screenshot. |
| mac-cua | Keynote two-slide edit | FAIL | Slide creation worked, but rich placeholder targeting drifted and the final text was duplicated. |
| mac-cua | Numbers six-cell edit | FAIL | Cells were exposed, but stale indices shifted values and the final table was wrong. |
| mac-cua | Spotify Radiohead → Karma Police | FAIL | Spotify exposed a sparse tree; the artist/track state was not reached or verified. |

This control is useful evidence for the native boundary: Accessibility metadata makes controls discoverable, but it does not guarantee stable editing semantics in canvases, spreadsheets, or Electron apps.

## Browser tools and JavaScript

A deterministic browser-tools probe passed 14/14, and a Jev-plus-JS replay passed 42/42. These are capability checks, not model-controlled Luna scores. The headline Luna browser scores did not have model-controlled JS evaluation enabled, so no points were added from those probes.

## File upload finding

The repeated 42-task Luna run missed the file-upload fixture three times. Those browser runs used Codex's visible in-app browser through CUA with screenshots, clicks, and typing, but no native file-picker/upload primitive. This is a harness limitation, not a general claim that Luna or Codex cannot upload files. A separate local file-input control rerun passed 3/3 in 0.31 seconds average at $0 local tool cost, but it is not a Luna score because no model turn chose the upload action.

## Safety boundary

No purchase, reservation, payment, email send, calendar save, share, publish, or other external side effect was submitted. The real-world tasks stopped at meaningful review or confirmation boundaries.

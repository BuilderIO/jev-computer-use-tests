# Jev computer-use tests

This repository is a reproducibility snapshot for a benchmark comparing four approaches to browser and desktop computer use:

- **Jev Browser** - fast structured browser decisions.
- **Jev Ultrafast** - a faster browser variant with a separate text helper.
- **Hybrid** - Jev first, a postcondition check, then Luna-style visual recovery when Jev misses.
- **Luna** - visual computer use through the visible browser or desktop surface.

## Headline results

The ranking rule is success rate first, then estimated cost per successful task. Time is shown separately.

| Approach | Overall | Simple browser | Real-world browser | Computer use |
| --- | ---: | ---: | ---: | ---: |
| Hybrid | 51/57 - 89.5% | 39/42 - 92.9% | 7/10 - 70%* | 5/5 - 100% |
| Luna | 51/57 - 89.5% | 39/42 - 92.9% | 7/10 - 70% | 5/5 - 100% |
| Jev Ultrafast | 19/51 - 37.3% | 18/42 - 42.9% | 1/9 - 11.1%** | not measured |
| Jev Browser | 19/57 - 33.3% | 18/42 - 42.9% | 0/10 - 0% | 1/5 - 20% |

\* Hybrid's ten-task browser result is a staged recorded fallback comparison, not one uninterrupted live interleaved turn.

\*\* Jev Ultrafast's real-world number is a separate public nine-flow discovery lane.

The complete interactive report is [`report.html`](report.html). It has light/dark mode, a pass-rate-versus-cost chart, lane filters, approach filters for recorded runs, and links to the locally retained clips when those clips are present.

## Cost and speed

| Approach | Overall cost / success | Overall average time | Native computer-use cost / success | Native average time |
| --- | ---: | ---: | ---: | ---: |
| Hybrid | $0.0090 | 29.68 s/task | ~$0.0126 proxy | ~36.1 s/task |
| Luna | $0.0128 | 44.57 s/task | ~$0.0091 proxy | ~37.8 s/task |
| Jev Ultrafast | $0.0012 | 1.07 s/task | not measured | not measured |
| Jev Browser | $0.0018 | 4.12 s/task | ~$0.0227 | 9.3 s/task |

The native Hybrid cost is higher than Luna because every native task pays for the Jev-first attempt plus the verification/fallback path. Jev directly passed only the clean TextEdit task; Keynote and Numbers still required Luna recovery. The Hybrid path was slightly faster in this small lane, but it did not reduce the expensive work enough to beat pure Luna on cost.

Costs are comparison estimates, not invoices. Jev uses the recorded API input-token estimate. Luna uses an action/token proxy because the computer-use surface did not expose a product invoice. Local browser and desktop tool fees are treated as $0.

## What was actually tested

### Simple browser

42 controlled browser tasks covering navigation, clicking, selecting, scrolling, forms, small edits, and state checks. This lane measures the mechanical ceiling of each browser-action approach.

### Real-world browser

Ten longer workflows included flight search and fare selection, a Thai restaurant reservation up to a safe confirmation boundary, TodoMVC project tracking, Drive, Notion, Figma, mail, Calendar, Spotify, and SauceDemo. No purchase, reservation, payment, message send, or publish action was submitted.

Jev Browser reached partial pages and controls but passed 0/10 strict postconditions. A separate Jev Ultrafast public lane covered nine read-only discovery flows and is not the same denominator.

### Native computer use

Five desktop tasks used Spotify, Pages, TextEdit, Keynote, and Numbers. TextEdit was the one direct Jev pass. Luna completed all five. Hybrid used Jev when the result was verifiable and Luna when it was not.

## Browser harness and file upload

The Luna browser runs used Codex's visible in-app browser through CUA. The surface provided screenshots, clicks, and typing, but not a native file-picker or file-input binding. It was not a Playwright/CDP run with `setInputFiles`, and model-controlled JavaScript evaluation was not enabled for the headline Luna scores.

That is why the three repeated 42-task Luna misses were file-upload fixtures. It is a limitation of that harness configuration, not evidence that Luna or Codex can never upload files. A different browser adapter can expose a native chooser or bind directly to a file input.

The native Jev lane used the local `arc-cua` runner with a macOS accessibility/OCR backend and a TypeSafe Jev policy. The Hybrid result is a policy plus verification and fallback, not a separate model.

## Repository contents

- [`report.html`](report.html) - standalone interactive report.
- [`RESULTS.md`](RESULTS.md) - concise methodology and result tables.
- [`data/results.json`](data/results.json) - machine-readable headline results.
- [`data/evidence.json`](data/evidence.json) - safe provenance, task lanes, cost model, and harness notes.
- [`tasks/`](tasks/) - public/demo task definitions that do not require private accounts.
- [`videos/README.md`](videos/README.md) - recording inventory and why raw clips are not committed here.
- [`cua-driver-control/`](cua-driver-control/) - a separate TryCua Cua Driver-only native Accessibility control, with result JSON, recording, and verified screenshot; excluded from the Jev/Luna leaderboard.
- [`report/`](report/) - report screenshots.

## Reproduce the safe snapshot

```bash
python3 -m json.tool data/results.json
python3 -m json.tool data/evidence.json
open report.html
```

The full authenticated run requires private test accounts, local browser profiles, a Jev API key supplied through an environment variable, and native macOS applications. Those credentials and profiles are intentionally not part of this repository. See [`REPRODUCE.md`](REPRODUCE.md) for the boundary between the safe snapshot and the private local rerun.

## Recording policy

Only frame-reviewed recordings belong in the local report. Earlier captures that showed the wrong blank Chrome window were excluded. The local raw video directory is about 2.6 GB and includes authenticated material, so it is not copied into this Git repository.

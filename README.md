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
| Luna | 54/57 - 94.7%* | 42/42 - 100%* | 7/10 - 70% | 5/5 - 100% |
| Hybrid | 51/57 - 89.5% | 39/42 - 92.9% | 7/10 - 70%† | 5/5 - 100% |
| Jev Ultrafast | 19/51 - 37.3% | 18/42 - 42.9% | 1/9 - 11.1%** | not measured |
| Jev Browser | 18/52 - 34.6% | 18/42 - 42.9% | 0/10 - 0% | not measured |

\* Luna's connected-Chrome headline combines the original 39/42 in-app-browser result with three targeted normal-Chrome upload reruns; the original in-app-browser result remains the footnote.

† Hybrid's ten-task browser result is a staged recorded fallback comparison, not one uninterrupted live interleaved turn.

\*\* Jev Ultrafast's real-world number is a separate public nine-flow discovery lane.

The complete interactive report is [`report.html`](report.html). It has light/dark mode, a pass-rate-versus-cost chart, lane filters, approach filters for recorded runs, and links to the locally retained clips when those clips are present. [`data/benchmark-final-manifest.json`](data/benchmark-final-manifest.json) is the generated machine-readable report snapshot.

## Cost and speed

| Approach | Overall cost / success | Overall average time | Native computer-use cost / success | Native average time |
| --- | ---: | ---: | ---: | ---: |
| Hybrid | $0.0090 | 29.68 s/task | ~$0.0126 proxy | ~36.1 s/task |
| Luna | $0.0128 | 44.57 s/task | ~$0.0091 proxy | ~37.8 s/task |
| Jev Ultrafast | $0.0012 | 1.07 s/task | not measured | not measured |
| Jev Browser | $0.000625 | 3.62 s/task | not measured | not measured |

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

We also ran a separate `mac-cua` Accessibility-driver control on the four native failures. It passed Pages and failed strict Keynote, Numbers, and Spotify end states. Because it has no planning model, those results are capability evidence, not a fourth leaderboard system.

## Browser harness and file upload

The Luna browser runs used Codex's visible in-app browser through CUA. The surface provided screenshots, clicks, and typing, but not a native file-picker or file-input binding. It was not a Playwright/CDP run with `setInputFiles`, and model-controlled JavaScript evaluation was not enabled for the headline Luna scores.

That is why the three repeated 42-task Luna misses were file-upload fixtures. It is a limitation of that harness configuration, not evidence that Luna or Codex can never upload files. A different browser adapter can expose a native chooser or bind directly to a file input.

Three model-controlled Luna turns in the normal Chrome bridge ran the upload fixture. All three opened the native macOS chooser, selected `benchmark.txt`, clicked Upload fixture, and reached the visible success state: **3/3 targeted uploads**. Combined with the original 39/39 non-upload passes, this supports an explicitly inferred connected-Chrome result of 42/42; the headline table retains 39/42 for the original in-app-browser setup. The bridge still exposed no usable DOM/JavaScript handle, so this is not a JS-enabled rerun. Traces are [`data/luna-upload-trace.json`](data/luna-upload-trace.json), [`data/luna-upload-attempt-2.json`](data/luna-upload-attempt-2.json), and [`data/luna-upload-attempt-3.json`](data/luna-upload-attempt-3.json).

Hybrid was not rerun through the model-controlled normal-Chrome upload path, so its headline remains 39/42 rather than being silently changed.

The native Jev lane used the local `arc-cua` runner with a macOS accessibility/OCR backend and a TypeSafe Jev policy. The Hybrid result is a policy plus verification and fallback, not a separate model. The local report includes short window-scoped Jev browser/app stop clips, a window-scoped TextEdit success, and a Pages false-completion recording. Long frozen tails were excluded after frame review; the long Luna walkthrough and staged Hybrid app walkthrough remain supplemental evidence rather than new scores.

## Repository contents

- [`report.html`](report.html) - standalone interactive report.
- [`EXPANDED_EVIDENCE.md`](EXPANDED_EVIDENCE.md) - per-run notes for the expanded evidence library, including every stopping point and failure reason.
- [`RESULTS.md`](RESULTS.md) - concise methodology and result tables.
- [`data/results.json`](data/results.json) - machine-readable headline results.
- [`data/evidence.json`](data/evidence.json) - safe provenance, task lanes, cost model, and harness notes.
- [`data/benchmark-final-manifest.json`](data/benchmark-final-manifest.json) - generated report data and retained-video inventory.
- [`data/luna-upload-trace.json`](data/luna-upload-trace.json) - sanitized model-controlled normal-Chrome upload trace.
- [`data/luna-upload-attempts.json`](data/luna-upload-attempts.json) - sanitized 3/3 normal-Chrome upload rerun summary.
- [`videos/manifest.json`](videos/manifest.json) - bundled versus local-only recording inventory and audit exclusions.
- [`scripts/verify_results.py`](scripts/verify_results.py) - dependency-free snapshot integrity check.
- [`tasks/`](tasks/) - public/demo task definitions that do not require private accounts.
- [`videos/README.md`](videos/README.md) - recording inventory and why raw clips are not committed here.
- [`cua-driver-control/`](cua-driver-control/) - a separate TryCua Cua Driver-only native Accessibility control, with result JSON, recording, and verified screenshot; excluded from the Jev/Luna leaderboard.
- [`data/mac-cua-controls.json`](data/mac-cua-controls.json) - separate AX-tree driver control results; excluded from the Jev/Luna leaderboard.
- [`report/`](report/) - report screenshots.

## Reproduce the safe snapshot

```bash
python3 -m json.tool data/results.json
python3 -m json.tool data/evidence.json
python3 scripts/verify_results.py
python3 -m http.server 8000
# then open http://127.0.0.1:8000/report.html
```

The full authenticated run requires private test accounts, local browser profiles, a Jev API key supplied through an environment variable, and native macOS applications. Those credentials and profiles are intentionally not part of this repository. The long Luna five-app clip is a successful supplemental walkthrough. The bundled Hybrid companion is an honest four-app fallback marked Fail: it does not reach Slides and is not a Hybrid score. See [`REPRODUCE.md`](REPRODUCE.md) for the boundary between the safe snapshot and the private local rerun.

## Recording policy

Only frame-reviewed recordings belong in the local report. Earlier captures that showed the wrong blank Chrome window or the wrong native app window were excluded. The local raw video directory is about 2.6 GB and includes authenticated material, so it is not copied into this Git repository. One five-app Chrome bridge walkthrough is bundled as a supplemental, unscored example.

# Tests: prompts and verification

This is the "what exactly was tested, and how did we check it" reference for
[`README.md`](README.md) / [`RESULTS.md`](RESULTS.md). Every row below quotes the
literal instruction text given to an agent and the postcondition that was
checked to call it a pass. Where the exact text could not be recovered from a
retained file, that is stated instead of reconstructed.

Sources: `tasks/*.json` and `data/*.json` in this repo, plus the fuller
private originals under the `jev-benchmark` working tree (`site/index.html`,
`tasks.json`, `authenticated_tasks.json`, `scripts/arc-cua-*-result.json`),
referenced below as `S/<path>`.

## 1. Simple browser fixtures (42)

The simple-browser lane is 14 deterministic local fixture pages (served by
`S/site/server.py` + `S/site/index.html`), each run 3 times (`<id>-1`,
`<id>-2`, `<id>-3`) — 14 × 3 = **42** graded executions. The prompt, pass
rule, and category are identical across the three runs of a given id; only
the model's attempt differs. Prompt text is quoted from `S/site/index.html`
(the fixture's on-page instruction, identical to `S/tasks.json`'s `goal`
field). Pass rule is the exact `succeed()` condition in that fixture's
render function.

| Fixture id | Type | Exact prompt | Pass rule |
| --- | --- | --- | --- |
| `nav` | navigation | "Open the Espresso guide and stop once its article is visible." | Following the "Open Espresso guide" link to `?task=nav-target` auto-succeeds on arrival (page render calls `succeed()` immediately). |
| `search` | search/type | "Search for espresso, then open the Espresso grinder result." | Type text containing "espresso" (case-insensitive) into the search box, click Search to reveal the result link, then open it — the target page auto-succeeds on arrival. |
| `form` | multi-field form | "Use Ada Lovelace, ada@example.com, Analyst, accept the terms, and create the profile." | `fullName === "Ada Lovelace"` and `email === "ada@example.com"` and `role === "analyst"` and the agree checkbox is checked, then click Create profile. |
| `select` | native `<select>` | "Choose Canada and Pro, then apply the filters." | `country === "ca"` and `plan === "pro"`, then click Apply filters. |
| `modal` | modal dialog | "Open settings, enable Dark mode and Email notices, then save." | Inside the opened modal, both the Dark mode and Email notices checkboxes are checked, then Save settings is clicked. |
| `table` | filter/sort grid | "Filter to Q4, sort by status, and open the Q4 Launch row." | The filter input contains "q4" (case-insensitive) and the table has been sorted by status, then the Open button on the "Q4 Launch" row is clicked. |
| `scroll` | long-page scroll | "Scroll to the bottom and mark the report reviewed." | The "Mark report reviewed" button, placed after 12 paragraphs of filler text, is clicked. |
| `grid` | spreadsheet editing | "Change Budget Jan to 1200 and Feb to 1400, then commit." | Both `contenteditable` cells read exactly `"1200"` and `"1400"`, then Commit spreadsheet changes is clicked. |
| `richtext` | rich text editor | "Make the title a heading, bold the word launch, and save the document." | The `contenteditable` editor contains both an `<h2>` and a `<strong>`/`<b>` element, then Save document is clicked. |
| `drag` | drag-and-drop | "Drag Ship launch into the Done drop zone." | The HTML5 `dragstart`/`drop` payload `"Ship launch"` is dropped onto the drop zone. |
| `iframe` | cross-frame form | "Inside the embedded form, enter invite@example.com and send the invite." | Inside the `<iframe>`'s own form, the email field equals `"invite@example.com"` and the form is submitted, which `postMessage`s `{type:"iframe-success"}` to the parent. |
| `shadow` | shadow DOM | "Click Confirm inside shadow DOM." | The button rendered inside an open `shadowRoot` (a custom element, not the light DOM) is clicked. |
| `upload` | file upload | "Upload the provided benchmark.txt file and confirm it." | A file is present on the `<input type="file">` and Upload fixture is clicked. |
| `download` | file download | "Download the benchmark file." | The `download`-attribute anchor (a `data:` URL) is clicked. |

## 2. Real-world browser (10 tasks)

Sourced from [`tasks/real-world-demo-tasks.json`](tasks/real-world-demo-tasks.json)
(7 tasks) and [`tasks/extended-public-tasks.json`](tasks/extended-public-tasks.json)
(3 tasks) — together the strict ten-task real-world browser denominator used
in `data/results.json` / `data/evidence.json`. `tasks/extended-public-safe-tasks.json`
is a related 5-task "safer boundary" variant of some of the same sites, not
part of the strict ten.

| Task id | Site | Exact prompt (`goal`) | Pass rule |
| --- | --- | --- | --- |
| `saucedemo-cart` | saucedemo.com | "Log in with username standard_user and password secret_sauce. Sort the products by price high to low. Add the most expensive product to the cart. Open the cart and stop once the cart visibly shows the item. Do not checkout or place an order." | "The cart visibly contains Sauce Labs Fleece Jacket." |
| `internet-login` | the-internet.herokuapp.com | "Log in with username tomsmith and password SuperSecretPassword!, and stop once the page visibly says You logged into a secure area. Do not do anything after the successful login." | "The secure area page visibly says You logged into a secure area." |
| `todomvc-complete` | todomvc.com | "Add a todo named Buy coffee, mark it complete, filter to Completed, and stop with Buy coffee visible as completed." | "The Completed filter is active and Buy coffee is visibly completed." |
| `opentable-discovery` | opentable.com | "Find a public restaurant search or reservation result for San Francisco. ... Do not sign in, enter payment, or make a reservation." | "A restaurant result or reservation-time list is visibly on screen; this deliberately stops before booking confirmation." |
| `google-flights-search` | google.com/travel/flights | "Search Google Flights for a round trip for one adult from SFO San Francisco to JFK New York, departing September 26, 2026 and returning October 3, 2026. ... Do not select a flight, enter traveler information, or purchase anything." | "The visible results show a San Francisco/SFO to New York/JFK flight search for the requested dates; this deliberately stops before flight selection or purchase." |
| `opentable-booking-boundary` | opentable.com | "Use OpenTable to search San Francisco for a table for 2 people on September 26, 2026 at 7:00 PM. ... Do not sign in, enter payment, or confirm a reservation." | "A visible restaurant result or reservation-time list is on screen for the requested San Francisco search; this deliberately stops before booking confirmation." |
| `resy-booking-boundary` | resy.com | "Use Resy to find a San Francisco restaurant for 2 people on September 26, 2026 at 7:00 PM. ... Do not sign in, enter payment, or confirm a reservation." | "A visible San Francisco restaurant result or reservation-time list is on screen; this deliberately stops before booking confirmation." |
| `spotify-search-and-play` | open.spotify.com | "Use Spotify as a normal user: search for Radiohead, open the artist page, open the OK Computer album, open Karma Police, and start playback if the public player permits it. ... Do not follow, like, save, add to a playlist, or change account settings." | `success_all`: page text contains "radiohead" and "karma police"; `success_any`: "play", "pause", "now playing", or "track". |
| `saucedemo-checkout-boundary` | saucedemo.com | "Complete a safe demo-commerce checkout up to the final order boundary. ... fill first name Ada, last name Lovelace, postal code 94025, and stop on the final order review before clicking Finish. Do not place the demo order." | `success_all`: "fleece jacket"; `success_any`: "checkout: overview", "finish", "payment information", or "order summary". |
| `todomvc-multi-step-edit` | todomvc.com | "Create three todos named Buy coffee, Review Jev benchmark, and Send dinner options. Mark Buy coffee and Review Jev benchmark complete, filter to Completed, and stop with the completed list visible. Do not delete any todo." | `success_all`: "buy coffee" and "review jev benchmark"; `success_any`: "completed". |

**Stop-point rule** (all ten, stated in `README.md` and `RESULTS.md`): "No
purchase, reservation, payment, email send, calendar save, share, publish, or
other external side effect was submitted. The real-world tasks stopped at
meaningful review or confirmation boundaries."

### Three later re-checks: Drive, Thai, Figma

`data/benchmark-final-manifest.json` → `.extended_real_world` records a
broader 10-row evidence table (distinct from the strict public 10 above,
mixing in authenticated apps). Three of those rows are later re-checks called
out separately in `README.md`/`RESULTS.md`:

| Row | Jev | Luna | Hybrid |
| --- | --- | --- | --- |
| Thai restaurant reservation | FAIL - OpenTable CDN/EdgeSuite block before app UI loaded | PARTIAL - reached "Hed Very Thai", Mon Sep 21 8:00 PM, party 2, through the "You're almost done" / Complete reservation boundary, then released the temporary hold (64.4 s, ~$0.0169 proxy) | PARTIAL - Jev hit the same transport boundary; Luna reached reservation details (composite) |
| Google Drive private edit | AUTH (authenticated checkpoint exists) | AUTH (authenticated checkpoint exists) | No matched extended trace |
| Figma private design | AUTH (editor checkpoint exists) | AUTH (editor checkpoint exists) | No matched extended trace |

## 3. Computer use (5 native desktop tasks)

Driver: the local `arc-cua` runner (`S/scripts/run_arc_cua_native.py`) using
a **macOS Accessibility + Vision OCR desktop adapter** with a TypeSafe Jev
policy (`data/evidence.json` → `harness.jev_native`). Exact prompt text and
the verification string are quoted from each task's result file
(`S/scripts/arc-cua-<task>-result.json`).

| Task | Exact prompt | Pass rule (verification) |
| --- | --- | --- |
| TextEdit | "In TextEdit, create a new document and type these exact three lines: 'Native desktop notes', 'Coffee and Thai dinner', and 'Jev desktop benchmark'. Leave the document open." | "TextEdit shows an open document containing the exact three lines supplied in the goal." |
| Pages | "In Pages, create a blank document and type the title 'Native desktop benchmark draft' followed by the sentence 'Jev completed this text-editing task.' Leave the document open." | "Pages shows an open document containing the exact title and sentence supplied in the goal." |
| Keynote | "In Keynote, create a new presentation using a simple blank or white theme. Set the first slide title to 'Jev vs Luna native benchmark', add a second slide, set its title to 'Keynote workflow', and add the body text 'Created through desktop computer use'. Leave the unsaved presentation open." | "Keynote shows an open presentation with at least two slides; the first slide visibly contains the title 'Jev vs Luna native benchmark' and the second slide visibly contains the title 'Keynote workflow' and the body 'Created through desktop computer use'." |
| Numbers | "In Numbers, create a new blank spreadsheet. Enter a small two-column table: A1 'Item', B1 'Status', A2 'Keynote', B2 'pending', A3 'Numbers', and B3 'complete'. Leave the unsaved spreadsheet open." | "Numbers shows an open spreadsheet with the visible cells A1 Item, B1 Status, A2 Keynote, B2 pending, A3 Numbers, and B3 complete." |
| Spotify | "In Spotify, search for the artist Radiohead, open the Radiohead artist page, find Karma Police, and start playing it." | "Spotify shows the Radiohead artist page, Karma Police is visible, and the player shows Karma Police by Radiohead as currently playing." |

Text was read back and graded from the app itself (an AX-tree value read or
an OCR'd screenshot), not from the agent's self-reported completion message
— that distinction is what caught the Pages and Keynote **false completions**
recorded in `RESULTS.md` (agent reported done; readback showed an empty Body
or blank placeholders).

**Separate accessibility-driver control**: `data/mac-cua-controls.json` /
[`cua-driver-control/`](cua-driver-control/) is a second, model-free driver
check using `mac-cua` / the TryCua Cua Driver (open MCP driver exposing a
macOS Accessibility tree plus screenshots) against the same four
non-TextEdit tasks, to test whether the driver itself (not a planning model)
could locate and drive the controls. It passed Pages, failed Keynote,
Numbers, and Spotify, and is explicitly excluded from the Jev/Luna
leaderboard because it has no planning model — see `cua-driver-control/result.json`
for the standalone TextEdit-only AX proof (`driver_version: 0.28.2`, passed).

## 4. Agent-native apps (Mail, Calendar, Content, Design, Slides)

Prompt text and the two allow-listed addresses (`steve@builder.io` self-send,
`sewell.steve@gmail.com` as the one external allowed recipient) are quoted
from `S/authenticated_tasks.json`. These authenticated tasks are not
committed to this repo's `tasks/` (they need private accounts — see
`REPRODUCE.md`); outcomes are recorded in `data/benchmark-final-manifest.json`
→ `.authenticated_apps` / `.authenticated_summary`.

| App | What was asked | What counted as done | What was intentionally not done |
| --- | --- | --- | --- |
| Mail | Search the mailbox for "Jev" (read-only); separately, create an unsent draft to `steve@builder.io` with subject "[Jev benchmark] draft only"; separately, prepare (not send) a message to `sewell.steve@gmail.com` and stop with Send visible. | Search results visibly loaded; draft visibly contains the allow-listed recipient/subject/body; final Send control visible but unclicked. | Opening/reading/archiving/trashing a message; ever clicking Send. Jev: 0/3. Luna: PASS (searched and edited an unsent draft). |
| Calendar | Navigate to the week containing September 21, 2026 (read-only); separately, prepare (not save) an event titled "[Jev benchmark] invite boundary" on Sep 22, 2026 2:00 PM, 30 min, inviting only `sewell.steve@gmail.com`, stopping with Save/Send invitation visible. | Week view with events visibly loaded; completed event form and Save/Send control visible but unclicked. | Creating, editing, deleting, or inviting for real; ever clicking Save or Send. Jev: 0/2. Luna: PASS (week/search boundary; no event saved). |
| Design | Create a design named "[Jev benchmark] design", add one visible screen/shape, edit its text to "Edited by Jev benchmark". | Edited text visibly rendered on the canvas. | Nothing beyond the described edit. Jev: FAIL (target error). Luna: PASS (visible design artifact and edit). |
| Slides | Create a deck named "[Jev benchmark] deck" with one slide, type "Edited by Jev benchmark" into it. | Edited text visibly rendered in the deck. | Sharing or exporting the deck. Jev: PASS (create/edit — the one authenticated Jev pass). Luna: PASS (visible deck edit; generation caveat noted). |
| Content | Create a document named "[Jev benchmark] document", type "Edited by Jev benchmark". | Edited text visibly rendered in the document. | Publishing, sharing, or deleting it. Jev: FAIL (remained "Churning"). Luna: PASS (visible document create/edit). |

Authenticated summary (`.authenticated_summary`): Jev 1/8 exact tasks
(12.5%, Slides was the strict pass), Luna 5/5 safe composite checkpoints
(100%), no matched authenticated Hybrid run was retained. No screen
recording was retained for these five rows — "the earlier capture was a
generated title card, not a recording" (per the manifest).

## 5. Scoring and cost accounting

- **Binary pass/fail.** Every task above is scored strict pass/fail against
  a stated postcondition — a verified page/app state, not agent movement or
  a self-reported "done" message (`REPRODUCE.md` → "Fair comparison rules").
  This is what catches false completions (Pages, Keynote).
- **Time** is the wall-clock elapsed time of the run/trace (`elapsed_ms` /
  `elapsed_seconds` in each result JSON), reported separately from
  pass/fail so a fast failure doesn't read as a good result.
- **Cost**: Jev's cost is the recorded API input/output token estimate at
  published rates (`data/evidence.json` → `cost_model.jev`). Luna's cost is
  an action/token proxy, not a product invoice, because the computer-use
  surface exposed no per-call price (`cost_model.luna`). Native Luna calls
  are calibrated from an observed action count — e.g. the native hybrid
  Keynote/Numbers totals are "estimated from the observed Jev leg plus 11
  Keynote and 3 Numbers Luna CUA calls at the calibrated proxy rate; they
  are not provider invoices" (manifest note). Local browser/desktop tool
  fees are treated as $0.
- **Hybrid rule**: Jev attempts first, its result is checked against the
  same verified postcondition, and Luna only runs (and is only paid for) on
  a verified Jev miss. Hybrid's cost is therefore the Jev attempt cost plus
  the Luna recovery cost when recovery was needed — this is explicitly why
  Hybrid was not cheaper than Luna alone on the native lane: "Jev helped
  only on the easy TextEdit case, while the Keynote and Numbers tasks still
  needed the Luna path. The extra Jev attempt and verification cost
  remained in the Hybrid total" (`RESULTS.md`).
- **File-upload handling**: the headline Luna/Hybrid harness drove the
  normal, separate Chrome browser through the desktop bridge (native
  OS file-picker available), not the in-app CUA browser (no file-picker,
  no `<input type=file>` binding) — the in-app-browser pass was 39/42 for
  exactly that reason (all three misses were the `upload` fixture). Three
  model-controlled reruns through normal Chrome passed the upload fixture
  3/3 for both Luna and Hybrid, supporting the reported connected-Chrome
  42/42 (`data/luna-upload-trace.json`, `data/luna-upload-attempts.json`,
  `data/hybrid-upload-attempts.json`).
- **No page JavaScript execution** was used for any model-controlled score —
  matching normal ChatGPT Chrome use. A separate deterministic browser-tools
  probe (14/14) and a Jev-plus-JS replay (42/42) are capability checks, not
  model-controlled Luna/Jev/Hybrid scores, and are kept out of the four
  leaderboard numbers (`data/evidence.json` → `browser_tools`).

## 6. How to reproduce

See [`REPRODUCE.md`](REPRODUCE.md) for the full boundary between the safe
snapshot in this repo and a private authenticated rerun. The safe,
dependency-free verification is:

```bash
python3 -m json.tool data/results.json
python3 -m json.tool data/evidence.json
python3 scripts/verify_results.py
python3 -m http.server 8000
# then open http://127.0.0.1:8000/report.html
```

A full rerun additionally needs a macOS machine with Accessibility/Screen
Recording permissions, a clean browser profile, private test accounts for
authenticated tasks, and a Jev API key supplied through the runner's
environment variable (never committed) — see `REPRODUCE.md` → "What a full
rerun needs" for the complete list.

# Expanded evidence notes

This is the human-readable companion to the report's **Recorded runs** table. Each row is judged from the visible ending state of the recording. **Success** means the requested end state is visible. **Not a success** means the clip is useful evidence of progress or a stopping point, but the end state is not demonstrated. No purchase, reservation, payment, send, share, or publish action was submitted.

## Curated clips

| Approach | Lane | Run | Result | What the ending shows |
| --- | --- | --- | --- | --- |
| Jev | Real-world browser | Google Flights fare search | Not a success | Reaches the fare-search boundary, but no completed itinerary selection is visible. |
| Jev | Real-world browser | OpenTable restaurant search | Not a success | OpenTable returns an EdgeSuite CDN access block before the app UI loads. No booking action was submitted. |
| Luna | Real-world browser | United flight to traveler page | Success | Itinerary and traveler/payment page are visible; purchase is untouched. |
| Luna | Real-world browser | Flights and restaurant search | Success | Continuous browser run reaches concrete flight results after multi-step navigation. |
| Hybrid | Real-world browser | TodoMVC long run | Success | Clean Chrome run ends with the requested completed and active items visible. |
| Hybrid | Real-world browser | Google Flights handoff | Success | Jev-first handoff ends on concrete flight results. |
| Jev | Computer use | TextEdit exact text | Success | Requested lines are visible in the frontmost native editor. |
| Jev | Computer use | Keynote two-slide edit | Not a success | Synchronized rerun ends with blank placeholders even though the run reported completion. |
| Luna | Computer use | Keynote two-slide edit | Success | Both slide titles and body text are visible at the end. |
| Luna | Computer use | Numbers six-cell edit | Success | Requested spreadsheet cells are visible at the end. |
| Hybrid | Computer use | Keynote recovery | Success | Luna repairs the Jev miss and final slide content is visible. |
| Hybrid | Computer use | Numbers recovery | Success | Luna repairs the Jev miss and final spreadsheet values are visible. |

## Expanded browser evidence

| Approach | Lane | Run | Result | Where it stopped / why |
| --- | --- | --- | --- | --- |
| Jev | Real-world browser | Spotify auth boundary | Not a success | Spotify shows its free-account gate after the track attempt; reliable playback is not verified. |
| Jev | Real-world browser | TodoMVC incomplete | Not a success | A task is visible, but the complete add/complete/filter postcondition is not shown. |
| Jev | Real-world browser | SauceDemo checkout boundary | Not a success | Login form reports a missing password; the run stops before cart and checkout. |
| Jev | Real-world browser | Notion edit boundary | Not a success | Authenticated page remains at a loading state; no verified text edit is visible. |
| Jev | Real-world browser | Resy search boundary | Not a success | Restaurant page is visible, but no named restaurant, time, or reservation-details state is reached. |
| Luna | Real-world browser | Resy restaurant search | Not a success | Restaurant-search page is visible, but this clip does not show the requested named-slot boundary. |
| Luna | Real-world browser | TodoMVC project tracker | Success | Requested tasks and completed/active views are visible at the end. |
| Hybrid | Real-world browser | OpenTable recovery boundary | Not a success | Luna reaches restaurant results, but the clip ends before the named reservation-details state. |
| Hybrid | Real-world browser | TodoMVC recovery | Success | Luna completes the add/complete/filter workflow after the Jev-first attempt. |

## Expanded native desktop evidence

| Approach | Lane | Run | Result | Where it stopped / why |
| --- | --- | --- | --- | --- |
| Jev | Computer use | Pages false completion | Not a success | Pages remains blank at the end even though the agent reported completion. |
| Jev | Computer use | Spotify not verified | Not a success | Radiohead page is visible, but the strict native playback postcondition is not verified. |
| Jev | Computer use | Numbers empty sheet | Not a success | Numbers ends with an empty table; no requested values are visible. |
| Luna | Computer use | Pages edit | Success | Requested text is visible in the native Pages document at the end. |
| Luna | Computer use | Spotify search and play | Success | Requested Radiohead track page and active playback state are visible. |
| Hybrid | Computer use | Pages recovery | Success | Luna repairs the Jev miss and requested text is visible in Pages. |
| Hybrid | Computer use | Spotify recovery | Success | Luna repairs the Jev-first attempt and requested Radiohead playback state is visible. |

These expanded clips are evidence-library additions only. They do not change the benchmark numerator/denominator or headline cost estimates.

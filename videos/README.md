# Video evidence

The full local report contains a curated video library for the runs. This repository does not copy the raw recordings because many clips contain authenticated/private app sessions, account names, or local browser state.

The local artifact library is about 2.6 GB, so it is also intentionally kept separate from the Git history. The report still documents the clip names, lanes, outcomes, and review policy.

The local library is organized by:

- `videos/e2e/` - longer browser workflows for Luna and Hybrid.
- `videos/extended-e2e/luna-browser/` - verified Luna browser clips such as OpenTable and TodoMVC.
- `videos/extended-e2e/hybrid/` - verified Hybrid browser clips showing the Jev attempt and fallback boundary.
- `videos/native-desktop/luna/` - verified Luna desktop clips.
- `videos/native-desktop/hybrid/` - verified Hybrid desktop clips.
- `videos/native-desktop/jev/` - verified Jev desktop attempts, including failures.

The local report links only to recordings that were sampled at multiple timestamps. The earlier 16-minute Luna browser capture and other blank-window captures were removed after review because they showed the wrong Chrome window for the entire run.

For an external release, export sanitized clips with account names and private data removed, then add them here deliberately. Do not publish the authenticated originals.

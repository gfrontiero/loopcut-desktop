# Loopcut independent test — 6 September 2026

The published Apple Silicon Mac beta starts on a disposable Mac runner, responds to its local health API, and reports a captured frame written to the database. Seven tests of the production log sanitizer pass. Source preflight fails on three broken build references.

**The paid automation audit has not passed an end-to-end test.** No customer-ready report was generated in this run.

[Completed workflow run](https://github.com/gfrontiero/loopcut-desktop/actions/runs/34015883488) · [Draft PR](https://github.com/gfrontiero/loopcut-desktop/pull/1)

## What ran

| Check | Result | Evidence and limit |
| --- | --- | --- |
| Published DMG integrity | Pass | SHA-256 matched the pinned release asset. |
| Native Mac startup | Pass | Apple Silicon executable remained running through the startup window on macOS 14.8.9 arm64. |
| Signature and Gatekeeper commands | Pass in runner | Both returned zero. This is not an interactive first-install test on a customer's Mac. |
| Local health API | Observed healthy | HTTP 200; pipeline reported one frame captured and one written, zero dropped. OCR text accuracy was not checked. |
| Production log sanitizer | 7 pass, 0 fail | Synthetic email, phone, SSN, card, password and bearer token were removed; ordinary numeric values and localhost were retained. This tests one helper, not all data flows. |
| Source preflight | 3 failures | Two declared Rust source files are missing, and existing Mac CI names a package that no longer exists. |
| Week of activity → ranked audit | Not run | No verified runnable audit-generation path was established. |
| Intel Mac, Windows, Linux | Not run | This run covers the released arm64 Mac artifact only. |

Source baseline: `ba9873f701fded1c698835f2624e0f23f17fbe42`. Test commit: `61577091a46816905d80f2caca87fd6575c71238`.

Release: `v0.1.0-beta`, bundle version `0.1.0`, executable `loopcut-app`. The embedded health endpoint identifies itself as `0.3.278`.

Asset: [loopcut-mac.dmg](https://github.com/gfrontiero/loopcut-desktop/releases/download/v0.1.0-beta/loopcut-mac.dmg)

SHA-256: `2597481d20b5a89a384ed003b0545e06c3eb5a51f3c34988e2cf79250eacadb2`

## Confirmed build blockers

1. `crates/loopcut-engine/Cargo.toml` declares `src/bin/loopcut-engine.rs`, which is absent. The tree contains `src/bin/screenpipe-engine.rs`.
2. `crates/loopcut-audio/Cargo.toml` declares `examples/loopcut-audio.rs`, which is absent.
3. `.github/workflows/e2e-macos.yml` builds `screenpipe-engine`; the package is now `loopcut-engine`. The existing June 12 run also failed with “package ID specification 'screenpipe-engine' did not match any packages.”

These are source and CI failures; they do not contradict the already-built DMG starting successfully. No full Rust build was claimed.

## Audit-generation investigation

There is an **Automate My Work** prompt in [summary-templates.ts](https://github.com/gfrontiero/loopcut-desktop/blob/ba9873f701fded1c698835f2624e0f23f17fbe42/apps/loopcut-app-tauri/lib/summary-templates.ts). It asks for three app-specific automation suggestions from the last 24 hours, but does not specify the week-long ranked report and explicit savings calculation needed for this acceptance test.

Two concrete source issues need resolution before using that path:

- The prompt instructs the model to use `GET /raw_sql`. The [server registers `POST /raw_sql`](https://github.com/gfrontiero/loopcut-desktop/blob/ba9873f701fded1c698835f2624e0f23f17fbe42/crates/loopcut-engine/src/server.rs). The documented request in the prompt does not match the server route. Whether a model would recover was not tested.
- [SummaryCards](https://github.com/gfrontiero/loopcut-desktop/blob/ba9873f701fded1c698835f2624e0f23f17fbe42/apps/loopcut-app-tauri/components/chat/summary-cards.tsx) uses fallback templates only when the API returns no templates. The release startup logs show six built-in pipes: day-recap, standup-update, ai-habits, time-breakdown, video-export and meeting-summary. They do not include automate-my-work. Source inspection therefore suggests the automation card can be absent when normal templates load; this is not a visually verified UI finding.

[PHASE5_ANALYSIS.md](https://github.com/gfrontiero/loopcut-desktop/blob/ba9873f701fded1c698835f2624e0f23f17fbe42/PHASE5_ANALYSIS.md) describes the desired custom analysis and references an external local prompt file. That document alone is not evidence the paid report is implemented. The text scan in the preflight artifact is an inventory, not proof that report generation is absent.

## Prepared acceptance fixture

`qa/loopcut-smoke/synthetic-week.json` contains five synthetic days and 15 Gmail → HubSpot repetitions. Its known total is 60 minutes per week. At the explicitly assumed $50/hour and 50 working weeks, completely eliminating that time would be worth $2,500/year before implementation costs. Those numbers are fixture ground truth, not measured customer savings.

The eventual report test should ingest this fixture through the product's real data path, name the observed tools, identify the repeated workflow, calculate savings without double-counting, and provide a concrete trigger and implementation steps. It must distinguish observed time from estimated achievable savings. It should also return an honest insufficient-data result for empty input.

## Reproduction and records

The isolated test branch contains `.github/workflows/loopcut-smoke.yml` and `qa/loopcut-smoke/`. It ran on GitHub-hosted Linux and Mac runners without using Greg's desktop. The workflow has no recurring schedule. Its push trigger is limited to test-file changes on this test branch; it also declares `workflow_dispatch`.

[Mac job and logs](https://github.com/gfrontiero/loopcut-desktop/actions/runs/34015883488/job/101439436210) · [Source job and logs](https://github.com/gfrontiero/loopcut-desktop/actions/runs/34015883488/job/101439436212) · [Sanitizer job and logs](https://github.com/gfrontiero/loopcut-desktop/actions/runs/34015883488/job/101439436066)

[Mac JSON artifact](https://github.com/gfrontiero/loopcut-desktop/actions/runs/34015883488/artifacts/9983873742) · [Source JSON artifact](https://github.com/gfrontiero/loopcut-desktop/actions/runs/34015883488/artifacts/9983866217). Artifacts have 30-day retention.

Next engineering work: repair the three build references, establish the actual audit entry point, resolve the prompt/API and template-selection issues, and run the prepared fixture through the real report generator. Production changes and sales-readiness approval are outside this test-only PR.

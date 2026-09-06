# Application evidence collection — 6 September 2026

The application-code change proposed after the two failed model attempts is implemented in draft PR #1. The desktop Automate My Work card reads and validates recordings before dispatching a report to the configured Pi writer. The real Mac integration confirms that acquisition, arithmetic and empty-data gating work. The model completed a report, but its output still fails quality review.

Source commit: `e5892ad3079ccf78473f54ec7bad94176f538b19`. [Independent test run](https://github.com/gfrontiero/loopcut-desktop/actions/runs/34040776468).

## What changed

`apps/loopcut-app-tauri/lib/automation-audit.ts` now owns acquisition, validation and arithmetic. It queries a fixed seven-day range, freezes the maximum matching frame ID, validates coverage and pages, and retrieves at most 10,000 frames across five pages after the coverage request. Incomplete or malformed reads fail explicitly. A capped read is labeled as an early chronological sample.

The collector groups adjacent app/window contexts and identifies repeated observed transitions. It calculates interval proxies between neighboring captures, excludes long gaps, idle markers and terminal frames, and merges simultaneous intervals across devices. Overlapping observations of the same transition count once. It preserves example frame IDs, timestamps and bounded excerpts. Excerpts and labels use the existing pattern-based PII sanitizer before model handoff.

The desktop card shows progress, prevents duplicate requests and cancels acquisition when unmounted. Successful empty or unsupported input returns Insufficient data. HTTP, schema, incomplete-read and cancellation failures return Analysis failed. Neither outcome calls the report writer. Ready evidence is handed to the existing selected provider; this patch does not change the user's model settings.

The report-only pipe and fallback share the same instructions. A standalone pipe run requires prepared evidence in its context; automatic acquisition is wired to the desktop card. General-purpose Pi tool access is not globally disabled by this patch.

## Verified checks

| Check | Result |
| --- | --- |
| Production SQL, arithmetic and dispatch gating, plus shared-prompt and existing sanitizer cases | 27 Bun tests passed locally and in GitHub CI |
| Synthetic five-day workload | 45 frames, 15 observed transitions, 60 interval minutes |
| Duplicate monitor observations | Still 15 transitions and 60 minutes |
| Empty, failed, malformed and cancelled reads | No report dispatch |
| Device escaping, date bounds, idle gaps, terminal frame and page cap | Passed |
| Collector TypeScript, strict settings | Passed locally and in CI |
| Desktop card syntax with dependencies external | Compiled locally and in CI |
| Source-reference checks | Five passed; not a full Rust build |
| Released Mac integrity, startup and local API | Passed |
| Production collector against the actual released Mac database | Passed: 45 frames, 15 observed transitions, 60 interval minutes |
| Empty Mac database selection | Insufficient data, zero report dispatches and zero new pipe executions |
| Model handoff with prepared evidence | Completed in 569,886 ms (about 9 minutes 30 seconds); no tool calls |
| Generated report quality | Failed; see review below |

## Review of the actual model report

The model preserved the two service hostnames, the 15-transition count and the 60-minute value. It no longer invented a missing input file, called the database empty despite valid evidence, or used retrieval tools. This supports the specific acquisition-and-handoff repair.

The report is not suitable for customer delivery. It omits the five-day coverage and explicit frame-ID citations. It proposes a notification after the user manually copies email notes into HubSpot, rather than a concrete implementation that removes that repeated copying. Its steps do not specify the necessary Gmail/HubSpot integration, matching or permissions. It also omits the required uncertainty about observed intervals and achievable savings.

The small local model generated around 1.19 tokens per second on this hosted Mac. This is a result for that disposable runner configuration, not a benchmark of a customer's Mac or other model providers.

The automated content heuristics are diagnostic only and exposed limitations in this run: service hostnames did not satisfy the exact-word Gmail check; `Transition Interval Minutes: 60` did not satisfy the duration formatting regex; and unrelated list numbers allowed the frame-ID heuristic to pass despite no explicit citation. The manual review above corrects those interpretations. The overall report-quality result remains a failure. These heuristics must be tightened before they can become a release acceptance gate.

[Exact prepared evidence, generated text, diagnostic checks and model runtime excerpt](2026-09-06-audit-attempt-3.json) · [Original workflow artifacts](https://github.com/gfrontiero/loopcut-desktop/actions/runs/34040776468/artifacts/9991764956)

## Integration scope

The disposable Mac runs the checksum-pinned published arm64 beta. Synthetic images and supplied OCR text enter through `/add`. The test runs the same production TypeScript coordinator used by the desktop card against the actual release database; its writer adapter sends the prepared evidence to the actual release pipe API. The local model is `qwen2.5:3b`, served by checksum-pinned Ollama `v0.33.3`. Empty input should cause no new pipe execution. The full workload gets one report attempt with a 600-second limit.

The test uses a writer adapter, not a rebuilt desktop UI. It does not verify a real user clicking the updated card, native UI packaging, OCR accuracy, real captured work, permissions, other operating systems, checkout or all privacy paths.

## Remaining limits

Observed transitions are not confirmed completed tasks. Neighboring-frame durations are proxies, not measured active time or achievable savings. Different opportunities can overlap and must not be added together. Repetition within a single unchanged app/window context is not detected. Pattern-based redaction does not guarantee removal of every sensitive string.

The existing full Rust and E2E workflows still fail before compilation on legacy directory references. At this source commit, both the [Mac Rust job](https://github.com/gfrontiero/loopcut-desktop/actions/runs/34040778040/job/101507014040) and [Mac E2E job](https://github.com/gfrontiero/loopcut-desktop/actions/runs/34040778041/job/101507012674) report that `apps/screenpipe-app-tauri` does not exist. Those separate build-workflow repairs are not included here. A rebuilt desktop installer has not been produced, merged or released. The results from the [two earlier failed attempts](2026-09-06-loopcut-audit-followup.md) remain available.

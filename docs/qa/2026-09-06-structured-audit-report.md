# Structured automation report — 6 September 2026

Source commit: `17bb38f2d36e0352716574ba1bd1079d1180df9b`. [Draft PR #1](https://github.com/gfrontiero/loopcut-desktop/pull/1). [Independent test run](https://github.com/gfrontiero/loopcut-desktop/actions/runs/34043301928).

## Problem and change

The preceding model response repeated observations but omitted coverage, source citations and uncertainty, and suggested notifying a user after the same manual work. That exact response is now a regression fixture.

The application now owns the factual report. `automation-audit-report.ts` renders the acquired coverage, supported counts and interval proxies, explicit source-frame pairs and timestamps, sampling status and fixed uncertainty statements. These sections do not depend on the model following formatting instructions.

The model receives compact candidate labels and bounded, pattern-redacted excerpts and returns a structured implementation proposal. Validation requires a known candidate, a source read, a destination write, prerequisites and a validation test; it rejects malformed or incomplete output, unrecognized fields and selected unsupported financial claims. Invalid output preserves the observations and displays a rejection notice. This is structural validation, not a proof that the proposed integration works or removes manual effort.

The desktop chat buffers audit text until validation and then displays the application-rendered report. It does not expose raw proposal JSON while streaming. Retry reacquires evidence. A reported tool start rejects the audit and requests abort; this is not a preventative tool sandbox or a global Pi tool ban. Network/provider errors retain their existing error handling.

## Source verification

- 42 Bun tests pass locally and on GitHub, including the actual earlier bad report, malformed outputs, unsupported candidate references, missing writes/prerequisites, PII/Markdown escaping and application-owned metadata.
- Strict TypeScript checks pass for the production collector and report module.
- Both changed chat components compile with imports external. This verifies syntax, not the full UI build or a click through the updated application.
- 31 source-reference checks pass locally and on GitHub. These cover explicit Rust targets, workflow package names and directories, test inputs and retired Windows runner labels. They do not compile Rust.

## Build workflow repair

The Rust, desktop E2E and Windows CLI workflows now refer to the real `loopcut-*` directories, packages and CLI executable. Their Windows runner selection is `windows-2022`; GitHub retired `windows-2019` on 30 June 2025 ([official notice](https://github.blog/changelog/2025-04-15-upcoming-breaking-changes-and-releases-for-github-actions/)). Obsolete Mac library-path configuration pointing at a nonexistent repository directory was removed.

A follow-up source commit, `58404524c84c9554304f3d1e5a55206c4b421964`, changes the Windows FFmpeg URL after both the Rust and desktop E2E jobs received a 404 from the former gyan.dev package path. The same `8.0.1` shared build is available in the publisher's [versioned GitHub archive](https://github.com/GyanD/codexffmpeg/releases/tag/8.0.1), linked as the official archive from [gyan.dev](https://www.gyan.dev/ffmpeg/builds/). The expected archive filename and FFmpeg version are unchanged. The script compiles with Bun; this is not proof of a passing Windows build.

Release workflows are unchanged. Full build results are recorded below when available; correcting paths alone is not proof of a working rebuilt installer.

## Native integration scope

The test uses the same production collector, proposal validator and report renderer against the published Mac beta database and Pi pipe API, with local `qwen2.5:3b`. It imports 45 synthetic frames across five UTC dates and expects 15 Gmail-to-HubSpot transitions and 60 interval minutes. Empty evidence must produce no model dispatch or new execution.

After validating app startup and health, the test stops audio capture using the release API. This avoids competing transcription work during a synthetic import/analysis test; runtime from this configuration is not a live-recording benchmark or a controlled comparison with the earlier attempt. The model gets one bounded generation attempt. Acceptance requires inspection of both the raw proposal and the final rendered report.

## Native and build results

**The native integration failed its proposal acceptance gate.** Acquisition, arithmetic and application-owned report rendering passed; the local model did not finish within the configured limit.

| Check | Observed result |
| --- | --- |
| Published installer checksum, native startup and local database/API | Passed |
| Empty selection | Insufficient data; zero report dispatches and zero new executions |
| Synthetic evidence | 45 frames across five UTC dates; 15 Gmail-to-HubSpot transitions; 60 interval minutes |
| Local model execution | Timed out after 600,313 ms; no completed assistant text was saved |
| Proposal validator | Rejected the empty completed response, as intended |
| Application-rendered fallback | Retained coverage, tool labels, counts, explicit frame pairs/timestamps and unmeasured-savings caveat |
| Useful model-generated implementation | Not established; no completed proposal to review |
| Updated desktop installer / customer click-through | Not established |

The model log shows roughly 1,670 generated tokens before cancellation, with generation rates around 3.1–3.4 tokens per second in the saved tail. The instruction to respond concisely did not yield a completed proposal within the execution limit. The saved result does not identify the content of its unfinished response or establish the cause. No tool calls were recorded in the saved execution, but an empty timed-out response is not evidence of preventative tool isolation.

The release pipe's 600-second execution timeout bounds this integration test. It is not a newly implemented timeout for general desktop chat. The passing fallback checks verify the production renderer through the test adapter, not the rebuilt UI's handling of a provider timeout.

[Exact evidence and result](2026-09-06-audit-attempt-4.json) · [Application-rendered fallback](2026-09-06-audit-attempt-4-rendered.md) · [Original artifacts](https://github.com/gfrontiero/loopcut-desktop/actions/runs/34043301928/artifacts/9992498809).

**Decision:** the evidence/report boundary is materially improved, but this local-model configuration is not accepted for a customer pilot. The next report-writer test should use a capable configured provider with an enforced output limit. Increasing this timeout or rerunning the same setup is not evidence of a fix.

At `17bb38f2`, the repository-wide formatting job reported differences in 26 Rust files; none was the template-registration Rust file changed by this PR. Clippy therefore did not run. The dependency job failed while installing `cargo-audit 0.22.2`: an unlocked transitive dependency, `kstring 2.0.4`, requires Rust 1.96 while the job used 1.93.1. These checks are not passing, and no suppression or repository-wide reformat is included here. [Formatting job](https://github.com/gfrontiero/loopcut-desktop/actions/runs/34043304072/job/101513810603) · [Dependency-tool job](https://github.com/gfrontiero/loopcut-desktop/actions/runs/34043304072/job/101513810744).

The first Windows Rust and desktop E2E attempts reached the corrected directories but failed on the removed FFmpeg download. After the archive URL correction, the Windows Rust job passed `Run pre_build.js` and `Copy test image` and reached `Run specific Windows OCR cargo test`. This confirms recovery from the download blocker; it does not confirm a completed Windows build. Full checks continue in [desktop E2E](https://github.com/gfrontiero/loopcut-desktop/actions/runs/34043616456) and [Rust CI](https://github.com/gfrontiero/loopcut-desktop/actions/runs/34043616444).

## Proposal review standard

Beyond JSON acceptance, review whether the proposed trigger replaces the observed copying, how the relevant Gmail messages are selected, how a unique destination record is chosen, what happens to unmatched or ambiguous records, how retries avoid duplicate notes, and how output accuracy and manual effort would be compared in a small sample.

The broad integration is plausible: Gmail documents filtering message lists by label and fetching message details ([list](https://developers.google.com/workspace/gmail/api/reference/rest/v1/users.messages/list), [get](https://developers.google.com/workspace/gmail/api/reference/rest/v1/users.messages/get)); HubSpot documents creating notes and associating them with existing records ([notes API](https://developers.hubspot.com/docs/api-reference/legacy/crm/activities/notes/guide)). This is an inference from available APIs, not evidence that the model's particular proposal or any customer setup has been implemented or validated.

## Customer readiness

No automation has been installed into a customer's Gmail or HubSpot account. Captured app switching does not prove the precise business task or an integration's feasibility. Savings and monetary value remain unmeasured. No paid pilot, payment collection or revenue is established by these tests.

The prior [application-evidence test](2026-09-06-application-evidence-audit.md) and [earlier model attempts](2026-09-06-loopcut-audit-followup.md) remain as historical results.

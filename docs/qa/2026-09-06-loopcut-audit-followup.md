# Loopcut audit test follow-up — 6 September 2026

Historical results for the first two model attempts. The subsequent application-code change and its completed test are documented in [Application evidence collection](2026-09-06-application-evidence-audit.md).

**The audit test is now implemented and has been run against the actual released engine. It did not produce a passing report.** The source-reference fixes and data-import checks pass. The proposed report instructions and a larger local model were insufficient to establish a reliable audit.

This supersedes the initial report's “not run” status for the narrow import-to-audit integration. It does not certify the entire desktop product.

## Changes saved in draft PR #1

- Repaired the engine binary and audio example manifest paths.
- Updated Mac E2E CI to build the existing `loopcut-engine` package and run its `loopcut` binary.
- Registered an Automate My Work built-in template so it is available when normal templates load.
- Replaced the stale fallback prompt with the same instructions as the built-in template.
- Used POST /raw_sql and the current frames schema; added bounded time estimates, evidence requirements, an insufficient-data outcome, and explicit savings assumptions.
- Added a real integration test using the release's supported pipe-install and frame-import APIs, with local model execution on a disposable Mac.

The updated built-in registration is source code in the draft. A rebuilt desktop installer has not been produced or published.

## Results

| Check | Result |
| --- | --- |
| Five source-reference checks | Passed |
| Seven production log-sanitizer cases | Passed |
| Fallback/built-in prompt parity | Passed |
| Published arm64 Mac beta integrity and startup | Passed in both follow-up runs |
| Revised pipe installed using the release API | Passed |
| Both production SQL queries against the released schema | Passed |
| Synthetic /add import and readback | Passed: 45 frames, 3,600 supported interval seconds |
| Qwen2.5 3B audit | Failed: no required /raw_sql tool calls recorded; no valid report |
| Qwen3 4B Instruct audit | Failed: both cases timed out after approximately 900 seconds each |
| Finished customer-ready sample audit | Not produced |

The seven sanitizer tests cover a logging helper, not all capture, model or network data flows. The source checks are not a successful full Rust build.

## Attempt 1: completed agent processes, failed task

[Workflow run](https://github.com/gfrontiero/loopcut-desktop/actions/runs/34037059998), source commit `34e77fb49737e6b6d2f2c3519a4c5abcc93ea3ff`, Ollama `v0.33.3`, model `qwen2.5:3b`.

The empty-data case referenced a nonexistent frames JSON file, then printed a SQL query. The workload case also referenced a nonexistent file and said there was insufficient data, despite the harness verifying the stored workload. Neither recorded the required /raw_sql tool call. Both agent processes were marked completed, demonstrating why process success must not be treated as audit success.

[Preserved results and model text](2026-09-06-audit-attempt-1.json) · [Original artifacts](https://github.com/gfrontiero/loopcut-desktop/actions/runs/34037059998/artifacts/9990649165)

## Attempt 2: explicit database instructions, larger local model

[Workflow run](https://github.com/gfrontiero/loopcut-desktop/actions/runs/34037769709), source commit `4c0b9595c37b1a0606405c91e526786bcec7c45a`, model `qwen3:4b-instruct-2507-q4_K_M`.

The revised instructions explicitly distinguished the scheduler's default one-hour header from the audit's seven-day range, explained that recordings live in the database, required an executed query, and distinguished query failure from insufficient data.

Both the empty case and workload case timed out at approximately 900 seconds. No finished report was preserved. The model-server log showed generation around one token per second near the end. This is evidence about this GitHub-hosted Mac configuration; it is not a benchmark of a normal customer's Mac or proof that other model configurations cannot work.

The zero tool-call counts in this timed-out attempt must not be taken as proof no calls occurred: incomplete output may be lost on timeout. The definitive result is that neither case completed with an acceptable report.

[Preserved results and runtime log excerpt](2026-09-06-audit-attempt-2.json) · [Original artifacts](https://github.com/gfrontiero/loopcut-desktop/actions/runs/34037769709/artifacts/9991199944)

## What the test actually exercises

The test installs the revised product pipe into the unchanged released Mac app, configures a local model on a disposable runner, and invokes the app's real pipe-execution API. The sample uses the supported /add import API with synthetic images and supplied OCR text. Dates are shifted into the last seven days; idle boundaries make the intended task intervals explicit.

This tests import, storage, retrieval and attempted analysis. It does not simulate a real user's week of screen capture or verify OCR accuracy, interactive permissions, the revised desktop UI bundle, Intel Macs, Windows, Linux, paid checkout or the entire privacy pipeline. No customer records or customer model credentials were used.

## Next engineering change

The first failure exposes a specific weakness: the agent can finish without obtaining the evidence needed for its task. Prompt changes alone have not validated a reliable reporting path.

The next change should make evidence collection an application step before model invocation:

1. Query and validate the requested recordings in code. Return query errors and genuine insufficient-data states directly.
2. Compute bounded, non-overlapping duration estimates and observed transitions in code; retain provenance and label sampled or incomplete coverage.
3. Give the model the validated evidence to explain and recommend actions. Do not rely on the model deciding whether to obtain the data.
4. Validate the resulting report against that evidence, then test it with the production-intended model and an explicitly chosen latency budget.

At the time of these two attempts, that application-code change was not implemented. It was subsequently added and tested; see [Application evidence collection](2026-09-06-application-evidence-audit.md). The report-quality limitation remains open.

## Other existing CI failures

The repository's broader Rust CI also failed before compilation on old paths: the Mac job uses `apps/screenpipe-app-tauri`, and Ubuntu tries to copy `crates/screenpipe-screen/tests/testing_OCR.png`. Those separate references have not been changed here. Do not interpret the passing source preflight as a clean full build or a merge-ready release.

[Mac CI failure](https://github.com/gfrontiero/loopcut-desktop/actions/runs/34037060002/job/101496944944) · [Ubuntu CI failure](https://github.com/gfrontiero/loopcut-desktop/actions/runs/34037060002/job/101496945102)

The source changes remain in [draft PR #1](https://github.com/gfrontiero/loopcut-desktop/pull/1). The original download remains unchanged.

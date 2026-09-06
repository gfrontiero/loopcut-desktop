# Loopcut independent tests

These checks use synthetic data and disposable GitHub runners, without operating the owner's desktop.

## Production audit flow

The desktop Automate My Work card now calls `runAutomationAudit` in `apps/loopcut-app-tauri/lib/automation-audit.ts`. It reads the actual local `/raw_sql` API before invoking the existing configured Pi chat writer. The model no longer decides whether to retrieve evidence.

The collector freezes the requested seven-day range and maximum frame ID, validates coverage and every page, and makes at most six read-only requests (one coverage request and five pages of 2,000 frames). Later capture inserts are excluded. A truncated read is disclosed as an early chronological sample. HTTP, schema, cancellation and incomplete-read failures become Analysis failed. Successful empty or unsupported evidence becomes Insufficient data. Neither result dispatches a report.

Application code groups adjacent app/window contexts, counts repeated observed transitions, retains example frame IDs and timestamps, and merges overlapping capture intervals. Intervals longer than five minutes, idle markers and terminal frames add no duration. These are activity proxies, not task completion counts or measured savings. Only three candidate labels and bounded, pattern-redacted excerpts reach the writer. Counts, dates, durations and citations stay in application-owned report data. The current detector does not identify repetition within one unchanged app/window context.

The report-only pipe and fallback card share structured proposal instructions. The model proposes a workflow in JSON; production `automation-audit-report.ts` validates its structure and renders the final Markdown from verified evidence. Coverage, citations, durations and uncertainty are always application-generated. Invalid or incomplete proposals retain the verified observations and display a rejection notice. Chat streaming buffers this audit response until validation; retry reacquires evidence. Structural acceptance does not prove that an integration is feasible or that it will save time.

The report-only pipe and fallback card share the writer instructions. Standalone pipe runs require prepared evidence in their context; they do not perform acquisition. The automatic collection entry point is the desktop card. This change does not replace the general-purpose Pi engine or enforce a global tool ban.

## Test coverage

- Source preflight checks explicit Rust targets, workflow package names, repository directories, test inputs and retired Windows runner labels; it is not a Rust build.
- Bun tests execute the production SQL against SQLite and exercise dispatch ordering, empty/error/cancelled input, invalid frames, escaping, time boundaries, monitor overlap, terminal frames and pagination. They also cover the existing PII helper and shared writer prompt. Report tests reject the actual earlier bad model response, invented candidates, malformed JSON, missing writes, notification-only actions and unsupported savings fields; they verify application-owned facts and escaping.
- TypeScript checks the collector and report module with strict settings. Bun compiles both changed chat components with dependencies external; this is not a complete UI build or click test.
- The Mac test checks the checksum-pinned public DMG, signature assessment, native startup and health endpoint.
- The Mac integration runs that same production TypeScript coordinator against the release's database. Its writer adapter passes the production compact proposal prompt through the actual release pipe API to a local model, then calls the production validator and Markdown renderer. Empty evidence must produce zero dispatches and zero new pipe executions.

The Mac integration does not rebuild the desktop UI or verify Finder installation, customer permissions, other platforms, a real captured workweek, all privacy paths, or paid checkout. After checking startup, the test stops audio capture through the release API to avoid background recording work competing with local inference. This is not a live-recording performance benchmark. The model test uses one bounded report generation; content checks are followed by a review of the actual Markdown.

## Fixture and acceptance

`synthetic-week.json` represents 15 Gmail-to-HubSpot transitions across five days, totaling 60 minutes. The importer shifts the dates into the last seven days and adds an idle boundary after each pair, for 45 frames. Synthetic images and supplied OCR enter through `/add`; no real customer activity is captured.

Before report generation, the production collector must observe 45 frames, 15 transitions and 60 interval minutes. The model must complete without retrieval tools and return a structurally accepted proposal that reads from the source and writes to the destination. The production renderer must include exact verified observations, source frame pairs and timestamps, recorded-day coverage and unmeasured-savings caveats. Arithmetic, inference, prerequisites and validation steps require review of the saved report. The older fixture's $50/hour and annual values are not supplied to this test's writer; monetary savings remain unmeasured.

## Running

```sh
python3 qa/loopcut-smoke/preflight.py
bun test qa/loopcut-smoke/privacy.test.ts qa/loopcut-smoke/audit-prompt.test.ts qa/loopcut-smoke/audit-evidence.test.ts qa/loopcut-smoke/audit-report.test.ts
```

Packaging/startup only, on a Mac:

```sh
python3 qa/loopcut-smoke/mac_release.py
```

The full integration is restricted to a disposable GitHub Actions runner. The workflow installs Bun and a checksum-pinned Ollama release, then runs `mac_release.py` with `LOOPCUT_AUDIT_TEST=1`. Prepared evidence, raw model output, application-rendered Markdown and execution records are uploaded from `qa-results/` for 30 days. There is no recurring schedule.

[Initial results](../../docs/qa/2026-09-06-loopcut-test-results.md) and [the two earlier failed model attempts](../../docs/qa/2026-09-06-loopcut-audit-followup.md) are retained as historical evidence.

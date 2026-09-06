# Loopcut independent smoke test

This test setup targets the public desktop repository and the published v0.1.0-beta Mac installer. It uses disposable GitHub-hosted machines. It does not charge a customer, publish a release, or need Greg's computer.

## What it runs

- Source preflight: checks declared Rust source files and package names in the existing Mac workflow against the checkout. A missing source file is a real build blocker.
- Privacy unit tests: imports the production log-redaction helper and checks six types of synthetic sensitive data plus ordinary numeric text. This is not a test of the entire recording or privacy pipeline.
- Released Mac smoke test: downloads the exact beta, checks its published SHA-256, mounts it read-only, inspects the app bundle and signature, launches the native executable for a bounded startup window only if Gatekeeper approves it, and probes its local health API. It preserves Gatekeeper and screen/microphone permission controls.

A running process or a working health API does not prove the full desktop workflow works. The ordinary Finder installation experience and permission prompts still need a real interactive check.

## Synthetic week

`synthetic-week.json` contains 15 repeated Gmail-to-HubSpot tasks across five days, totaling 60 observed minutes. It is an acceptance fixture, not a generated customer report. No verified audit-generation entry point has been located yet, so an end-to-end audit result must remain NOT RUN until the real product consumes this fixture or equivalent captured test data.

A completed audit test must:
1. Identify the actual repeated Gmail-to-HubSpot workflow.
2. Reconcile frequency and duration to the fixture.
3. Separate measured time from estimated savings and show the hourly-rate assumption.
4. Produce the real customer-facing report and implementation steps.
5. Preserve the product's privacy settings.

## Baseline findings, 2026-09-06

Source commit: `ba9873f701fded1c698835f2624e0f23f17fbe42`.

- The existing Mac CI's latest inspected run failed before its API tests. Its build command requests `screenpipe-engine`, but the package is named `loopcut-engine`.
- The engine manifest declares `src/bin/loopcut-engine.rs`; the source tree contains `src/bin/screenpipe-engine.rs`.
- Seven synthetic checks of the production log sanitizer passed in an isolated JavaScript evaluator after removing TypeScript signature annotations. CI reruns these against the unmodified TypeScript module under Bun.
- The local Linux executor became unavailable. The Mac test runs in GitHub instead.
- Full capture-to-audit behavior has not been verified. The published installer is tested independently of the source preflight.

## Running again

The workflow runs when this test branch changes. Once merged, it can also be started with GitHub Actions' manual Run workflow control. There is no recurring schedule. Read each job and its JSON artifact separately; one passing job does not mean the product passed end to end.

Locally, with Python 3.11+ and Bun:
```sh
python3 qa/loopcut-smoke/preflight.py
bun test qa/loopcut-smoke/privacy.test.ts
# Mac only:
python3 qa/loopcut-smoke/mac_release.py
```

The Mac test downloads and launches the trusted beta linked in the public release. It never removes quarantine or bypasses macOS privacy prompts. Startup logs in the JSON report are truncated and scrubbed; the app only sees a disposable CI desktop.

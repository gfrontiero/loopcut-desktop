# Loopcut independent tests

These tests run on disposable GitHub-hosted machines. They exercise the public Mac beta and the revised automation-audit prompt without operating the owner’s desktop.

## Coverage

- Source preflight verifies explicitly declared Rust targets and package names in Mac E2E CI. It is not a full Rust compilation.
- Bun tests run the production log-redaction helper and verify that the fallback and installed automation cards share the same prompt.
- The Mac test verifies the pinned release checksum, signature assessment, native startup and health endpoint.
- The audit integration installs the revised product pipe through the release’s `/pipes/install` API, configures a local Ollama model on the disposable runner, and runs the real pipe engine.
- The empty-data case must query the API and admit there is insufficient data.
- The workload case imports synthetic frames through `/add`, reads them back through `/raw_sql`, and checks the report against the known workflow. Failed model output does not count as a passed audit merely because the agent process exits successfully.

The integration uses the released native engine plus an installed, revised pipe. It does not rebuild the desktop bundle or verify Finder installation, customer permissions, Intel Macs, Windows, Linux, a real workweek, all privacy flows or paid checkout.

## Fixture and acceptance

`synthetic-week.json` represents 15 Gmail-to-HubSpot tasks across five days, totaling 60 minutes. The importer shifts the dates into the last seven days and adds an idle boundary after each task. It supplies synthetic images and OCR text through the supported import API; it does not pretend to capture real work.

The test verifies all 45 imported frames and 3,600 seconds through the actual release database before judging AI output. The model must query the product API, identify Gmail and HubSpot, identify 15 repetitions, state the supported one-hour duration, and provide an implementation trigger. An additional human review of the saved output must assess arithmetic, evidence, assumptions and implementation quality. Content checks alone are insufficient.

The $50/hour and 50 working weeks are explicit scenario assumptions. Observed task duration is not guaranteed savings. No real customer records or model-account credentials are required by this test.

## Running

Source and helper checks require Python 3.11+ and Bun:

```sh
python3 qa/loopcut-smoke/preflight.py
bun test qa/loopcut-smoke/privacy.test.ts qa/loopcut-smoke/audit-prompt.test.ts
```

For packaging/startup only on a Mac:

```sh
python3 qa/loopcut-smoke/mac_release.py
```

The complete local-model integration is restricted to a disposable GitHub Actions runner. The workflow runs `setup_local_model.py`, then launches `mac_release.py` with `LOOPCUT_AUDIT_TEST=1`. It downloads a checksum-pinned Ollama release and records the selected model’s digest. It has no recurring schedule. Results, generated Markdown, execution records and observed-frame evidence are uploaded from `qa-results/` with 30-day retention.

Historical baseline: [initial test results](../../docs/qa/2026-09-06-loopcut-test-results.md). [Follow-up audit results](../../docs/qa/2026-09-06-loopcut-audit-followup.md) record both failed attempts with exact workflow runs and source commits.

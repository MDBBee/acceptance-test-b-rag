# b-rag Automation

End-to-end smoke tests for [b-rag](https://github.com/mdbbee/b-rag), a RAG-powered document ingestion and retrieval app. Built to catch regressions in core flows before they hit production.

![Retrieval test in action](retrieval_test.png)

## Why Robot Framework + Selenium

Robot Framework gives us readable, keyword-driven tests that non-engineers can follow. SeleniumLibrary handles the browser automation. The Page Object pattern keeps locators isolated from test logic, so when the UI changes, we fix it in one place.

## What it tests

| Test | Coverage |
|------|----------|
| **Ingestion** | Login → create project → upload PDF → wait for vectorization |
| **Retrieval** | Login → open project → new conversation → query document → verify response |

## Project structure

```
b-rag-automation/
├── pages/           # Page objects (locators + keywords)
├── resources/       # Shared keywords and non-secret config
├── tests/smoke/     # Smoke test suites
├── data/            # Test artifacts (PDFs, etc.)
└── secrets_variables.py
```

## Setup

### Prerequisites

- Python 3.14+
- [uv](https://docs.astral.sh/uv/) package manager
- Chrome installed

### Install

```bash
git clone https://github.com/mdbbee/b-rag-automation.git
cd b-rag-automation
uv sync
```

### Configure secrets

Create a `.env` file in the project root:

```env
BASE_URL=
TEST_EMAIL=
TEST_CODE=
TEST_PDF_PATH=
```

These are loaded by `secrets_variables.py` and available as Robot variables.

## Running tests

Run from the project root so the suite setup fires correctly:

```bash
# All smoke tests
uv run robot --outputdir results --suite smoke tests

# Just ingestion
uv run robot --outputdir results --include ingestion tests

# Just retrieval
uv run robot --outputdir results --include retrieval tests
```

Results land in `results/` (gitignored) — open `log.html` for the full breakdown.

## Adding tests

1. Create a page object in `pages/` with locators and keywords for that page
2. Add a test in `tests/smoke/` with the `_test.robot` suffix
3. Tag it with `smoke` plus a descriptive tag (e.g., `ingestion`, `retrieval`)

Resource paths are relative to the test file — use `../../resources/` from `tests/smoke/`.

## Notes

- Browser session is shared across tests (opened once in suite setup)
- Hidden file inputs need `Make Element Visible` before `Choose File`
- Long-running operations use generous timeouts (up to 120s)

## CI/CD

Wire this into your pipeline to run on every PR or nightly:

```bash
uv sync
uv run robot --outputdir results --suite smoke tests
```

Upload `results/log.html` as an artifact for debugging failures.

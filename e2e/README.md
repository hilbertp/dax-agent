# Dax Agent E2E Regression Tests

This directory contains end-to-end regression tests for the Dax Agent using Playwright.

## Prerequisites

1.  **Node.js**: Ensure Node.js is installed.
2.  **Brave Browser**: The tests are configured to use the Brave browser.
    *   **Mac Default Path**: `/Applications/Brave Browser.app/Contents/MacOS/Brave Browser`
    *   If your Brave installation is elsewhere, update `executablePath` in `playwright.config.ts`.

## Setup

1.  Navigate to this directory:
    ```bash
    cd e2e
    ```
2.  Install dependencies:
    ```bash
    npm install
    ```

## Running the Tests

To run the regression test:

```bash
npx playwright test
```

### Manual Login Step
The test uses a **persistent browser context** to try and reuse your existing login session.

1.  The test will launch Brave and navigate to `https://agent.ii.inc/`.
2.  If you are **not logged in**, the test will pause and output:
    > Login required. Pausing for manual login...
3.  **Action**: Log in manually in the browser window that opened.
4.  Once you reach the dashboard ("New chat" button visible), the test will automatically detect this and resume.

## Evidence

Test artifacts (screenshots, logs) are saved to:
`e2e/evidence/<timestamp>/`

## Configuration

*   **Browser Path & Settings**: Modified in `playwright.config.ts`.
*   **Target URL**: Defaults to `https://agent.ii.inc/` in `playwright.config.ts`.

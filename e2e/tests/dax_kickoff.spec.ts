import { test, expect, chromium, BrowserContext, Page } from '@playwright/test';
import path from 'path';
import fs from 'fs';

// Helper to determine evidence path
const evidenceRoot = path.join(__dirname, '../evidence');
const timestamp = new Date().toISOString().replace(/[:.]/g, '-');
const evidenceDir = path.join(evidenceRoot, timestamp);
const userDataDir = path.join(__dirname, '../user_data');

let context: BrowserContext;
let page: Page;

test.beforeAll(async () => {
    // Ensure evidence directory exists
    if (!fs.existsSync(evidenceDir)) {
        fs.mkdirSync(evidenceDir, { recursive: true });
    }
    console.log(`Evidence directory: ${evidenceDir}`);

    // Launch Persistent Context (Chrome)
    console.log(`Launching Chrome with user data dir: ${userDataDir}`);
    context = await chromium.launchPersistentContext(userDataDir, {
        channel: 'chrome',
        executablePath: '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome',
        headless: false,
        args: [
            '--no-sandbox',
            '--disable-setuid-sandbox',
            '--disable-blink-features=AutomationControlled'
        ],
        baseURL: 'https://agent.ii.inc/',
        viewport: { width: 1280, height: 720 },
        ignoreHTTPSErrors: true,
    });

    page = context.pages()[0] || await context.newPage();
});

test.afterAll(async () => {
    if (context) await context.close();
});

test.afterEach(async ({ }, testInfo) => {
    // Collect artifacts using the shared 'page' instance
    if (page) {
        const screenshotName = testInfo.status === 'passed' ? 'success' : 'failure';
        await page.screenshot({ path: path.join(evidenceDir, `${screenshotName}.png`) });
        if (testInfo.status === 'failed') {
            const html = await page.content();
            fs.writeFileSync(path.join(evidenceDir, 'failure.html'), html);
        }
    }

    const transcriptPath = path.join(evidenceDir, 'transcript.json');
    const result = {
        status: testInfo.status,
        duration: testInfo.duration,
        error: testInfo.error
    };
    fs.writeFileSync(transcriptPath, JSON.stringify(result, null, 2));

    console.log(`${testInfo.status.toUpperCase()}`);
    if (testInfo.status === 'failed') {
        console.log(`Assertion failed: ${testInfo.error?.message}`);
    }
    console.log(`Evidence saved to: ${evidenceDir}`);
});


test('Dax Kickoff Regression', async () => {
    test.setTimeout(300000); // Allow 5 minutes for manual login and agent installation

    // 1. Navigate
    await page.goto('/');

    // 2. Switch to Agent Mode
    console.log('Switching to Agent Mode...');
    try {
        const agentModeBtn = page.getByText('Agent Mode');
        await expect(agentModeBtn).toBeVisible({ timeout: 10000 });
        await agentModeBtn.click();
    } catch (e) {
        console.log('Agent Mode button not found. Dumping screenshot...');
        await page.screenshot({ path: path.join(evidenceDir, 'debug_agent_mode_fail.png') });
        throw e;
    }

    // Wait for mode switch
    await page.waitForTimeout(1000);

    await page.screenshot({ path: path.join(evidenceDir, 'after_agent_mode.png') });

    // 3. Send Kickoff Message
    console.log('Sending Kickoff Prompt...');
    const kickOffMessage = `
mkdir -p .dax_test_project
cd .dax_test_project
curl -fsSL https://raw.githubusercontent.com/hilbertp/dax-agent/main/install.sh | sh
./.dax/agent/bootstrap.sh
  `.trim();

    // Use placeholder seen in screenshot
    const inputArea = page.getByPlaceholder('Describe what you want to accomplish...').or(page.locator('textarea'));
    await expect(inputArea).toBeVisible();
    await inputArea.fill(kickOffMessage);
    await page.waitForTimeout(500);

    // Try pressing Enter
    await inputArea.press('Enter');

    // Also try clicking the submit/send button if it exists nearby.
    const sendButton = page.locator('button.bg-primary').last();
    if (await sendButton.isVisible()) {
        console.log('Found potential Send button, clicking...');
        await sendButton.click();
    }

    await page.screenshot({ path: path.join(evidenceDir, 'after_send.png') });

    try {
        // 6. Wait for Response & Assertions
        // "Dax Runtime Installer" from install.sh
        await expect(page.getByText('Dax Runtime Installer')).toBeVisible({ timeout: 60000 });
        await expect(page.getByText('Installation Complete')).toBeVisible({ timeout: 60000 });
    } catch (e) {
        console.log('Assertions failed. Dumping page text:');
        console.log(await page.innerText('body'));
        throw e;
    }

    // Wait for bootstrap output
    // The finish marker 'Agent Loop Check' or similar
    // We assume 'Agent Loop Check' appears at the end of bootstrap or gateway check
    await expect(page.getByText('Agent Loop Check')).toBeVisible({ timeout: 120000 });

    // Capture final state
    await page.screenshot({ path: path.join(evidenceDir, 'completion.png') });
});

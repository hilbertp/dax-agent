import { defineConfig, devices } from '@playwright/test';
import path from 'path';

export default defineConfig({
  testDir: './tests',
  timeout: 120000,
  fullyParallel: false,
  retries: 0,
  workers: 1, // Sequential execution for checking login state
  reporter: 'line',
  use: {
    baseURL: 'https://agent.ii.inc/',
    trace: 'on',
    screenshot: 'on',
    video: 'retain-on-failure',
    ignoreHTTPSErrors: true,
  },
  projects: [
    {
      name: 'brave',
      use: {
        ...devices['Desktop Chrome'],
        channel: 'chrome', // Use chrome channel but point to brave executable
        headless: false,
        launchOptions: {
          executablePath: '/Applications/Brave Browser.app/Contents/MacOS/Brave Browser',
          args: [
            '--no-sandbox',
            '--disable-setuid-sandbox',
          ],
        }
      },
    },
  ],
  outputDir: 'test-results/',
});

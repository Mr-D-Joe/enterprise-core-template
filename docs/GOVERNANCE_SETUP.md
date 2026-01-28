# GitHub Governance Setup (Mandatory)

To finalize the **Enterprise Core Template** as a secure, read-only "Gold Standard", you **MUST** perform the following configuration in the GitHub Repository Settings.

## 1. Branch Protection Rules (Critical)

Go to **Settings** → **Branches** → **Add branch protection rule**.

### For branch: `main` (or `master`)
1.  **Check "Require a pull request before merging"**
    *   Check "Require approvals" (Minimum: 1 or 2).
    *   Check "Require review from Code Owners" (Enforces `.github/CODEOWNERS`).
2.  **Check "Require status checks to pass before merging"**
    *   Search for and select: `governance-conformance` (The workflow we created).
3.  **Check "Do not allow bypassing the above settings"**
    *   This ensures even Admins cannot push directly.
4.  **Check "Lock branch"** (Optional, for strict Read-Only mode)
    *   If checked, the branch is read-only. Updates require disabling this temporarily.

## 2. Template Repository

Go to **Settings** → **General**.
*   Check **"Template repository"**.
    *   This allows users to generate *new* repositories from this one without forking.

## 3. Deployment

1.  Commit all changes locally.
2.  Push to GitHub:
    ```bash
    git add .
    git commit -m "chore(release): finalize enterprise core template v1.1"
    git push origin main
    ```

---
description: Standard operating procedure for project completion and deployment to GitHub
---

# Deployment & GitHub Sync Workflow

> **CRITICAL RULE:** A project task is ONLY complete when changes are successfully pushed to GitHub and verified. Local "clean status" is NOT sufficient.

## 1. Pre-Deployment Check
- [ ] Run `git status` to ensure all changes are tracked.
- [ ] Verify `git remote -v` points to the correct upstream.

## 2. Commit
- [ ] Stage all relevant changes: `git add .` (or specific files).
- [ ] Commit with Conventional Commits: `git commit -m "type(scope): description"`

## 3. Push & Verify (Atomic Operation)
- [ ] **Push:** `git push origin main`
- [ ] **Wait:** Wait for the command to finish.
- [ ] **Verify:** Check exit code must be `0`.
- [ ] **Check Output:** Look for `main -> main` or `up-to-date`.

## 4. Failure Handling
- If `git push` fails (e.g., rejections, non-fast-forward):
  - **Pull first:** `git pull --rebase origin main`
  - **Resolve conflicts** if any.
  - **Retry Push:** `git push origin main`

## 5. Success Confirmation
- Only report "Task Completed" to the user after Step 3 is confirmed.

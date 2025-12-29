# PRD Example: Authentication System for Production App

## Problem Statement

Our application currently has no user authentication. Any visitor can access all features and data regardless of role or permission. This exposes us to data loss, compliance violations, and operational risk. Users cannot have personalized workflows or secure accounts.

## Constraints

- **Timeline**: MVP authentication must be live in 4 weeks.
- **Tech stack**: Node.js backend, React frontend, PostgreSQL. No new runtime dependencies without CTO approval.
- **Security**: Must meet SOC 2 requirements for access control logging. Passwords hashed with bcrypt. Session timeout 30 min idle.
- **User base**: Initial launch: 50 internal users. Scalable to 10k in year 1.
- **Budget**: 120 engineering hours for full cycle (design + implement + test + deploy).

## Success Criteria

1. All API endpoints require authentication token or session cookie; unauthenticated requests return 401.
2. Users can register, log in, and log out via web UI in <3 seconds.
3. User roles (admin, editor, viewer) are enforced; test coverage >80%.
4. Access logs record login, logout, and failed attempts for all users. Logs retained 90 days.
5. No data loss in migration of existing (anonymous) user state to authenticated accounts.
6. Performance: login endpoint p99 <500ms; token validation <50ms.
7. Deployment to staging must pass manual security review before production release.

## Assumptions

- Authentication will use JWT tokens for API, session cookies for web UI.
- User email is unique identifier (no separate username).
- No 3rd-party auth integrations in MVP (SSO, OAuth deferred to phase 2).

## Out of Scope

- Multi-factor authentication (deferred to phase 2).
- Account recovery / password reset workflows (MVP: support ticket only).
- Audit trail UI (logs stored, not yet visualized).

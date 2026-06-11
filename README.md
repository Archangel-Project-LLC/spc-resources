# SPC Seminar Resources

Static site — no build step, no dependencies.

## Deploy on GitHub Pages
1. Create a repo (e.g. `spc-resources`), push these files to `main`.
2. Repo → Settings → Pages → Source: "Deploy from a branch" → `main` / root.
3. Live at `https://<username>.github.io/spc-resources/` within a minute or two.

## Deploy on Cloudflare Pages (recommended — custom domain is easier)
1. Cloudflare dashboard → Workers & Pages → Create → Pages → Upload assets (or connect the GitHub repo).
2. No build command, output directory = root.
3. Attach a subdomain, e.g. `resources.silverbackperformance.com`.

## Before sending the link
- index.html: replace `[LINK — replace me]` with the Silverback Macro Tracker URL.

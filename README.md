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

## Client CRM (`crm.html`) — internal, cloud-synced

`crm.html` is a coach-facing client manager. It is **not** linked from `index.html`
and is marked `noindex` — reach it directly at `/crm.html`. Unlike the other pages,
it stores data in a cloud database (Supabase) with a login, so your roster syncs
across every device you sign in from.

### One-time setup (~5 minutes)
1. Create a free project at <https://supabase.com> (pick a region near you) and let it finish provisioning.
2. In the project, open **SQL Editor**, paste the contents of `supabase-schema.sql`, and click **Run**. This creates the `clients` table with row-level security (each account only sees its own clients).
3. Go to **Project Settings → API** and copy the **Project URL** and the **anon public** key.
4. Open `crm.html`, find the `CONFIG` block near the top of the `<script>`, and paste those two values into `SUPABASE_URL` and `SUPABASE_ANON_KEY`. Commit and deploy.
5. In **Authentication → Sign In / Providers**, ensure **Email** is enabled. (For a single-user tool you can turn *off* email confirmations for instant sign-in.)
6. Open `/crm.html`, click **Create account**, and register once with your email and a password.

### Notes
- Until the `CONFIG` values are filled in, the page shows the setup checklist instead of the app.
- The anon key is safe to ship in the client — row-level security is what protects the data, and it is enabled by `supabase-schema.sql`.
- Security tip: after you have created your account, disable new sign-ups in **Authentication → Sign In / Providers** so no one else can register.
- Changes sync live between open devices via Supabase Realtime.


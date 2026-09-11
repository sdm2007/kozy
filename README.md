# Kozy — JEE Study Companion

A static HTML/CSS/JavaScript study companion with optional Supabase authentication and cloud sync.

## Files

- `index.html` — the complete web app.
- `supabase-schema.sql` — database table + Row Level Security policies for cloud sync.

## Run locally

Open `index.html` in a browser. Without Supabase credentials, Kozy runs in local-storage mode.

## Enable cloud sync

1. Create a Supabase project.
2. Open the Supabase SQL Editor and run `supabase-schema.sql`.
3. In `index.html`, replace:
   - `YOUR_SUPABASE_PROJECT_URL`
   - `YOUR_SUPABASE_PUBLISHABLE_KEY`
4. In Supabase Authentication → URL Configuration, add the final deployed site URL to the allowed redirect URLs.

The publishable/anon key is intended for browser use; do **not** put a Supabase service-role key in this file. Keep the RLS policies enabled.

## Deploy

### GitHub Pages

Upload `index.html`, `supabase-schema.sql`, and this README to a GitHub repository. In **Settings → Pages**, choose **Deploy from a branch**, select `main` and `/ (root)`, then Save.

### Netlify

Create a Netlify site and drag the project folder containing `index.html` into the deploy area. Netlify will publish it and give you a `.netlify.app` URL.

### Vercel

Create a new Vercel project and import this repository. Since this is a static site, no build command is required; the project root should contain `index.html`.

## Important

Do not commit passwords, service-role keys, private API keys, or other secrets. The Supabase browser key is only safe to expose when database access is protected by appropriate Row Level Security policies.

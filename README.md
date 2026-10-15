# NEAO CHAT
Free room-code chat website for GitHub Pages using Supabase anonymous auth and Realtime.

## Configure Supabase (required before live messaging)
1. Create a free project at https://supabase.com.
2. In Authentication settings, enable Anonymous Sign-Ins.
3. Open SQL Editor, paste and run all of `supabase.sql`.
4. In Project Settings > API, copy the Project URL and public/anon key. Never use the service_role/secret key in browser code.
5. Edit `config.js` and replace both placeholder strings with those values.

## Publish with GitHub Pages
1. Upload `index.html`, `style.css`, `app.js`, `config.js`, `supabase.sql`, and `README.md` to the repository root on the `main` branch.
2. Open repository Settings > Pages.
3. Select Deploy from a branch, branch `main`, folder `/(root)`, and save.
4. Wait for deployment. URL format: https://YOUR-USERNAME.github.io/NEAO-CHAT/

## Test
Open the published URL in two devices/browsers. Create a room on one, share the 6-character code, join on the other and send messages.

## Privacy notes
No email/password form is used; Supabase anonymous sessions identify senders. Room codes are bearer access: anyone who has the code can join. This is not end-to-end encrypted. The example policies allow authenticated visitors to read rooms and their messages; production use should add room membership authorization, rate limits, moderation, cleanup/expiry and stricter access policies. Do not share sensitive data.

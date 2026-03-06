# ScriptArc — Frontend

React 19 frontend for ScriptArc, built with Create React App + CRACO, Tailwind CSS, Radix UI.

## Commands

```bash
yarn start        # Dev server on http://localhost:3000
yarn build        # Production build → build/
yarn test         # Run tests
```

## Environment Variables

Create a `.env` file in this directory:

```env
REACT_APP_SUPABASE_URL=https://<project>.supabase.co
REACT_APP_SUPABASE_ANON_KEY=<anon-key>
REACT_APP_B2_URL=https://f003.backblazeb2.com/file/<bucket>
```

## Path Alias

`@/` maps to `src/` — configured in `craco.config.js`.

## Key Pages

| Route | Page | Description |
|---|---|---|
| `/` | Landing | Public marketing page |
| `/login` `/register` | Auth | Email + Google OAuth |
| `/dashboard` | Dashboard | User progress overview |
| `/courses` | Courses | Browse all courses |
| `/courses/:id` | CourseSingle | Course detail + lecture list |
| `/learn/:lessonId` | Learn | Video player + challenge dialogs |
| `/leaderboard` | Leaderboard | Global rankings |
| `/profile` | Profile | Settings, avatar, badges |

## Design System

- Dark mode cyber theme, background `#05050F`
- Fonts: Outfit (headings), Manrope (body), JetBrains Mono (code)
- Colors via CSS custom properties (`hsl(var(--...))`)
- Icons: `lucide-react` only
- Toasts: `sonner`
- Corners: `rounded-md` / `rounded-sm` max
- No gradient text

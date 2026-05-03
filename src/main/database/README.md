# UniTour database scripts

## Fresh local initialization

Run these two files in order:

1. `schema.sql`
2. `init_info.sql`

`schema.sql` creates the `uni_tour` database and all current tables.
`init_info.sql` inserts the current demo dataset: universities, campuses, POIs,
demo users, and sample reviews.

All demo users use the raw password `123456`, stored as BCrypt hashes.

No other SQL files are required for the current project state. Earlier
incremental alter and seed scripts have been merged into these two files and
removed to keep initialization deterministic.

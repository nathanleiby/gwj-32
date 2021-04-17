# Todo List

## Now

## Soon

- add a "Deck" screen
- (BUG) if you lose (or win?), click "go to main menu", and start a new game.. it's borked. need to reset game state.
  - This makes restarting much smoother, so nice to improve!
- automatically deploy latest build to itch  https://hub.docker.com/r/barichello/godot-ci , https://gitlab.com/barichello/godot-ci/
  - https://github.com/marketplace/actions/godot-ci#itchio

## Backlog

- make battle easier to understand
  - show summarized damage in big #
  - show enemy's queue, too
- earn aspects, and apply their powers
- add a screen after defeating each lord of metal, where you acquire their aspect and it explain the power
- add more endgame stats like damage dealt, aspect
- add hover effects to explain cards
- add music and sound effects
- (fun) make acquired aspects glow, for fun / celebrate
- Fix non-ideal UX:  remove need for "refresh" button in econ screen
- abstract out lots of key params into a consts / globals files
- event bus, signals
- think through core game state (Player properties, current level, score, etc)
- controller input
- load game params, cards, etc from CSV/JSON https://youtu.be/MHeMxiDwo4o?t=523

## Need clarity

- rework cards (1-10 damage or armor, vs Q)
- (maybe) alternate player and enemy actions, for clarity on order of operations
- make the enemy also backed by a queue; show the enemy's queue
- Make the battle more exciting
- co-op multiplayer


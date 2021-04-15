# Todo List

## Now

- add ability to heal (bought at shop)

## Actionable

- automatically deploy latest build to itch  https://hub.docker.com/r/barichello/godot-ci , https://gitlab.com/barichello/godot-ci/
- make battle easier to understand
  - show summarized damage in big #
- share it with `#gamedev` discord for feedback v1

## Backlog

- Fix non-ideal UX:  remove need for "refresh" button in econ screen
- abstract out lots of key params into a consts / globals files
- event bus, signals
- think through core game state (Player properties, current level, score, etc)
- controller input
- load game params, cards, etc from CSV/JSON https://youtu.be/MHeMxiDwo4o?t=523
- if you lose (or win?), click "go to main menu", and start a new game.. it's borked. need to reset game state.

## Need clarity

- (maybe) alternate player and enemy actions, for clarity on order of operations
- make the enemy also backed by a queue; show the enemy's queue
- Make the battle more exciting
- co-op multiplayer


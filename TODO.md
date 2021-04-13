Game outline

- add a game over and game victory screen
- add a HUD (coins, health,etc) that persists

Gameplay parameters to explore

- starting HP
- enemies and their stats / attack styles
- cards you can buy (e.g. number of cards in shop)
- shop timer
- how much money you make per round
- add new cards
- add ability to heal (else you gon die fast)
  - healing potion (in deck, single use?)
  - healing dance (in deck, multi use)
- allow selling/trashing cards in deck
- deck max size
- ability to grow your queue
- tick speed (for excitement, mainly)
  - music that aligns with it
- first pass on music and sound fx
- multiplayer interaction (idea: 4 sided table, and you can see your queues aligning)
  - draw connections between them for cool viz
  - put enemy/monster(s) in middle of screen
- game win condition (e.g. complete in 7m, beat levels, etc)
- mechanics that make the queue and autobattling more fun
- side board? quick battle setup based on enemy type?
- Should enemy be a queue as well? or simpler / easier to understand?

Programming stuff

- abstract out lots of key params into a consts / globals files
- event bus, signals
- think through core data model
- controller input
- multiplayer

Deploy

- [ ] automatically deploy latest build to itch  https://hub.docker.com/r/barichello/godot-ci , https://gitlab.com/barichello/godot-ci/


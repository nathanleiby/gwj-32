Design
====

- Create the overall game flow
  - 7 levels of combat + econ
  - after (as) 7th level, a big boss battle
    * idea: boss should mess with your queue somehow .. e.g. "disable" a card, lock a card in a position, etc
  - perhaps Megaman style: 7 dungeons each with a boss + a metal

Game outline

- add a game over and game victory screen
- add a HUD (coins, health,etc) that persists

Gameplay parameters to explore

- pay to heal at shop (or elsewhere)
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



IDEATION

- could each queue slot have a level, and higher level cards only trigger if it's upgraded enough?
  - Or you can specialized, e.g. lock a slot, get a bonus to certain types of cards, etc
    - e.g. bronze queue slot enhances other bronze cards

- Alchemy symbology
  - quick guide (not public domain img):
    - http://lifepurposetattoos.blogspot.com/2014/07/tattoo-quotes-and-alchemical-symbols.html
    - https://www.alamy.com/stock-photo-alchemical-symbols-103997270.html
  - open images
    - https://thenounproject.com/term/alchemy/
    - https://freesvg.org/heptagram


"7 Metals: An Alchemical Quest"
> The most important goals of the alchemists were the conversion of base metals into gold or silver and the creation of the elixir of life (Panacea)

- heptagram or other cool symbol instead of Godot robot in loading screens

- in autochess, each battle is independent and you don't LOSE from just losing one`
  - maybe.. something like x strikes and you're out or a health meter for how badly you lost?
  - nice part of this is that you can see if your deck isn't working well and pivot.
  - this might be more fun in PvP land

- each position in your queue is unlocked with one of the metals
- each position can be "fortified" with one of the metals (for bonus interaction)
- you choose a primary metal for each playthrough, giving you pros/cons

- During the Econ scene.. allow "Pay for Reroll" to allow paying a bit to smooth some RNG
- show max deck size more clearly in UI

- how might player  queues interact? e.g. imagine them scrolling in alignment with each other (and monster queue too!). What would occur if two aligned?

- Might we have an aspect that lets you draw 2 cards per turn, making your queue move faster? How would (or wouldn't) this be helpful?
  - one aspect could let you start with your queue (partially) full
- Alchemist with 2 part battle.. so you _think_ you can defeat him early (after, say, 3 levels) only to realize he has a harder form.

- AWARDS: show total damage per round, total damage in a matchup...
  - track these as fun metrics for when you die .. e.g.
    - max damage dealt in a tick/battle/full game
    - max armor generated in a

- consider alternating ticks with the enemy, so you can see the back and forth more clearly

- give the enemy a deck, so it's clear what they're doing

- add a difficulty multiplier as you progress through ZONE (Gold, Iron, etc).
  - e.g. 1st: 1.0, 2nd: 1.5, 3rd: 2.0, etc...
  - Needs lots of tuning but the idea is that you can choose any order (or perhaps optimize the order!)
  - the aspect you receive from each will affect ease, too..

- consider adding "strength" or "intensity" as a core stat, and it its a multiplier that affects cards.. would make "enemy strength" easier to understand

Feedback

- first battle flew by too fast
- "refresh" doesn't work
- understands econ.
- clarify that trash COSTS 5gp vs gain 5gp
- its freezes at the end of the battle
- i understand now.. i build a deck, and then the deck is automatically played
- consider an explicit "continue" button from battle, vs auto-fade out
  - consider also: shop as overlay on top of battle
- explain all cards
- can only buy 1 at a time?
- "not sure what this is" (defense/armor)
- it looks like i'm done... where did my cards go?
  - did i keep that deck? is it separate
  - IDEA: allow going to "shop" from level select screen, too
- he's seeing enemies with more health
- HP in shop screen could use more clarity
- Labeling the queue, explaining it more
- showing 'locked' queue
- NOT QUITE SURE how the opponent is interacting. do they have a queue?
- it looks like "my turn happens simultaneously with other turn"
  - consider alternating :D

Autobattling:
- Doesn't like that it's hard to tell what happened due to simultaneous resolution (his + enemy combined)
  - visual way to play out your actions (e.g. resolve each card)
  - also explain the enemies actions :D
- jumping right into first battle was confusing
- after final battle in a segment, there's NO SHOP. ay!

QOL ideas:
- have a way for player to see what's in their deck outside of combat
  - deck view vs shop view?

## Playing cards as inspiration?
For usability, what about cards as base model. e.g. instead of "Attack 1", it could instead be a "1 of swords" (playing card, change icon to a sword) to indicate it does 1 damage.

https://game-icons.net/tags/board.html

For the Q to work with this, maybe it just can activate again all the cards in your queue of that type.
So by default each sword card activates 1x, but if you play a Q of swords they'll trigger 2x. Hence it's a balancing act between damage cards and multiplier (Q) cards.

## Aspect Powers

- mercury: draw +1 card per turn
- lead: start with your queue half filled (rounded up)
- iron: all attacks do +1 damage
- tin: all defend does +1 shield
- copper: heal 5 damage at the end of each round
- gold: gain +1 gold per encounter
- silver: max deck size +4
  - without this aspect capped at X cards (10?)
- start battle with X armor
- trash 3 cards for free
  - perhas harder to implement 1 off "event" vs passive power

## Fusing / Upgrading
- allow fusing three of same cards to get the card but leveled up +1

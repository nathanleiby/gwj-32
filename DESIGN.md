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
  - how does this help?
  - "1000 tiny cuts" .. do 1 damage per card drawn?
- lead: start with your queue half filled (rounded up)
- iron: all attacks do +1 damage
- tin: all defend does +1 shield
- copper: heal 5 at end of battle
  - variant.. heal 10% health whenever you shuffle the deck
- gold: gain +1 gold per encounter
  - enemies have better than average cards, since they're rich?
- silver: start battle with 10 armor
  - without this aspect capped at X cards (10?)
  - queue size +X?
  - enemies hard large queue and large  deck?
- start battle with X armor
- trash 3 cards for free
  - perhas harder to implement 1 off "event" vs passive power

IDEA: enemies in that zone should have the apsect

## Fusing / Upgrading
- allow fusing three of same cards to get the card but leveled up +1
- what if there were a "A" (alchemy) card, that fused two cards?


## Economy

"You'd rather buy than upgrade"

Pay 2x deck card's value to upgrade it.
Pay a shop card's face value to buy it.

"Cleaning up your deck is possible, but costly"

cost to trash goes up 5gp per card
(or: Cost to trash is 5gp * current zone)

"Q card is priced appropriately"

1/50 drop chance in shop.

"Card drops are randomized, but always decently good"

minimum card value is the current zone.
range of card values is up to (current zone + 3)
i.e. it starts with 1-3 and by the end is 7-9


50% chance of current level (L)
30% chance of next level (L+1)
15% chance of next level (L+1)
5% chance of Q card

"You can pay to re-roll the shop, lessening impact of RNG"


## Braindump from Peter (Apr 27, 2021)

```
current
  attack
  defense

  goal:
    * increase queue size
    * improve expected value of attack and shield
    * have enough cards in deck to fill up queue - extra cards aren't valuable

possible improvements:
  theme: reward smaller queue sizes
    idea: rampage
      increase in damage every time it has been played
    idea: exclusion
      decrease in damage for every other card in queue (or other cards of particular type)
    idea: slot amplifier
      improve effects of card when in the X slot of queue
  theme: more levers in deck besides attack and shield
    idea: environment
      change effect of cards when environment in play
    idea: super
      can only have 1 super inside the queue -- additional supers have no effect
    idea: sets
      does nothing unless the entire set is present in the queue
      perhaps some bonus if partial set
      causes a superpower if full set and nothing else in the queue (if sets have variable sizes => player aims for different queue sizes to allow set's superpower)
    idea: expendable cards
      single use within battle. can be allowed to be more powerful at the expense of longevity
    idea: charged cards
      more damage the longer it stays in the queue. needs to be triggered by another card or only triggered at the end of the queue
    idea: status effects
      disarm - next enemy attack whiffs
      weaken - % less damage
      strengthen - % more damage
      exposed - % less shield when shield applied
      slow - queue tick speed decreases
      haste - queue tick speed increases
      queue/card lock - queue/card doesn't move
      obstruct - block queue slot
      marked - increase +x (flat) damage on every hit
    idea: other forms of survival
      defense: damage reduction from every attack
      decoy: while in queue, absorbs X attacks up to Y damage
      healing: increase HP
    idea: ability modifiers
      while in queue, modifies cooldown or other effects of abilities
    idea: deck modifiers
      damage based on deck size
    idea: queue placement modifiers
      move card in front behind this card in the card

  theme: more mechanics
    idea: variable queue tick speed
      enemies, character choices, or cards can move through the queue at different speeds
    idea: active abilities
      * Reserve a card. This reserved card does not automatically enter the queue, but you may instead place the card at the beginning of the queue. When it reaches the end of the queue, it goes back into your reserve instead of the discard.
      * Instant status effect application (take your choice)
      * Reverse your queue. Your queue now moves in reverse and you will draw from your discard instead of your deck
      * Big damage to enemy
      * Small, ramping damage to enemy -- increases with every use
      * Body swap. Temporarily swap decks with enemy
      * Tactical surprise. You may remove a card from your queue and add it to a side queue of the same size as your current queue. When this side queue is full (or after X number of queue ticks), it will replace your current queue.
    idea: more deck control
      * e.g. when drawn, discard this and replace with the next Attack card in your deck
      * e.g. when drawn, gain an exile potion (exile potion is an active ability that lets you click to exile a card until end of battle), then exile this card.
```

## Apr 29 discussion

top 3 experiments:
1. active abilities;
2. sets
3. incentives to small queue size

## May 5

**Idea: Charging up cards.**

What if all cards start as white, and during combat they get enhanced. So the goal of your deck is to cause combos that enhnace all of your cards mid-battle and super-charge them. This could lead to cool color changes and card interactions to keep battle exciting.

An active power might involve *charging up* so of your cards, to help bootstrap that process.

- enhancing
- leveling
- focusing
- charging

Alternately, you mmight be able to buy cards at various levels, or enhance a card's base level, thus requiring less charging up in combat before hitting max power.


**Idea: Heat Level (or Fuel)**

Have a global 'heat level' (naming a la Hades, but meaning different) that shows how much heat you've accumulated

Maybe this could be a mana/fuel that you must spend to cast things, as well.

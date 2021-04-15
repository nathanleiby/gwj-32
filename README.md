# gwj-32
Godot Wild Jam 32 (codename: 7 Metals)

Most recent build is playable here: https://nathanleiby.github.io/gwj-32/

## Story

The Alchemist is said to hold an elixir, which promises an eternal life.
Defeat the 7 Lords of Metal, and use their powers to help you tackle the Alchemist!

## How to play

Build a deck and use it to combat each Lord of Metal.
As you defeat the Lords, you will gain their metal's aspect, giving your further powers.
When you're ready, fight against the Alchemist and take the Elixir of Life!

### How combat works

You and the opponent have hit points.
The goal of a combat is to drive your opponent's hit points to zero.
By winning a combat, you'll gain rewards like gold.

The player table

- Deck - all the cards you own
- Queue - cards currently in play
- Discard - where cards go after they exit your queue

Each turn, you draw 1 card, add it to your queue.
If your queue is full, the oldest card is moved to your discard.
All cards in your queue will then activate.
For example, if you have 2 "Attack 1" cards and 1 "Defend 1" card, you'll then do 2 damage and add 1 armor.

Having a larger queue means you can trigger more cards in a given turn, making you more powerful!
Various cards have other benefits. For example, a "Queue Blade" does 1 damage for each Attack card in your queue.

### Bonuses and Status effects

- Armor - armor takes damage first, before your hit points

### Between Combats (Economy)

Between combats, you'll have a chance to visit the shop, where you can upgrade your deck.

At the shop you can do things like:
- buy new cards
- increase the size of your queue
- increase the max size of your deck
- trash cards in your deck


## General

- make a package of "godot utils",
  - simple data structure like a queue, pqueue, etc
  - 2d grid for rectangular, tile based games
  - hexagonal grid
  - etc
- try writing some unit tests (e.g. for core game, similar to Letterjam tests)
  - https://github.com/bitwes/Gut
- make F2 rename work in gdscript in vscode
- right now, autoformatting wipes out comments within dicts in Godot. Fix plz.
```gdscript
const ZONE_TO_COLOR = {
	# TEST -- this gets removed
	'copper': Color.green,
	'iron': Color.darkred,
	'mercury': Color.brown,
	'silver': Color.silver,
}
```


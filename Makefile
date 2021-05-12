.PHONY := tests

# run unit tests
gut:
	godot --path $PWD -s addons/gut/gut_cmdln.gd -gexit -gdir=`pwd`/test/unit/

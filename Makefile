.PHONY := tests

# run unit tests
gut:
	godot -d -s --path $(PWD) addons/gut/gut_cmdln.gd -gdir=res://tests -ginclude_subdirs -gexit

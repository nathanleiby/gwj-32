UI events may *stop* propagation when passing through some node types. To work around this, you need to specifically configure "pass" or "ignore" for the event to continue, rather than "stop".

- https://godotengine.org/qa/17299/problem-mouse_enter-mouse_exit-signals-overlying-texture
- https://docs.godotengine.org/en/3.3/tutorials/inputs/inputevent.html

In my specific case, this was causing a "mouse entered" event not to reach my `Card`, because it was a child of one or more UI types that swallowed the event by having mouse "stop" configured.


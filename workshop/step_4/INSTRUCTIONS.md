# Step 4: View

During this step we are going though the techniques that can be used to consume a specific **State** and render the related **UI**.

In particular we are seeing the:
- `BlocProvider`: Creates the bloc and inject it within the child widget and the subtree.
- `BlocBuilder`: Provides `context` and `state`, allows to build a the widget we need.


We are going to replace the `lib/pokedex/view/pokedex_page.dart` content with the content of this file, and then discuss it.
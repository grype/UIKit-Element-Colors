# UIKit-Element-Colors
UI Element Colors visualized

<img width="50%" src="https://github.com/grype/UIKit-Element-Colors/blob/master/images/light_mode.png"><img width="50%" src="https://github.com/grype/UIKit-Element-Colors/blob/master/images/dark_mode.png">

## WTF?

Two general types of colors are distinguished - fills and text. Each section in the table view is marked whether it is a fill color (▧) or a text color (𝑻).

Cells list various element colors (systemBackground, label, etc). Names and rgb values are listed, as well as a swatch of the opaque version of the color on the right side of the cell. The table view paints a pattern in background, so as to distinguish transluscent colors.

Fill color cells:
* element color used as cell background, including alpha
* text is colored to stand out - it doesn't represent the element's color

Text color cells:
* element color is used for text color
* systemBackground is used for cell background - it doesn't represent element's color

If you can't read the name of the element - select a cell, as that will change its background color...

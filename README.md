# serafina

*An R package for fine color schemes*

This package under construction will use the LAB and LUV color schemes to create visually pleasing and perceptually evenly-space color palettes.  The idea is, given a collection of colors, the included functions will:

1. Find orthogonal axes in LAB space that are as close to the specified colors as possible. Gradients along these axes can then be used as sequential palettes
2. Find "orthogonal" axes in LUV space that can be used as divergent palettes
3. Return palettes and functions for these colors, akin to functions `colorRamp`, and `colorRampPalette`
4. Contain a collection of pre-specified color palettes that are nice, akin to functions like `rainbow`
5. Return palettes of contrasting colors based on the orthogonal axes in LAB or LUV space
5. Contain a function to quantitatively map a variable onto a color gradient (currently implemented in [*socorro*](https://github.com/ajrominger/socorro))

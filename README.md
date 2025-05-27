# Android System Bar Control
A plugin for Godot to customize android's system bars (status and navigation bars).

## Current features
* Make the system bars transparent and render the UI bellow them.
* Toggle dark/light mode for status bar (navigation bar changes dynamically based on what's bellow it)

## How to use
After adding the addon to your project and enabling it you can:
### Enable transparency:
```AndroidSystemBarControl.toggle_system_bars_transparency(true, true) # in dark mode (white icons)```
```AndroidSystemBarControl.toggle_system_bars_transparency(true, false) # in light mode (black icons)```

### Disable transparency
```AndroidSystemBarControl.toggle_system_bars_transparency(false, true) # in dark mode (white icons)```
```AndroidSystemBarControl.toggle_system_bars_transparency(false, false) # in light mode (black icons)```

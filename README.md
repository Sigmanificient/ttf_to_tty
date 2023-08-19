# TTF to TTY

![showcase](showcase.png)

*Apl Mono font converted by this script, with a small font size*

## How to run

If you dont have `nix`, you can install it [here](https://nixos.org/download.html).
This is the only dependency required, as other dependencies will be managed by Nix.

```sh
nix run github:Sigmanificient/ttf_to_tty [font.ttf] [size] [dpi]
```
> Or, wihtin the repo `nix run . [font.ttf] [size] [dpi]`

You'll need to adjust the `size` & `dpi` parameter to get the best of your font.
Good result can be achieve within the 10-18 point size with 80-160 dpi.

> **Warning**
> You may have a lot of warning due to missing glyphs.

> **Note**
> The script will create 2 font files, but only the `.psf` one will be useful to you.

## Set your font

Use the following command to set the font on the tty.

```sh
setfont [font.psf]
```

You can see all the characters of your newly created font using `showconsolefont`.
If you need to reset your font back to the default simply type `setfont` without additional arguments.

> **Note**
> You can use `-d` to double the font size.

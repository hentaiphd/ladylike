Ladylike
========

Ladylike is a game about a little girl and her mother. It was written by Nina
Freeman. Nina Freeman and Emmett Butler programmed it. Deckman Coss made the
sounds. Winnie Song drew the art.

The first version of Ladylike was made in a weekend for the Ludum Dare game
jam in August 2013. Later, the game was polished and updated for submission to
the [IGF Student Showcase](http://igf.com/2014/01/2014_independent_games_festiva_2.html),
in which it received an honorable mention.

Play It
-------

You can experience Ladylike for yourself at [Emmett's website](http://emmettbutler.com/games/ladylike.html)
or [Nina's website](http://ninasays.so/ladylike/)

Compile It
----------

Compiling and running Ladylike yourself requires the [Flex SDK](http://www.adobe.com/devnet/flex/flex-sdk-download.html),
in particular the `mxmlc` compiler binary. Once you have installed mxmlc, you
can compile the code with

    mxmlc src/ludumdare.as -include-libraries=lib/as3corelib.swc -o ladylike.swf

This creates the flash executable `ladylike.swf`.

As you can see from the above command, Ladylike uses the [AS3 core library](https://github.com/mikechambers/as3corelib),
which is distributed with this code.

License
-------

![](http://www.gnu.org/graphics/lgplv3-147x51.png)
![](http://i.creativecommons.org/l/by-nc-nd/4.0/88x31.png)

Ladylike's code (the `src` directory) is free software, and is released under the
[LGPL version 3](http://www.gnu.org/licenses/lgpl.html). See the file `src/COPYING`
for the text of the license.

Ladylike's `assets` directory, which includes images, audio, and story files,
is released under a [Creative Commons Attribution-NonCommercial-NoDerivatives 4.0
International License](http://creativecommons.org/licenses/by-nc-nd/4.0/).

    This file is part of Ladylike's source.

    Ladylike's source is free software: you can redistribute it and/or modify
    it under the terms of the GNU Lesser General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Ladylike's source is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public License
    along with Ladylike's source. If not, see <http://www.gnu.org/licenses/>.

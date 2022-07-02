 

template=heaps-ios
game=game
iOS:ios
ios:
	haxe -hl ../$(template)/out/main.c compile.hxml
	haxe -hl hxd.fmt.pak.Build.hl -lib heaps -main hxd.fmt.pak.Build
	hl hxd.fmt.pak.Build.hl -out ../$(template)/out/res -res Assets

hl:
	haxe --hl $(game).hl compile.hxml

test:

	haxe --hl $(game).hl compile.hxml && hl $(game).hl

	
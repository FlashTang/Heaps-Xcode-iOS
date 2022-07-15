 

ios_des=../heaps-ios/out
android_des=../heaps-android/app/src/main/cpp/out
game=game
iOS:ios
ios:
	haxe -hl $(ios_des)/main.c ./hxml/compile-ios.hxml ./hxml/base.hxml
	haxe -hl hxd.fmt.pak.Build.hl -lib heaps -main hxd.fmt.pak.Build
	hl hxd.fmt.pak.Build.hl -out $(ios_des)/res -res Assets

hl:
	haxe --hl ../out/hl/$(game).hl ./hxml/compile-hl.hxml ./hxml/base.hxml

test:
	$(shell [ ! -d "../out" ] && mkdir ../out)
	$(shell [ ! -d "../out/hl" ] && mkdir ../out/hl)
	$(shell mkdir ../.temp)
	$(shell [ ! -f "../out/hl/mac_native.hdll" ] && arch -x86_64 g++ -o ../.temp/nativemac.o -c ../native/native_mac.mm)
	$(shell [ ! -f "../out/hl/mac_native.hdll" ] && arch -x86_64 g++ -shared ../.temp/nativemac.o -o ../out/hl/mac_native.hdll -framework Cocoa)
	rm -d -r ../.temp 
	make hl && cd ../out/hl && hl $(game).hl

Android:android
android:
	haxe -hl $(android_des)/main.c ./hxml/compile-android.hxml ./hxml/base.hxml
	haxe -hl hxd.fmt.pak.Build.hl -lib heaps -main hxd.fmt.pak.Build
	hl hxd.fmt.pak.Build.hl -out $(android_des)/res -res Assets

html5:
	haxe ./hxml/compile-js.hxml

All:all
all:
	make ios && make android && make html5 && make hl
	
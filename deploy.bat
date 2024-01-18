@echo off
Rem replace MyGame by your game name project.
set GAME_NAME=MyGame
set GAME_TITLE="My Awesome Game"

Rem script to zip the source file in game folder and create the exe file.
del /Q deploy

mkdir deploy
mkdir deploy\\sources
mkdir deploy\\sources\\assets
mkdir deploy\\sources\\assets\\audio\\
mkdir deploy\\sources\\assets\\fonts\\
mkdir deploy\\sources\\assets\\sprites\\
mkdir deploy\\sources\\assets\\maps\\
mkdir deploy\\sources\\sti\\
mkdir deploy\\sources\\sti\\sti
mkdir deploy\\sources\\sti\\sti\\plugins
mkdir deploy\\sources\\peachy\\
mkdir deploy\\sources\\peachy\\lib
mkdir deploy\\sources\\letsjam\\
mkdir deploy\\sources\\bump\\

copy /Y game\\assets\\audio\\* deploy\\sources\\assets\\audio\\
copy /Y game\\assets\\sprites\\* deploy\\sources\\assets\\sprites\\
copy /Y game\\assets\\maps\\*.lua deploy\\sources\\assets\\maps\\
copy /Y game\\assets\\fonts\\* deploy\\sources\\assets\\fonts\\

copy /Y game\\*.lua deploy\\sources\\
copy /Y game\\sti\\sti\\* deploy\\sources\\sti\\sti
copy /Y game\\sti\\sti\\plugins\\* deploy\\sources\\sti\\sti\\plugins
copy /Y game\\peachy\\*.lua deploy\\sources\\peachy\\
copy /Y game\\peachy\\lib\\*.lua deploy\\sources\\peachy\\lib
copy /Y game\\letsjam\\*.lua deploy\\sources\\letsjam\\
copy /Y game\\bump\\*.lua deploy\\sources\\bump\\

cd deploy//sources//
tar -a -c -f  "%GAME_NAME%.zip" *.lua assets/* peachy/* sti/* letsjam/* bump/*

move /Y "%GAME_NAME%.zip" "..//%GAME_NAME%.love"
cd ..

copy /b ..\\love2d\\love.exe+"%GAME_NAME%.love" "%GAME_NAME%.exe"

copy /b ..\\love2d\\*.dll .

tar -a -c -f  "../%GAME_NAME%-source.zip" sources/*
tar -a -c -f  "../%GAME_NAME%-game.zip" *.dll *.exe

cd ..

Rem web deployment
mkdir deploy\\web
love.js.cmd deploy\\%GAME_NAME%.love deploy\\web -c -m 124804435 -t "%GAME_TITLE%"

copy /y index.html deploy\\web\\index.html

cd deploy\\web\\
tar -a -c -f  "..\\..\\game.zip" *

cd ../..
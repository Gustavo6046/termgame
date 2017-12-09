@echo off

ECHO Compiling...
CALL COFFEE -cb . || (
    ECHO Error trying to compile!
    EXIT /b
)
ECHO Beautifying...
FOR /r "./src/" %%f IN (*.js) DO CALL beautify.bat "%%f"

ECHO Done.
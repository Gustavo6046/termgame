@echo off
ECHO %1
CALL js-beautify %1 > %~dpn1.beauty.js
DEL %1
REN "%~dpn1.beauty.js" %~nx1
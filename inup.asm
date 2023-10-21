global _start

section .text
_start:
; Register the window class.
mov eax, offset windowClass
mov edx, offset windowProc
push 0
push 0
push CS_OWNDC | CS_HREDRAW | CS_VREDRAW
mov ecx, offset windowClass
call RegisterClassExA

; Create the window.
mov eax, 0
mov ecx, offset windowClass
mov edx, "Window Popup"
push 0
push 0
push 200
push 200
push WS_OVERLAPPEDWINDOW
mov ebx, 0
push 0
call CreateWindowExA

; Show the window.
mov eax, SW_SHOW
push 0
push offset windowHandle
call ShowWindow

; Wait for the window to close.
mov eax, WM_QUIT
mov ebx, 0
push ebx
push eax
call SendMessage

; Exit the program.
mov eax, 1
mov ebx, 0
int 0x80

section .data
windowClass:
db 18
dw CS_OWNDC | CS_HREDRAW | CS_VREDRAW
dd addr windowProc
dd 0
dd 0
dd 0
dd 0
dd 0
dd 0
dd 0
dd 0
dd 0
dd 0

windowProc:
push ebp
mov ebp, esp
mov eax, [esp + 8]
cmp eax, WM_DESTROY
je exit
mov eax, 0
pop ebp
ret

exit:
mov eax, 1
mov ebx, 0
int 0x80

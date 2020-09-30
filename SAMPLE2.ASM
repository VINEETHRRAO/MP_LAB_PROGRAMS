.model small
.data
a dw 16
b dw 12
c dw ?
.code
mov ax,@data
mov ds,ax

mov ax,a
add ax,b
mov c,ax
mov ah,4ch
int 21h
end


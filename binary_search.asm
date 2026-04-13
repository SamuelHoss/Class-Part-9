INCLUDE IrINCLUDE Irvine32.inc

.data

arr DWORD 5, 12, 18, 25, 33, 41, 56, 72, 89, 100

target DWORD ?
low    DWORD ?
high   DWORD ?
mid    DWORD ?
result DWORD ?
i      DWORD ?

titleStr BYTE "=== Binary Search (ASM version) ===", 0
arrayStr BYTE "Sorted array: ", 0
searchStr BYTE "Searching for ", 0
foundStr BYTE "Found ", 0
atIndexStr BYTE " at index ", 0
notFoundStr BYTE " was NOT found in the array.", 0dh, 0ah, 0

.code

binary_search PROC

mov low, 0
mov high, 9
mov result, -1

search_loop_start:

mov eax, low
cmp eax, high
jg search_done

mov eax, low
add eax, high
shr eax, 1
mov mid, eax

mov esi, mid
mov eax, arr[esi * 4]

cmp eax, target
je found_it

mov ebx, target
cmp ebx, eax
jl search_left

jmp search_right

found_it :
mov result, mid
jmp search_done

search_left :
mov eax, mid
sub eax, 1
mov high, eax
jmp search_loop_start

search_right :
mov eax, mid
add eax, 1
mov low, eax
jmp search_loop_start

search_done :
ret

binary_search ENDP


main PROC

mov edx, OFFSET titleStr
call WriteString
call Crlf
call Crlf

mov edx, OFFSET arrayStr
call WriteString

mov i, 0

print_loop:
mov eax, i
cmp eax, 10
jge print_done

mov esi, i
mov eax, arr[esi * 4]
call WriteInt

mov al, ' '
call WriteChar

inc i
jmp print_loop

print_done :
call Crlf
call Crlf

mov target, 56
call do_search

mov target, 42
call do_search

mov target, 5
call do_search

mov target, 100
call do_search

exit
main ENDP


do_search PROC

mov edx, OFFSET searchStr
call WriteString

mov eax, target
call WriteInt
call Crlf

call binary_search

mov eax, result
cmp eax, -1
je not_found

mov edx, OFFSET foundStr
call WriteString

mov eax, target
call WriteInt

mov edx, OFFSET atIndexStr
call WriteString

mov eax, result
call WriteInt
call Crlf
call Crlf
ret

not_found :
mov eax, target
call WriteInt

mov edx, OFFSET notFoundStr
call WriteString
call Crlf
ret

do_search ENDP

END main

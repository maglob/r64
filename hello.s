        processor 6502        
        org $1000

screen = $400                   ; Start of screen memory
color = $d800                   ; Start of color RAM for screen
        
        lda #$17                ; Activate lower case char 
        sta $d018               ;   images
        jsr $e544               ; Clear screen
        lda #$00               
        sta $d020               ; Border color to black
        sta $d021               ; Background color to black
        ldy #00                 ; Zero the index
loop    lda data,y              ; Fetch next letter from data[y]
        beq waitkey             ; Jump to end if zero
        cmp #$60                ; ASCII to screen codes 
        bmi skip
        and #$1F
skip    sta screen+$1f0,y       ; Store letter into screen 
        lda #$01                ; White color code
        sta color+$1f0,y        ;   into color ram at letter pos
        iny                     ; Increment index
        jmp loop                ; Loop next letter
waitkey jsr $ffe4               ; Query key GETIN
        beq waitkey
        rts

data:   
        .byte   "Reaktor", 0

        

#make_bin#

#LOAD_SEGMENT=FFFFh#
#LOAD_OFFSET=0000h#

#CS=0000h#
#IP=0000h#

#DS=0000h#
#ES=0000h#

#SS=0000h#
#SP=FFFEh#

#AX=0000h#
#BX=0000h#
#CX=0000h#
#DX=0000h#
#SI=0000h#
#DI=0000h#
#BP=0000h#
         
         
         
; add your code here
         

         jmp     st2 
         nop
         dw      0000
         dw      0000
         dw      ad_isr
         dw      0000
		 
		 db     1012 dup(0)
;main program
          
    
            
st2:                 
          cli 
; intialize ds, es,ss to start of RAM
          mov       ax,0200h
          mov       ds,ax
          mov       es,ax
          mov       ss,ax
          mov       sp,0FFFEH 
          
;intialise porta  as input & b& c as output
          mov       al,91h
		  out 		06h,al
		  
		  mov		al,80h
		  out		0eh,al

          mov al, 17
          mov [02], al

          mov		al,00001110b
		  out		06h,al
		  
		  mov       al, 91h
		  out 06h, al
		  
;select ch0
st1:      mov al, [02]       
		  out 2, al 

;give ale  
          mov       al,00100000b
		  out       04h,al 
		 
;give soc  
          mov		al,00110000b
		  out		04h,al 
		  
		  nop
		  nop
		  nop
		  nop
;make soc 0 
		  mov       al,00010000b
		  out       04h,al  
;make ale 0
		  
		  mov       al,00000000b
		  out       04h,al   
                    
          mov [04], 0
aa:       cmp [04], 0
          jz aa 
   
		  
		  mov cx, 2000
xx1:      nop
          loop xx1    

		  mov al, [02]              
          add al, 17
          mov [02], al

          
          cmp [02], 200
          jge st1

inf:      jmp inf
                    
ad_isr:   mov		al,01000000b
		  out		04h,al
		  in        al,00h

		  mov [04], 1 
		  
		  mov [06], al
		  
          mov cl, 255
          sub cl, al
          inc cl
          mov al, 33
          mov ah, 0
          mul cl
          mov bx, ax


          
          mov al, [02]
          mov ah, 0
          
		  
		  mov cx, 0
		  mov dx, 0

		
		  
xxxx:    add cx, 1
         add dx, ax
         cmp dx, bx
         jle xxxx       
		 
		 dec cx

		 mov ax, cx
		 mov cx, 10
		 mul cx
		      
		 mov [08], ax     

        
		 cmp ax, 256
		 jle xx2
		 mov ax, 255
    
         
xx2:      mov al, al
          mov cl, al
		  
		  mov ah,0
		  mov bl, 10
		  div bl 
		  mov cl, al 
		  mov al, ah
		  out 0ch, al
		        
          mov al, cl
          
          mov ah,0
		  mov bl, 10
		  div bl 
		  mov cl, al 
		  mov al, ah
		  out 0ah, al 
          

          mov al, cl 
          
          mov ah,0
		  mov bl, 10
		  div bl 
		  mov cl, al 
		  mov al, ah
		  out 08h, al
         mov ax, 20
      	 cmp [08], ax
         jg rett
		   
buzz:     mov		al,00001111b
		  out		06h,al
		  
		  mov       al, 91h
		  out 06h, al
		  
		  in al, 04h
		  and al, 01h
		  jz buzz
          mov		al,00001110b
		  out		06h,al
		  
		  mov       al, 91h
		  out 06h, al
		  
rett:		   
          iret
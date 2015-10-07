.data
# leer archivo hasta q encuentre fin de texto, agregarlo a stack, despues trabajar con el stack
msj: .asciiz "Ingrese el nombre del archivo: "
archivo: .byte 0:50
salida: .asciiz "NOMBRE ARCHIVO ORDENADO.txt"
buffer: .byte 0:100 #buffer de 100 bytes o 100 chars
a: .asciiz "a.txt"
.text

# Guardamos la dir del buffer que será utilizada más adelante
la $s2,buffer

# Se solicita el nombre del archivo
la $a0,msj
li $v0,4
syscall

# Se lee el nombre del I/O y se guarda en archivo
la $a0,archivo
li $a1,50
li $v0,8
#syscall

# Se cambia '\n' por '\0' al final
#la $t0,archivo
#while:
#lb $t1,0($t0)
#beq $t1,10,cambio
#addi $t0,$t0,1
#j while
#cambio:
#sb $zero,0($t0)

# Se abre el archivo
#la $a0, archivo
la $a0,a
addi $a1, $zero, 0  # flags: 0 leer, 1 escribir, 9 append
addi $a2, $zero, 0  # el modo no importa, es ignorado por MARS
addi $v0, $zero, 13 # la syscall 13 abre el archivo
syscall
add $t0, $zero, $v0 # copiamos el descriptor de archivo

# Se guarda el contentido en el buffer
add $a0, $zero, $t0
la $a1, buffer
addi $a2, $zero, 100
addi $v0, $zero, 14 # leemos desde el archivo
syscall

# Cerramos el archivo
li $v0,16
syscall

# Traspasamos los n° del buffer al stack
la $a0,buffer # $a0 contiente la dir del buffer
addi $t0,$zero,0 # inicializamos $t0 en 0 (contador)
addi $a2,$zero,0 # inicializamos $a2 en 0 (sumatoria)
addi $s1,$sp,0 # copiamos la dir del $sp
avanzar:
addi $a3,$a0,0 # Copiamos la direccion en la que se va leyendo el buffer para manipularla en otro
addi $a1,$zero,1 # inicializamos $a1 en 1 
lb $t1,0($a0) # cargamos el contenido del buffer en $t1
beq $t1,13,otro # a1 sera los multiplos de 10 
beqz $t1,otro # Si llegamos al final del buffer sigue con otro
addi $t0,$t0,1 # $t0 contador de digitos por nº
addi $a0,$a0,1 # $a0 se aumenta en 1 byte
j avanzar

otro: # Utilizamos $a2 como la suma de unidades, decenas, etc..
subi $a3,$a3,1 # Restamos uno para movernos por los digitos del nº
lb $t2,0($a3) # Cargamos el digito
subi $t2,$t2,48 # Restamos 48 al ASCIIZ para que nos quede el nº correcto
mul $t2,$t2,$a1 # Multiplicamos por un multiplo de 10 segun sea la posicion del digito
add $a2,$a2,$t2 # Lo agregamos a la sumatoria
subi $t0,$t0,1 # Restamos 1 a los digitos por revisar
beqz $t0,agregar # Si no quedan digitos por revisar se agrega el nº al stack
mul $a1,$a1,10 # Multiplicamos por 10 segun la posicion del digito que se esta revisando
j otro

agregar:
addi $s0,$s0,1 # Cuenta de los nº agregados
addi $s1,$s1,-4 # Se selecciona espacio en el stack
sw $a2,0($s1) # Se guarda el nº en el stack
addi $a2,$zero,0 # inicializamos $a2 en 0 (sumatoria)
addi $t0,$zero,0 # inicializamos $t0 en 0 (contador)a.txt
addi $a0,$a0,2 # $a0 se aumenta en 2 bytes para saltarse el '\n'
bne $t1,$zero,avanzar # Si llegamos al final del buffer sigue con el codigo

# Algoritmo iterativo "Bubble sort"
addi $t3,$t3,1 # $t3 nos indica si se realizo alguna permutacion, sino se realizo ninguna en una pasada toma el valor de 0
alg1: # Pasadas
beqz $t3,final # Cuando no se realizo ningun cambio ya esta ordenado y se pasa a la fase final
addi $t3,$zero,0 # Se incializa en 0 el nº de cambios en cada nueva pasada
subi $s1,$sp,0 # Se copia la direccion del sp
subi $t2,$s0,1 # t2 es el nº de comparaciones por pasada
alg2: # Se recorre el stack haciendo comparaciones
beqz $t2,alg1 # Se verifica si ya se termino de comparar
subi $s1,$s1,4 # Se corre el puntero al stack
subi $t2,$t2,1 # Se resta 1 al nº de comparaciones restantes
lw $t0,0($s1) # Se carga el 1er nº en t0
lw $t1,-4($s1) # Se carga el 2do nº en t1
bgt $t0,$t1,cambiar # Cuando se encuentra q el 1er nº es mayor q el 2do se realiza un intercambio
j alg2 
cambiar: # Cambia los nº de posición
sw $t1,0($s1)
sw $t0,-4($s1)
addi $t3,$t3,1 # Aumenta el nº de cambios hechos en una pasada
j alg2

# Preparamos el buffer 
# $s0 contiene el nº de elementos en el stack
# $sp apunta al inicio del stack
final:
beqz $s0,fin
lw $t0,-4($sp)
subi $s0,$s0,1
li $t3,10
ciclo:
div $t2,$t0,$t3
beqz $t2,escribir
mul $t3,$t3,10
j ciclo
escribir:
div $t3,$t3,10
beqz $t3,sig
div $t2,$t0,$t3
mul $t4,$t2,$t3 # Preparamos resta para quitar el digito 
sub $t0,$t0,$t4
addi $t2,$t2,48
sb $t2,($s2)
addi $s2,$s2,1
j escribir
sig:
li $t4,13
sb $t4,($s2)
addi $s2,$s2,1
li $t4,10
sb $t4,($s2)
addi $s2,$s2,1
subi $sp,$sp,4
j final


fin:
# Añadimos el fin de archivo en el buffer
sb $zero,-2($s2)
# Se abre el archivo
la $a0, salida
addi $a1, $zero, 1  # flags: 0 leer, 1 escribir, 9 append
addi $a2, $zero, 0  # el modo no importa, es ignorado por MARS
addi $v0, $zero, 13 # la syscall 13 abre el archivo
syscall
add $a0, $zero, $v0 # copiamos el descriptor de archivo
la $t0,buffer
addi $a1,$t0,0
addi $a2,$0,100
li $v0,15
syscall
# Cerramos el archivo
li $v0,16
syscall

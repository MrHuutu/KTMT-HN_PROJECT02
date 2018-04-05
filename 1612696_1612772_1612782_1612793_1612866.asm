.data
	#menu
	menu: .asciiz "==================== Menu ====================\n"
	select01: .asciiz "1.	Nhap mang\n"
	select02: .asciiz "2.	Xuat mang\n"
	select03: .asciiz "3.	Liet ke so nguyen to\n"
	select04: .asciiz "4.	Liet ke so hoan thien\n"
	select05: .asciiz "5.	Tinh tong cac so chinh phuong trong mang\n"
	select06: .asciiz "6.	Tinh trung binh cong cac so doi xung trong mang\n"
	select07: .asciiz "7.	Tim gia tri lon nhat trong mang\n"
	select08: .asciiz "8.	Sap xep mang tang dan theo Selection sort\n"
	select09: .asciiz "9.	Sap xep mang giam dan theo Bubble sort\n"
	select10: .asciiz "10.	Thoat\n"
	end: .asciiz "=============================================\n"
	select: .asciiz "Chon: "
	#Cac gia tri cua cac cau lenh
	intOut: .word 1
	stringOut: .word 4
	intInp: .word 5
	stringInp: .word 8
	charOut: .word 11
	exit: .word 10
	#Cac bien dung cho xu ly chuong trinh
	tb1: .asciiz "Nhap so luong phan tu n: "
	tb2: .asciiz "arr["
	tb3: .asciiz "]="
	tb4: .asciiz "Mang can hien thi la: "
	newLine: .asciiz "\n"
	n: .word 0
	arr: .space 40
	choice: .word 0

.text
	.globl main
	
main:
#Xuat menu lua chon
XuatMenu:
	#Xuong dong moi
	lw $v0,stringOut
	la $a0,newLine
	syscall
	#Xuat tieu de
	lw $v0,stringOut
	la $a0,menu
	syscall
	#Xuat selection 01
	la $a0,select01
	syscall
	#Xuat selection 02
	la $a0,select02
	syscall
	#Xuat selection 03
	la $a0,select03
	syscall
	#Xuat selection 04
	la $a0,select04
	syscall
	#Xuat selection 05
	la $a0,select05
	syscall
	#Xuat selection 06
	la $a0,select06
	syscall
	#Xuat selection 07
	la $a0,select07
	syscall
	#Xuat selection 08
	la $a0,select08
	syscall
	#Xuat selection 09
	la $a0,select09
	syscall
	#Xuat selection 10
	la $a0,select10
	syscall
	#Xuat end menu
	la $a0,end
	syscall
	#Xuat ra dong cho nguoi dung chon
	la $a0,select
	syscall
	#Doc lua chon tu nguoi dung
	lw $v0,intInp
	syscall
	sw $v0,choice
		
#Xu ly cac lua chon
	lw $s0,choice
	#Neu choice!=1
	bne $s0,1,checkForSelection02
	#Goi ham
	jal InputArr
	j XuatMenu
	#Neu choice!=2
checkForSelection02:
	bne $s0,2,checkForSelection03
	jal OutputArr
	j XuatMenu
	#Neu choice!=3
checkForSelection03:
	bne $s0,3,checkForSelection04
	#Truyen tham so
	la $a0,arr
	lw $a1,n
	jal PrimeNumberList
	j XuatMenu
	#Neu choice!=4
checkForSelection04:
	bne $s0,4,checkForSelection05
	#Truyen tham so
	la $a0,arr
	lw $a1,n
	jal PerfectNumberList
	j XuatMenu
	#Neu choice!=5
checkForSelection05:
	bne $s0,5,checkForSelection06
	#Truyen tham so
	la $a0,arr
	lw $a1,n
	jal SquareNumberSum
	j XuatMenu
	#Neu choice!=6
checkForSelection06:
	bne $s0,6,checkForSelection07
	#Truyen tham so
	la $a0,arr
	lw $a1,n
	jal SymNumberAVG
	j XuatMenu
	#Neu choice!=7
checkForSelection07:
	bne $s0,7,checkForSelection08
	#Truyen tham so
	la $a0,arr
	lw $a1,n
	jal MaxInArr
	j XuatMenu
	#Neu choice!=8
checkForSelection08:
	bne $s0,8,checkForSelection09
	#Truyen tham so
	la $a0,arr
	lw $a1,n
	jal AscSelectionSort
	j XuatMenu
	#Neu choice!=9
checkForSelection09:
	bne $s0,9,checkForSelection10
	#Truyen tham so
	jal DescBubbleSort
	j XuatMenu
	#Neu choice=10
checkForSelection10:
	j ketthuc

#Ket thuc chuong trinh
ketthuc:
	lw $v0,exit
	la $a0,select10
	syscall
	
#========== Danh sach ham chinh trong chuong trinh ==========
#Ham InputArr
#	Chuc nang: thuc hien nhap du lieu cho mang tu nguoi dung
#	Tham so: mang arr va bien so luong n
#	Tra ve: khong co gia tri tra ve
InputArr:
	#backup
	addi $sp,$sp,-20
	sw $ra,($sp)
	sw $t0,4($sp)
	sw $t1,8($sp)
	sw $t2,12($sp)
	sw $t3,16($sp)
	
	#Xuat thong bao nhap so luong mang (n)
	lw $v0,stringOut
	la $a0,tb1
	syscall
	#Doc va luu gia tri n
	lw $v0,intInp
	syscall
	sw $v0,n #gia tri n
	#Lay gia tri n ra
	lw $t1,n
	#Lay dia chi mang Arr
	la $t0,arr
		
	#Khoi tao vong lap nhap du lieu
	li $t2,0 #Bien chay i
	#Kiem tra lap nhap
	InputArr.CheckLoop:
		slt $t3,$t2,$t1
		beq $t3,1,InputArr.StartLoop
		j InputArr.EndFunction
	InputArr.StartLoop:
		#Xuat ra thong bao nhap cho phan tu thu i
		lw $v0,stringOut
		la $a0,tb2
		syscall
		lw $v0,intOut
		la $a0,($t2)
		syscall
		lw $v0,stringOut
		la $a0,tb3
		syscall
		#Doc gia tri phan tu
		lw $v0,intInp
		syscall
		sw $v0,($t0) #Chuyen gia tri phan tu vao mang
		addi $t0,$t0,4 #tang dia chi mang
		addi $t2,$t2,1 #tang bien chay i
		j InputArr.CheckLoop
	InputArr.EndFunction:
		#Restore lai cac thanh ghi
		lw $ra,($sp)
		lw $t0,4($sp)
		lw $t1,8($sp)
		lw $t2,12($sp)
		lw $t3,16($sp)
		addi $sp,$sp,20
		#Thoat
		jr $ra

#Ham OutputArr
#	Chuc nang: thuc hien Xuat du lieu cho mang ra man hinh
#	Tham so: mang arr va bien so luong n
#	Tra ve: khong co gia tri tra ve
OutputArr:
	#backup
	addi $sp,$sp,-20
	sw $ra,($sp)
	sw $t0,4($sp)
	sw $t1,8($sp)
	sw $t2,12($sp)
	sw $t3,16($sp)
	
	#Lay dia chi mang
	la $t0,arr
	#Lay so phan tu (n)
	lw $t1,n
	#Xuat ra thong bao xuat mang
	lw $v0,stringOut
	la $a0,tb4
	syscall
	#Khoi tao vong lap xuat du lieu
	li $t2,0 #Bien chay i
	#Kiem tra lap nhap
	OutputArr.CheckLoop:
		slt $t3,$t2,$t1
		beq $t3,1,OutputArr.StartLoop
		j OutputArr.EndFunction
	OutputArr.StartLoop:
		#Xuat ra phan tu thu i
		lw $v0,intOut
		lw $a0,($t0)
		syscall
		lw $v0,charOut
		li $a0,32
		syscall
		addi $t0,$t0,4 #tang dia chi mang
		addi $t2,$t2,1 #tang bien chay i
		j OutputArr.CheckLoop
	OutputArr.EndFunction:
		#Restore lai cac thanh ghi
		lw $ra,($sp)
		lw $t0,4($sp)
		lw $t1,8($sp)
		lw $t2,12($sp)
		lw $t3,16($sp)
		addi $sp,$sp,20
		#Thoat
		jr $ra

#Ham PrimeNumberList
#	Chuc nang: Liet ke cac so nguyen to trong mang
#	Tham so: mang arr va bien so luong n
#	Tra ve: khong co gia tri tra ve
PrimeNumberList:

#Ham perfectNumberList
#	Chuc nang: Liet ke cac so hoan thien trong mang
#	Tham so: mang arr va bien so luong n
#	Tra ve: khong co gia tri tra ve
PerfectNumberList:

#Ham SquareNumberSum
#	Chuc nang: Tinh tong cac so chinh phuong trong mang va xuat ra gia tri tong do
#	Tham so: mang arr va bien so luong n
#	Tra ve: khong co gia tri tra ve
SquareNumberSum:

#Ham SymNumberAVG
#	Chuc nang: Tinh trung binh cong cac so doi xung trong mang va in ra gia tri AVG do
#	Tham so: mang arr va bien so luong n
#	Tra ve: khong co gia tri tra ve
SymNumberAVG:

#Ham MaxInArr
#	Chuc nang: Tim so lon nhat mang va xuat ra man hinh
#	Tham so: mang arr va bien so luong n
#	Tra ve: khong co gia tri tra ve
MaxInArr:

#Ham AscSelectionSort
#	Chuc nang: Sap xep mang tang dan theo Selection sort
#	Tham so: mang arr va bien so luong n
#	Tra ve: khong co gia tri tra ve
AscSelectionSort:

#Ham DescBubbleSort
#	Chuc nang: Sap xep mang giam dan theo Bubble sort
#	Tham so: mang arr va bien so luong n
#	Tra ve: khong co gia tri tra ve
DescBubbleSort:
	#backup
	addi $sp,$sp,-32
	sw $ra,($sp)
	sw $t0,4($sp)
	sw $t1,8($sp)
	sw $t2,12($sp)
	sw $t3,16($sp)
	sw $t4,20($sp)
	sw $t5,24($sp)
	sw $t6,28($sp)
	
	#Lay gia tri n
	lw $t1,n
	#Tinh lai gia tri n,m
	subi $t1,$t1,1 #Bien n
	move $t2,$t1 #Bien m
	
	#Khoi tao vong lap ngoai
	li $t3,0 #Bien i
	#Kiem tra dieu kien lap vong lap ngoai
	DescBubbleSort.CheckOutsideLoop:
		slt $t4,$t3,$t2
		beq $t4,1,DescBubbleSort.OutsideLoop
		j DescBubbleSort.EndLoop
	#Bat dau vong lap ngoai
	DescBubbleSort.OutsideLoop:
		#Lay dia chi mang arr
		la $t0,arr
		#Khoi tao vong lap trong
		li $t4,0 #Bien j
		#Kiem tra dieu kien lap vong lap trong
		DescBubbleSort.CheckInsideLoop:
			slt $t5,$t4,$t1
			beq $t5,1,DescBubbleSort.InsideLoop
			j DescBubbleSort.NextOutsideLoop
		#Bat dau vong lap trong
		DescBubbleSort.InsideLoop:
			lw $t5,($t0)
			lw $t6,4($t0)
			slt $t7,$t5,$t6
			beq $t7,1,DescBubbleSort.Swap
		#Tang thong so de toi vong lap tiep theo
		DescBubbleSort.NextInsideLoop:
			#Tang dia chi mang
			addi $t0,$t0,4
			#Tang j
			addi $t4,$t4,1
			j DescBubbleSort.CheckInsideLoop
		#Hoan doi gia tri
		DescBubbleSort.Swap:
			lw $t7,($t0)
			sw $t6,($t0)
			sw $t7,4($t0)

			j DescBubbleSort.NextInsideLoop
	DescBubbleSort.NextOutsideLoop:
		addi $t3,$t3,1
		
		j DescBubbleSort.CheckOutsideLoop
	DescBubbleSort.EndLoop:
		#Restore thanh ghi
		lw $ra,($sp)
		lw $t0,4($sp)
		lw $t1,8($sp)
		lw $t2,12($sp)
		lw $t3,16($sp)
		lw $t4,20($sp)
		lw $t5,24($sp)
		lw $t6,28($sp)
		addi $sp,$sp,32
		#ExitLoop
		jr $ra
				
#========== Danh sach ham  bo tro trong chuong trinh ==========
# Ham
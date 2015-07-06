#####################################################################
#
#                       ATM  ---  Cajero Automatico
#
####################################################################
package require Tclx
keylset DataUser ""
set aux 0
set num ""
set ID ""
proc mainWindow {option} {
   global num
   while {$option != 4} {
      puts "\nPlease insert / Por favor ingrese:\n\n\n\t1- English\n\n\t2- Español\n"
      after 1000
      set num [gets stdin]
      if {$num == 1} {
         puts "\n###################################################\n
         \tPlease insert a value to continue:\n
         \t1- Account Balance\n
         \t2- Make a Deposit\n
         \t3- Cash withdrawal\n
         \n###################################################\n"
      } else {
         puts "\n###################################################\n
         \tPor favor ingrese un valor para continuar:\n
         \t1- Balance de cuenta\n
         \t2- Realizar Deposito\n
         \t3- Realizar Retiro de Dinero\n
         \n###################################################\n"
      }
      after 1000
      set option [gets stdin]
      if {$option != 4} {
         return $option
      }
   }
}
proc authorization {n} {
   global ID
   if {$n == 1} {
      puts "\n#####################################################
      \tPlease Insert your ID:
      \n#####################################################\n"
      set ID [gets stdin]
   } else {
      puts "\n#####################################################
      \tPor favor ingrese su numero de indentificacion:
      \n#####################################################\n"
      set ID [gets stdin]
   }
   return $ID
}
proc DataCreate {ID name last key balance} {
   package require Tclx
   global DataUser aux
   keylset DataUser ID.$aux $ID
   keylset DataUser $ID.key $key
   keylset DataUser $ID.name $name
   keylset DataUser $ID.last $last
   keylset DataUser $ID.balance $balance
   puts $DataUser
   incr aux
}
proc user {ID} {
   global aux DataUser num
   for {set i 0} {$i < $aux} {incr i} {
      if {[keylget DataUser ID.$i] == $ID} {
         set rel YES
         break
      } else {
         set rel NO
      }
   }
   if {$num == 1 && $rel == "NO"} {
      puts "\nPlease verify your ID and restart.\nThank you\n"
   } elseif {$num == 2 && $rel == "NO"} {
      puts "\nPor favor verifique su Identificacion y comienze de nuevo.\nGracias\n"  
   }
   return $rel
}
proc userKey {ID} {
   global DataUser num
   if {$num == 1} {
      puts "\nPlease insert your PIM number:\n"
   } else {
      puts "\nPor favor ingrese su clave PIM:\n"  
   }
   set keyNum [gets stdin]
   if {[keylget DataUser ${ID}.key] == $keyNum} {
      return YES
   } else {
      if {$num == 1} {
         puts "\nPlease verify your PIM and restart.\nThank you.\n"
      } else {
         puts "\nPor favor verifique su clave y comienze de nuevo.\nGracias\n"  
      }
      return NO
   }
}
proc balance {ID} {
   global DataUser
   set balance "ERROR"
   set balance [keylget DataUser ${ID}.balance]
   return $balance
}
proc nameUser {ID} {
   global num DataUser
   set name ""
   set last ""
   set name [keylget DataUser ${ID}.name]
   set last [keylget DataUser ${ID}.last]
   if {$num == 1 && $name != "" && $last != ""} {
      puts "\n\nWelcome $name $last.\n"
   } elseif {$num == 2 && $name != "" && $last != ""} {
      puts "\n\nBienvenido $name $last.\n"
   }
}
proc Deposit {ID} {
   global DataUser num
   if {$num == 1} {
      puts "\nPlease insert the value of the Deposit:\n"
   } else {
      puts "\nPorfavor ingrese el monto del Deposito:\n"  
   }
   set deposit [gets stdin]
   set balance [expr [keylget DataUser ${ID}.balance] + $deposit]
   keylset DataUser $ID.balance $balance
   set new [balance $ID]
   if {$num == 1} {
      puts "\nThe new balance of your account is:\n$new\n"
   } else {
      puts "\nEl nuevo saldo de su cuenta es:\n$new\n"  
   } 
}
proc CashWithdrawal {ID} {
   global DataUser num
   if {$num == 1} {
      puts "\nPlease insert the value of the Cash WithDrawal:\n"
   } else {
      puts "\nPorfavor ingrese el monto del Retiro:\n"  
   }
   set deposit [gets stdin]
   set balance [keylget DataUser ${ID}.balance]
   if {$balance > $deposit} {
      set new_balance [expr [keylget DataUser ${ID}.balance] - $deposit]
      keylset DataUser $ID.balance $new_balance
      set new [balance $ID]
      if {$num == 1} {
         puts "\nThe new balance of your account is:\n$new\n"
      } else {
         puts "\nEl nuevo saldo de su cuenta es:\n$new\n"  
      }
   } else {
      if {$num == 1} {
         puts "\nYou don't have enough money in your balance"
      } else {
         puts "\nSu cuenta no tiene fondos suficientes"  
      }
   }
}
DataCreate 545642464 Juan Perez 0000 50000
DataCreate 464564321 Pedro Pony 1234 15000
DataCreate 546131645 Luis Hernandez 1111 25000
DataCreate 132145646 Mike Douglas 5555 45000
DataCreate 546413146 Jhon Q 1010 5500
proc main {} {
   global num ID
   set z 0
   while {$z != 1} {
      set a [mainWindow 1]
      switch $a {
         "1" {if {[user [authorization $num]] == "YES"} {nameUser $ID;if {[userKey $ID] == YES} {set a [balance $ID];if {$num==1} {puts "\nYour account balance is $a"} else {puts "Su saldo actual es de $a"}}}}
         "2" {if {[user [authorization $num]] == "YES"} {nameUser $ID;if {[userKey $ID] == YES} {Deposit $ID}}}
         "3" {if {[user [authorization $num]] == "YES"} {nameUser $ID;if {[userKey $ID] == YES} {CashWithdrawal $ID}}}
         default {[mainWindow 1]}
      }
   }
}
eval "cls"
main

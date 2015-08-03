#Code for Python2
'''
   ATM machine software
   It is split into a several functions such as:
   Intro: Is the point of start and end of the ATM. I the welcome screen
   user_language: Select the optimal language for the user
   Personal_ID: Is the process to verify if the user have an account.
   Personal_key: Verify that client have and knows the personal key to get into the account.
   Account_balance: Returns the balance of the account.
   Deposit_funds: Makes a raise into the account, adding the new deposit into the account balance.
   Withdraw_funs: Makes a subtraction of the account.
   Transfer_funds: Makes a transfers to the funds to another client of the bank.
'''
#Client's database of the ATM machine 
users_db={}
user_mike={}
user_mike={'name':"Michael",'lastName':"Mejias",'user_key':12012,'user_id':11121,'balance':20000}
users_db={11121:user_mike}
user_juan={'name':"Juan",'lastName':"Perez",'user_key':11011,'user_id':11131,'balance':25000}
users_db[11131]=user_juan

def user_language():
   global lang
   '''
      Provides the selected language, to translate the text according the selected language by the user
      The function returns:
      1- English
      2- Espanol
   '''
   text="\n\tWelcome to ATM Machine\n\n\tPlease select your language\n\n\n\tBienvenido al Cajero Automatico\n\n\tPor favor ingrese su idioma preferido: \n\n\t1- English\n\t2- Espanol\n"
   lang=input(text)

   
def user_select():
   global lang
   option = 0
   '''
      The function consumes and integer and returns a menu with options to select
   '''
   if lang == 1:
      text="\n\n\tPlease select an option to continue:\n\n\t1- Account Balance\n\n\t2- Deposit Funds\n\n\t3- Transfer Funds\n\n\t4- WithDraw Funds\n"
   else:
      text="\n\n\tPor favor seleccione una opcion:\n\n\t1- Balance de cuenta\n\n\t2- Depositos\n\n\t3- Transferencias\n\n\t4- Retiros de Dinero\n"
   option=input(text)
  
   return option



def account_balance(user_id):
   global users_db,lang
   '''
      The function retrieves the account balance of the user, and return the available funds for the client.
   '''
   b=1
   b=users_db[user_id]['balance']
   if lang==1:
      print "\n\n\tThe current balance of your account is: ",b
   else:
      print "\n\n\tEl balance de su cuenta es de: ",b

def deposit_funds(user_id):
   global users_db,lang
   '''
      The function consumes an user_id to increase the mount into the account balance.
   '''
   if lang == 1:
      text="\n\tPlease insert the mount of the deposit: \n"
      text1="\n\tThe deposit was successful\n"
   else:
      text="\n\tPorfavor ingrese el monto del deposito: \n"
      text1="\n\tEl deposito se ha realizado con exito\n"
   
   deposit=0
   balance=0
   deposit=input(text)
   balance=users_db[user_id]['balance']
   users_db[user_id]['balance']=balance+deposit
   print text1
   account_balance(user_id)

def cash_withDraw(user_id):
   global users_db,lang
   '''
      The function consumes an user_id to substract the mount into the account balance.
   '''
   if lang == 1:
      text="\n\tPlease insert the mount of the withDraw: \n"
      text1="\n\tThe cash withdraw was successful\n"
      text2="\n\tPlease verify the mount, you don't have enough funds.\n"
   else:
      text="\n\tPorfavor ingrese el monto del retiro: \n"
      text1="\n\tEl retiro se ha realizado con exito\n"
      text2="\n\tPorfavor verifique el monto, usted no posee fondos suficientes.\n"
   
   withdraw=0
   balance=0
   withdraw=input(text)
   balance=users_db[user_id]['balance']
   if withdraw >= balance:
      print text2
      user_end()
   else:
      users_db[user_id]['balance']=balance-withdraw
      print text1
      account_balance(user_id)
   

def user_validation(user_id):
   global users_db
   '''
      The function tries to validate the user ID into the data base.
      Consumes an ID and returns true or false.
   '''
   result = False
   result = user_id in users_db
   return result


def funds_transfer(user_id):
   global users_db,lang
   '''
      The function tries to transfer funds between two clients.
   '''
   if lang == 1:
      text="\n\tPlease insert the ID of the client who will transfer the funds: \n"
      text1="\n\tThe transfer was successful\n"
      text2="\n\tPlease verify the mount, you don't have enough funds.\n"
      text3="\n\tPlease insert the amount of the transfer\n"
   else:
      text="\n\tPorfavor ingrese el ID del cliente a transferir fondos: \n"
      text1="\n\tLa transferencia se ha realizado con exito\n"
      text2="\n\tPorfavor verifique el monto, usted no posee fondos suficientes.\n"
      text3="\n\tPorfavor inserte el monto de la transferencia\n"
   user_id1=input(text)
   if user_validation(user_id1):
      transfer=input(text3)
      balance=users_db[user_id]['balance']
      balance_remote=users_db[user_id1]['balance']
      if transfer >= balance:
         print text2
         user_end()
      else:
         users_db[user_id]['balance']=balance-transfer
         users_db[user_id1]['balance']=balance_remote+transfer
         print text1
         account_balance(user_id)


def user_authorization(user_id):
   '''
   The function consumes a user_id and returns the name and last name of the client.
   '''
   global users_db,lang
   user_name=users_db[user_id]['name']
   user_last=users_db[user_id]['lastName']
   
   if lang ==1:
      text="\n\n\tWelcome "
      text1="\n\tPlease insert your secret key: \n"
      text2="\n\tYour secret key is not valid, Please try again.\n"
   else:
      text="\n\n\tBienvenido "
      text1="\n\tPorfavor ingrese su clave secreta: \n"
      text2="\n\tLa clave introducida es incorrecta, Porfvor intentelo de nuevo\n"
   key=input(text1)
   if key == users_db[user_id]['user_key']:
      print text
      print "\n\t\t",user_name,user_last
   else:
      print text2
      user_end()
def user_end():
   global lang
   if lang == 1:
      print "\n\n\tThank you for using our ATM MACHINE.\n"
      welcome_screen()
   else:
      print "\n\n\tMuchas Gracias por usar nuestros Cajeros Automaticos.\n"
      welcome_screen()

def user_continue():
   global lang
   option = 0
   if lang == 1:
      text="\n\tWould you like to exit?\n\t0- YES\n\t1- NO\n"
   else:
      text="\n\tDeseas salir del sistema?\n\t0- SI\n\t1- NO\n"
   option=input(text)
   return option
      
def insert_id():
   global lang
   '''
      The functions returns the require user_id
   '''
   if lang == 1:
      text="\n\tPlease insert you ID to continue...\n"
   else:
      text="\n\tPorfavor ingrese su identificacion...\n"
   
   user_id=1
   user_id=input(text)
   return user_id

def welcome_screen():
   global lang
   lang=0
   option=0
   '''The welcome screen provides the minimal information to the ATM machine's user to select a next step. '''
   while lang == 0:
      user_language()
   user_id=insert_id()
   if user_validation(user_id):
      user_authorization(user_id)
      option=user_select()
      if option == 1:
         balance=account_balance(user_id)    
      elif option == 2:
         deposit_funds(user_id)            
      elif option == 3:
         funds_transfer(user_id)
      elif option == 4:
         cash_withDraw(user_id)
   else:
      if lang == 1:
         text="\n\tThe User ID is not correct\n\n\tPlease confirm it and try again.\n"
      else:
         text="\n\tEl usuario no es correcto.\n\n\tPorfavor verifiquelo y trate de nuevo.\n"
      print text
      user_end()

   user_end()

   

welcome_screen() 

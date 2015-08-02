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


def user_language():
   global lang
   '''
      Provides the selected language, to translate the text according the selected language by the user
      The function returns:
      1- English
      2- Español
   '''
   text="Please select your language / Por favor ingrese su idioma preferido: \n1- English\n2- Español\n"
   lang=input(text)

   
  
   
def user_select():
   global lang
   option = 0
   '''
      The function consumes and integer and returns a menu with options to select
   '''
   if lang == 1:
      text="Please select an option to continue:\n1- Account Balance\n2-Deposit Funds\n3-Transfer Funds\n4-WithDraw Funds\n"
   else:
      text="Por favor seleccione una opcion:\n1-Balance de cuenta\n2-Depostos\n3-Transferencias\n4-Retiros de Dinero\n"
   option=input(text)
   
   return option

#Client's database of the ATM machine 
users_db={}
user_mike={}
user_mike={'name':"Michael",'lastName':"Mejias",'userKey':12012,'user_id':11121,'balance':20000}
users_db={11121:user_mike}
user_juan={'name':"Juan",'lastName':"Perez",'user_key':11011,'user_id':11131,'balance':25000}
users_db[11131]=user_juan


def user_validation(user_id):
   global users_db
   '''
      The function tries to validate the user ID into the data base.
      Consumes an ID and returns true or false.
   '''
   result = False
   result = user_id in users_db
   return result   
   
def welcome_screen():
   global lang
   lang=0
   option=0
   '''The welcome screen provides the minimal information to the ATM machine's user to select a next step. '''
   while lang == 0:
      user_language()
      
   option=user_select()
   
   
   

   

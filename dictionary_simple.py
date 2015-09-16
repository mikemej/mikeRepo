#Cipher
import simpleguitk as simplegui
import random
#CIPHER = {'a':'z','b':'y','c':'x','d':'w','e':'v','f':'u','g':'t','h':'s','i':'r','j':'q',
#         'k':'p','l':'o','m':'n','n':'m','o':'l','p':'k','q':'j','r':'i','s':'h','t':'g','u':'f',
#         'v':'e','w':'d','x':'c','y':'b','z':'a'}
CIPHER = {}
LETTERS = 'abcdefghijklmnopqrstuvwxyz'
message = ""

def init():
    letter_list = list(LETTERS)
    random.shuffle(letter_list)
    for ch in LETTERS:
        CIPHER[ch] = letter_list.pop()
        
#Encode button
def encode():
    emsg = ""
    for ch in message:
        emsg += CIPHER[ch]
    print message, "encode to", emsg

#Decode button
def decode():
    dmsg = ""
    for ch in message:
        #for key in CIPHER:
        for key, value in CIPHER.items():
            if ch == value:
            #if ch == CIPHER[key]:
                dmsg += key
    print message, "decodes to", dmsg

#Update message input
def new_message(msg):
    global message
    message = msg
    label.set_text(msg)

#create frame and assing callbacks to event handlers
frame = simplegui.create_frame("Cipher", 2, 200,200)
frame.add_input("Message: ", new_message, 200)
label = frame.add_label("")
frame.add_button("Encode", encode)
frame.add_button("Decode", decode)

init()

#Start Frame animation
frame.start()



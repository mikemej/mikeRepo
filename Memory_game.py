#http://www.codeskulptor.org/#examples-memory_template.py
# implementation of card game - Memory

import simpleguitk
import random

# helper function to initialize globals
def new_game():
    global state,cards
    state = 0
    cards_list=[0,1,2,3,4,5]
    random.shuffle(cards_list)
    cards_list1=[0,1,2,3,4,5]    
    random.shuffle(cards_list1)
    cards = []
    for i in cards_list+cards_list1:
        cards.append(i)
    print cards

def quit():
    exit()
     
# define event handlers
def mouseclick(pos):
    # add game state logic here
    global state
    if state == 0:
        state = 1
    elif state == 1:
        state = 2
    else:
        state = 1
 
                        
# cards are logically 50x100 pixels in size    
def draw(canvas):
    global cards
    pos_x = 50
    pos_y = 100
    for card in cards:
        canvas.draw_text(str(card), [pos_x,pos_y], 50, "White")
        pos_x += 70    

# create frame and add a button and labels
frame = simpleguitk.create_frame("Memory", 800, 100)
frame.add_button("Reset", new_game)
frame.add_button(" Exit ", quit)
label = frame.add_label("Turns = 0")

# register event handlers
frame.set_mouseclick_handler(mouseclick)
frame.set_draw_handler(draw)

# get things rolling
new_game()
frame.start()


# Always remember to review the grading rubri
'''
# simple state example for Memory

import simplegui
     
# define event handlers
def new_game():
    global state
    state = 0
    
def buttonclick():
    global state
    if state == 0:
        state = 1
    elif state == 1:
        state = 2
    else:
        state = 1
                         
def draw(canvas):
    canvas.draw_text(str(state) + " card exposed", [30, 62], 24, "White")

# create frame and add a button and labels
frame = simplegui.create_frame("Memory states", 200, 100)
frame.add_button("Restart", new_game, 200)
frame.add_button("Simulate mouse click", buttonclick, 200)


# register event handlers
frame.set_draw_handler(draw)

# get things rolling
new_game()
frame.start()
'''

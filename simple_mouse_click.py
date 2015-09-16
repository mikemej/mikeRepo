#simple of mouse input

import simpleguitk as simplegui
import math

#Globals
WIDTH = 450
HEIGHT = 300
ball_pos = [WIDTH / 2, HEIGHT / 2]
BALL_RADIUS = 15
ball_color = "Blue"

#Helper function
def distance(p, q):
    '''
    The function verifies the distance between the circles
    '''
    return math.sqrt((p[0] - q[0]) ** 2 + (p[1] - q[1]) ** 2)
    
    
#define event handler for mouse click, draw
def click(pos):
    global ball_pos,ball_color
    #In this way the ball change the position every single
    #click doing a copy of a list of positions
    #ball_pos = list(pos).
    #Change the color if the distance is grather than the radius
    if distance(pos, ball_pos) < BALL_RADIUS:
        ball_color = "Yellow"
    else:
        ball_pos = list(pos)
        ball_color = "Blue"
    
def draw(canvas):
    canvas.draw_circle(ball_pos, BALL_RADIUS, 1, "Black", ball_color)

#create frame
frame = simplegui.create_frame("Mouse selection", WIDTH, HEIGHT)
frame.set_canvas_background("White")

#register event handler
frame.set_mouseclick_handler(click)
frame.set_draw_handler(draw)

#star frame
frame.start()

#Example of map Magnifier
import simpleguitk
'''
map image
http://commondatastorage.googleapis.com/codeskulptor-assets/gutenberg.jpg
canvas.draw_images(image,source_center,source_size,distance_center,distance_size)
Keep in mind:
1.Attempting to draw before to load finishes cause draw fail. Continues
2.Source rectangle not lying entirely on canvas cause draw to fail. Continues
Gutenberg.jpg 1521 px - 1821 px. too large to draw completely on canvas at full resolution
Scale resolution down by a factor of three and draw reduced resolution image
Click on canvas - disply small portion of image as original resolution around click location
Two call to draw_image:
1.First draw entire map at reduced resolution
2.Second draws magnifier pane around mouse click
'''
link_image = "http://commondatastorage.googleapis.com/codeskulptor-assets/gutenberg.jpg"
image = simpleguitk.load_image(link_image)

#image dimensions
MAP_WIDTH = 1521
MAP_HEIGHT = 1818

#Scaling factor
SCALE = 3

#canvas Size
CANVAS_WIDTH = MAP_WIDTH // SCALE
CANVAS_HEIGHT = MAP_HEIGHT // SCALE

#Size of the magnifier pane and initial center
MAG_SIZE = 120
mag_pos = [CANVAS_WIDTH // 2, CANVAS_HEIGHT // 2]

#Event Handlers
#Move magnifier to cliked position
def click(pos):
    '''
    '''
    global mag_pos
    mag_pos = list(pos)

#Draw map and magnified region
def draw(canvas):
    '''
    '''
    #draw map
    canvas.draw_image(image,
                    [MAP_WIDTH // 2, MAP_HEIGHT // 2], [MAP_WIDTH, MAP_HEIGHT],
                    [CANVAS_WIDTH // 2, CANVAS_HEIGHT // 2], [CANVAS_WIDTH, CANVAS_HEIGHT])
    #draw magnifier
    map_center = [SCALE * mag_pos[0], SCALE * mag_pos[1]]
    map_rectangle = [MAG_SIZE, MAG_SIZE]
    mag_center = mag_pos
    mag_rectangle = [MAG_SIZE, MAG_SIZE]
    canvas.draw_image(image, map_center, map_rectangle, mag_center, mag_rectangle)

#create frame for scaled map
frame = simpleguitk.create_frame("Map Magnifier", CANVAS_WIDTH, CANVAS_HEIGHT)

#register event handlers
frame.set_mouseclick_handler(click)
frame.set_draw_handler(draw)

#start frame
frame.start()

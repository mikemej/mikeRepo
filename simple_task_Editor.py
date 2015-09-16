import simpleguitk as s

tasks=[]
color = "White"
#Handler for button
def clear():
    '''
    The function clears the whole list
    '''
    global tasks
    tasks=[]
    
#Handler for new task
def new(task):
    '''
    The function adds a new item in the list
    '''
    global tasks
    tasks.append(task)
    
    
#Handler for remove number
def remove_number(taskNumber):
    '''
    The function removes the index number of the list
    '''
    global tasks
    if taskNumber > len(tasks) and 0 < taskNumber:
        tasks.pop(int(taskNumber)-1)
    else:
        pass
        
#Handler for remove name
def remove_name(taskName):
    '''
    The function removes the name of the item in the list
    if the name exists.
    '''
    global tasks
    if taskName in tasks:
        tasks.remove(taskName)
    else:
        pass
    
    
#Handler for draw canvas
def draw(canvas):
    global tasks
    '''
    The function prints the items on the list.
    '''
    pos_a = 20
    pos_b = 20
    aux=0
    for i in tasks:
        aux += 1
        canvas.draw_text(str(aux)+' . '+str(i),[pos_a,pos_b],15,"Blue")
        pos_b += 20
   

#create a frame assing callbacks to event handlers
f=s.create_frame("Task List",300,200)
f.set_canvas_background(color)
f.add_input("New Task", new, 200)
f.add_input("Remove Task Number", remove_number,200)
f.add_input("Remove Task Name", remove_name,200)
f.add_button("Clear All",clear)
f.set_draw_handler(draw)

#star the action
f.start()

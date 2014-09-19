from tkinter import *

def on_click():
    global message
    if message is "Welcome!!":
        message = "Good Bye"
        canvas.itemconfig(item,text=message)
    else:
        message = "Welcome!!"
        canvas.itemconfig(item,text=message)

master=Tk()
master.title("Testing Canvas and Text")
master.geometry("500x300")
canvas=Canvas(master)
canvas.config(bg="black")
message="Welcome!!"
item=canvas.create_text([180,100],font=("Pursia",50), fill="red", text=message)
buttonChange=Button(master,text="Change", background="gray", width=3,height=2, command=on_click)
buttonQuit=Button(master,text="Exit", background="gray",width=3,height=2,command=quit)
buttonChange.pack(side=RIGHT)
buttonQuit.pack(side=LEFT)
canvas.pack()
master.mainloop()

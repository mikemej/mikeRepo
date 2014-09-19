from tkinter import *
#The programa does a new window and shows a welcome text message, when you do click the text message changes.
class mainWindow(Canvas):

    def __init__(self,parent=None,*parms,**kparms):
        Canvas.__init__(self, parent, *parms, **kparms)
        self.message="Welcome!!!"
        self.width=300
        self.height=300
        self.config(width=self.width,height=self.height, bg='black')
        self.buttonChange=Button(self, background="gray",width=3,height=1, text="Change", command=self._on_click)
        self.buttonChange.pack(side= RIGHT)
        self.buttonQuit=Button(self, text= "Exit",background="gray", width=3, height=1, command=quit)
        self.buttonQuit.pack(side= LEFT)
        self.pack(fill=BOTH, expand=1)
        self.Text = self.create_text([180,100], text=self.message, font=("Fursia",30), fill="red")
        print(self.message) 
    def _on_click(self):
        global message
        if self.message is "Welcome!!!":
            self.message="Good Bye!!!"
            self.itemconfig(self.Text,text=self.message)
        else:
            self.message="Welcome!!!"
            self.itemconfig(self.Text,text=self.message)
               
class GUI(Tk):
        def __init__(self, *args, **kwargs):
            Tk.__init__(self,*args, **kwargs)
            self.title("Testing Canvas")
            self.geometry("350x350")
            self.addWigets()

        def addWigets(self):
            myCanvas=mainWindow(self)
if __name__== '__main__':
    GUI().mainloop()
